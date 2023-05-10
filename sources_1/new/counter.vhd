----------------------------------------------------------------------------------
--Module Name:
--Counter (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;


entity counter is
    Port (CLK : in std_logic;
          CO : out std_logic_vector (2 downto 0));
end counter;

architecture Behavioral of counter is

signal count : std_logic_vector (2 downto 0);
signal count_out : std_logic;

begin
    process (CLK) is
    begin
        if (CLK'event and CLK = '1') then
            if (count = "111") then
                count <= "000";
                
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    CO <= count;
end Behavioral;