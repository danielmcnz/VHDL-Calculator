----------------------------------------------------------------------------------
--Module Name:
--12bit Register (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register_12bit is
    port ( Input: in std_logic_vector (11 downto 0);
           Output: out std_logic_vector (11 downto 0);
           Load, BTN_Check, Flag_in: in std_logic;
           Flag_out: out std_logic);
end Register_12bit;

architecture Behavioral of Register_12bit is

signal temp_output: std_logic_vector (11 downto 0) := "000000000000";
signal temp_flag: std_logic := '0';

begin

process(BTN_Check) is
begin
    if (Load = '1' and BTN_Check = '1') then
        
        temp_output <= Input;
        temp_flag <= Flag_in;
        
    end if;
end process;

Output <= temp_output;
Flag_out <= temp_flag;

end Behavioral;