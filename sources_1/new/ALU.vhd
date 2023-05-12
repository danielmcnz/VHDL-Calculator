----------------------------------------------------------------------------------
--Module Name:
--Arithmetic Logic Unit (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.ALL;


entity ALU is
    Port (
        -- input ports
        Register_0, Register_2: in std_logic_vector (11 downto 0);
        Register_1: in std_logic_vector (1 downto 0);
        
        -- output ports
        Output: out std_logic_vector (23 downto 0);
        Sign_output, Overflow_Flag: out std_logic;
        
        -- control signals
        Calculate, Sign_Reg_0, Sign_Reg_2: in std_logic);
end ALU;

architecture Behavioral of ALU is

-- import twos-complement module
component Twos_Complement
    Port (
            Input: in std_logic_vector (23 downto 0);
            Output: out std_logic_vector (23 downto 0)
            );
end component;

signal reg_0, reg_2, reg_0_invert, reg_2_invert, temp_output_invert, temp_output: std_logic_vector (23 downto 0);

begin

-- instantiate twos complement module for the number registers and output
Invert_0: Twos_Complement port map(Input => reg_0, Output => reg_0_invert);
Invert_2: Twos_Complement port map(Input => reg_2, Output => reg_2_invert);
Invert_temp_output: Twos_Complement port map(Input => temp_output, Output => temp_output_invert);

-- resize the input registers for the ALU calculations and logic
reg_0 <= std_logic_vector(resize(unsigned(Register_0), reg_0'length));
reg_2 <= std_logic_vector(resize(unsigned(Register_2), reg_0'length));

-- arithmetic operations
process (Calculate)
begin
    -- initialize output and flags
    Sign_output <= '0'; --assume positive output unless otherwise stated
    Overflow_Flag <= '0';

    -- addition logic
    if (Register_1 = "00") then
        if (((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1')) or ((not (Sign_Reg_0 = '1')) and (not (Sign_Reg_2 = '1')))) then --check if value signs are equal
            Output <= (reg_0 + reg_2);
            if (Sign_Reg_0 = '1') then --if negative input, make output negative
                Sign_output <= '1';
            end if;
            if ((reg_0 = "000000000000000000000000") and (reg_2 = "000000000000000000000000")) then --if both values are zero, make result zero
                Sign_output <= '0';
            end if;
        elsif (reg_0 = reg_2) then --for the case of values being oppositely signed, make output zero
                Output <= "000000000000000000000000";
        elsif ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then --check if value signs are opposite
            if (not (Sign_Reg_0 = '1')) then --check if first value is positive
                if (reg_0 > reg_2) then --if first value is greater, invert second value
                    Output <= (reg_0 + reg_2_invert);
                elsif (reg_0 < reg_2) then --if second value is greater, invert second value and invert the sum of the values
                    temp_output <= (reg_0 + reg_2_invert);
                    Output <= temp_output_invert;
                    Sign_output <= '1';
                end if;
            elsif (Sign_Reg_0 = '1') then --check if first value is negative
                if (reg_0 > reg_2) then --if first value is greater, invert first value and invert the sum of the values
                    temp_output <= (reg_0_invert + reg_2);
                    Output <= temp_output_invert;
                    Sign_output <= '1';
                elsif (reg_0 < reg_2) then --if second value is greater, invert the first value
                    Output <= (reg_0_invert + reg_2);
                end if;
            end if;
        end if;
        
    -- subtraction logic
    elsif (Register_1 = "01") then
        if ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then --check if value signs are opposite
            Output <= (reg_0 + reg_2);
            if (Sign_Reg_0 = '1') then --check if first value is negative
                Sign_output <= '1';
            end if;
            if ((reg_0 = "000000000000000000000000") and (reg_2 = "000000000000000000000000")) then --if both values are zero, make result zero
                Sign_output <= '0';
            end if;
        elsif (not ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1'))) then --if value signs are both positive, invert second value 
            temp_output <= (reg_0 + reg_2_invert);
            Output <= temp_output;
            if (reg_0 < reg_2) then --if first value greater, invert the temporary sum (with an inverted second value)
                Output <= temp_output_invert;
                Sign_output <= '1';
            end if;
        elsif ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1')) then --if value signs are both negative, invert first value
            temp_output <= (reg_0_invert + reg_2);
            Output <= temp_output;
            if (reg_0 > reg_2) then --if second value greater, invert the temporary sum (with an inverted first value)
                Output <= temp_output_invert;
                Sign_output <= '1';
            end if;
        elsif (((((not (Sign_Reg_0 = '1')) and (not (Sign_Reg_2 = '1')))) or ((Sign_Reg_0 = '1') and (Sign_Reg_2 = '1'))) and (reg_0 = reg_2)) then --check if values are oppositely signed and equal to determine if result should be zero
            Output <= "000000000000000000000000";
        end if;
        
    -- multiplication logic
    elsif (Register_1 = "10") then
        Output <= (Register_0 * Register_2);
        if ((Register_0 * Register_2) > "100110111000001000101111") then --check if result is less than 9,999,999
            Output <= "000000000000000000000000";
            Overflow_Flag <= '1';
        elsif ((Sign_Reg_0 = '1') xor (Sign_Reg_2 = '1')) then --check if values are oppositely signed
            Sign_output <= '1';
        end if;
        if (((Register_0 * Register_2) = "000000000000000000000000") or ((Register_0 * Register_2) > "100110111000001000101111")) then --if result is zero or greater than 9,999,999 than make result zero
            Sign_output <= '0';
        end if;
        
    -- squared logic
    elsif (Register_1 = "11") then
        Output <= (Register_0 * Register_0);
        if ((Register_0 * Register_0) > "100110111000001000101111") then --check if result is less than 9,999,999
            Output <= "000000000000000000000000";
            Overflow_Flag <= '1';
        end if;
    end if;
end process;
end Behavioral;
