----------------------------------------------------------------------------------
--Module Name:
--Twos Complement Converter (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Twos_Complement is
    port (
            Input: in std_logic_vector (23 downto 0);   -- 24-Bit Vector Input To be Inverted
            Output: out std_logic_vector (23 downto 0)  -- Inverted 24-Bit Output
          );
end Twos_Complement;

architecture Behavioral of Twos_Complement is

signal holding_val: std_logic_vector (23 downto 0);     -- Temporary Value to be Updated in the Process

begin

process (Input) -- When Input Value Changes
begin

    holding_val <= (not Input) + 1; -- Inverts Input Using "not" and Adds 1

end process;

Output <= holding_val;  -- Assigns Adjusted Value to the Output

end Behavioral;
