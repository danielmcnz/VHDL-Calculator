----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2023 15:43:27
-- Design Name: 
-- Module Name: ALU - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port (Register_0, Register_2: in std_logic_vector (11 downto 0);
          Register_1: in std_logic_vector (1 downto 0);
          Output: out std_logic_vector (23 downto 0);
          Calculate, Sign_Reg_0, Sign_Reg_2: in std_logic;
          Sign_output: out std_logic);
end ALU;

architecture Behavioral of ALU is

component Twos_Complement
    Port (
            Input: in std_logic_vector (23 downto 0);
            Output: out std_logic_vector (23 downto 0)
            );
end component;

signal reg_0, reg_2, reg_0_invert, reg_2_invert, temp_output_invert, temp_output: std_logic_vector (23 downto 0);

begin

Invert_0: Twos_Complement port map(Input => reg_0, Output => reg_0_invert);
Invert_2: Twos_Complement port map(Input => reg_2, Output => reg_2_invert);
Invert_temp_output: Twos_Complement port map(Input => temp_output, Output => temp_output_invert);

reg_0 <= std_logic_vector(resize(unsigned(Register_0), reg_0'length));
reg_2 <= std_logic_vector(resize(unsigned(Register_2), reg_0'length));

--Operations
process (Calculate)
begin
    Sign_output <= '0'; --assume positive output unless otherwise stated
    if (Register_1 = "00") then --ADDITION
        if (((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1')) or ((not (Sign_Reg_0 = '1')) and (not (Sign_Reg_2 = '1')))) then
            Output <= (reg_0 + reg_2);
            if (Sign_Reg_0 = '1') then
                Sign_output <= '1';
            end if;
        elsif (reg_0 = reg_2) then
                Output <= "000000000000000000000000";
        elsif ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then
            if (not (Sign_Reg_0 = '1')) then
                if (reg_0 > reg_2) then
                    Output <= (reg_0 + reg_2_invert);
                elsif (reg_0 < reg_2) then
                    temp_output <= (reg_0 + reg_2_invert);
                    Output <= temp_output_invert;
                    Sign_output <= '1';
                end if;
            elsif (Sign_Reg_0 = '1') then
                if (reg_0 > reg_2) then
                    temp_output <= (reg_0_invert + reg_2);
                    Output <= temp_output_invert;
                    Sign_output <= '1';
                elsif (reg_0 < reg_2) then
                    Output <= (reg_0_invert + reg_2);
                end if;
            end if;
        end if;
        
    elsif (Register_1 = "01") then --SUBTRACTION
        if ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then
            Output <= (reg_0 + reg_2);
            if (Sign_Reg_0 = '1') then
                Sign_output <= '1';
            end if;
        elsif (not ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1'))) then
            temp_output <= (reg_0 + reg_2_invert);
            Output <= temp_output;
            if (reg_0 < reg_2) then
                Output <= temp_output_invert;
                Sign_output <= '1';
            end if;
        elsif ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1')) then
            temp_output <= (reg_0_invert + reg_2);
            Output <= temp_output;
            if (reg_0 > reg_2) then
                Output <= temp_output_invert;
                Sign_output <= '1';
            end if;
        elsif (((((not (Sign_Reg_0 = '1')) and (not (Sign_Reg_2 = '1')))) or ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1'))) and (reg_0 = reg_2)) then
            Output <= "000000000000000000000000";
        end if;
        
    elsif (Register_1 = "10") then --MULTIPLICATION
        Output <= (Register_0 * Register_2);
        if ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then
            Sign_output <= '1';
        end if;
        if ((Register_0 * Register_2) > "100110111000001000101111") then --9,999,999
            Output <= "000000000000000000000000";
        end if;
        
    elsif (Register_1 = "11") then --SQUARED
        Output <= (Register_0 * Register_0);
        if ((Register_0 * Register_0) > "100110111000001000101111") then --9,999,999
            Output <= "000000000000000000000000";
        end if;
    end if;
end process;
end Behavioral;