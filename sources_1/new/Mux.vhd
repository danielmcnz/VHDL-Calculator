----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2023 12:58:34
-- Design Name: 
-- Module Name: Mux - Behavioral
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

entity Mux is
  Port (Selector : in std_logic_vector (2 downto 0);
        Input_0, Input_1, Input_2, Input_3, Input_4, Input_5, Input_6, Input_7 : in std_logic_vector (6 downto 0);
        Output : out std_logic_vector (6 downto 0);
        Output_Display : out std_logic_vector (7 downto 0)
        );
end Mux;

architecture Behavioral of Mux is

begin
    
    process (Selector)
    begin
        case Selector is
            when "000" => Output <= Input_0; 
            when "001" => Output <= Input_1; 
            when "010" => Output <= Input_2;
            when "011" => Output <= Input_3;
            when "100" => Output <= Input_4; 
            when "101" => Output <= Input_5;
            when "110" => Output <= Input_6;
            when others => Output <= Input_7; 
        end case;
    
    end process;
    
    process (Selector)
    begin
        case Selector is
            when "000" => Output_Display <= "11111110"; 
            when "001" => Output_Display <= "11111101"; 
            when "010" => Output_Display <= "11111011";
            when "011" => Output_Display <= "11110111";
            when "100" => Output_Display <= "11101111"; 
            when "101" => Output_Display <= "11011111";
            when "110" => Output_Display <= "10111111";
            when others => Output_Display <= "01111111"; 
        end case;
    
    end process;

end Behavioral;
