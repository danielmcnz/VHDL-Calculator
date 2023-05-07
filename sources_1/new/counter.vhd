----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.03.2023 12:20:52
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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