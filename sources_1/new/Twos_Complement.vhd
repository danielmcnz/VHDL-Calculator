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
    Port (
            Input: in std_logic_vector (23 downto 0);
            Output: out std_logic_vector (23 downto 0)
            );
end Twos_Complement;

architecture Behavioral of Twos_Complement is

signal holding_val: std_logic_vector (23 downto 0);

begin

process (Input)
begin

    holding_val <= (not Input) + 1; --invert and add one

end process;

Output <= holding_val;

end Behavioral;
