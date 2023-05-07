----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2023 16:15:45
-- Design Name: 
-- Module Name: Debouncing - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncing is
    Port (
            Clk_in, BTN: in std_logic;
            Debounced_Button: out std_logic
            );
end Debouncing;

architecture Behavioral of Debouncing is

signal b1, b2, b3, b4, b5, b6, b7: std_logic;

begin

    process (Clk_in)
    begin
        if (Clk_in = '1' and Clk_in'event) then
            b1 <= BTN;
            b2 <= b1;
            b3 <= b2;
            b4 <= b3;
            b5 <= b4;
            b6 <= b5;
            b7 <= b6;
        end if;
    end process;

Debounced_Button <= BTN and b1 and b2 and b3 and b4 and b5 and b6 and b7;

end Behavioral;
