----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2023 17:39:43
-- Design Name: 
-- Module Name: TB_Twos_Complement - Behavioral
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

entity TB_Twos_Complement is
--  Port ( );
end TB_Twos_Complement;

architecture Behavioral of TB_Twos_Complement is

component Twos_Complement
    Port (
            Input: in std_logic_vector (11 downto 0);
            Output: out std_logic_vector (11 downto 0)
            );
end component;

signal Input, Output: std_logic_vector (11 downto 0);

begin

UUT: Twos_Complement port map(Input => Input, Output => Output);

Input <= "111111111111";

end Behavioral;
