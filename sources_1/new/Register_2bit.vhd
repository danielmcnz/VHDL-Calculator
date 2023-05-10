----------------------------------------------------------------------------------
--Module Name:
--2bit Register (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register_2bit is
    port ( Input: in std_logic_vector (1 downto 0);
           Output: out std_logic_vector (1 downto 0);
           Load, BTN_Check: in std_logic);
end Register_2bit;

architecture Behavioral of Register_2bit is

signal temp_output: std_logic_vector (1 downto 0) := "00";

begin

process(BTN_Check) is
begin
    if (Load = '1' and BTN_Check = '1') then
            
        temp_output <= Input;
        
    end if;
end process;

Output <= temp_output;

end Behavioral;