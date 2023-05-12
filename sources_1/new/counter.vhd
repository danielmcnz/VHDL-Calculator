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
    Port (
            CLK : in std_logic;                     -- 15KHz Clock Input
            CO : out std_logic_vector (2 downto 0)  -- 3-Bit Counter Output
          );  
end counter;

architecture Behavioral of counter is

signal count : std_logic_vector (2 downto 0);   -- Current Temp Count for Inside the Process

begin
    process (CLK)   -- When Change in Clock
    begin
        if (CLK'event and CLK = '1') then   -- Clock Rising Edge
            if (count = "111") then         -- If Max 3-Bit Binary Value
                count <= "000";             -- Reset Back to "000"
                
            else
                count <= count + 1;         -- Adds 1 to the Current Count
            end if;
        end if;
    end process;
    CO <= count;    -- Assign Temp Count to the Output Count
end Behavioral;