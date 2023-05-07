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
          Output: out std_logic_vector (11 downto 0);
          Calculate: in std_logic);
end ALU;

architecture Behavioral of ALU is

component Twos_Complement
    Port (
            Input: in std_logic_vector (11 downto 0);
            Output: out std_logic_vector (11 downto 0)
            );
end component;

signal reg_0_invert, reg_2_invert, temp_output_invert, temp_output: std_logic_vector (11 downto 0);

begin

Invert_0: Twos_Complement port map(Input => Register_0, Output => reg_0_invert);
Invert_2: Twos_Complement port map(Input => Register_2, Output => reg_2_invert);
Invert_temp_output: Twos_Complement port map(Input => temp_output, Output => temp_output_invert);

process (Calculate)
begin
    
    if (Register_1 = "00") then
        if () then
            
        end if;
    end if;
    
end process;

Output <= temp_output;

end Behavioral;
