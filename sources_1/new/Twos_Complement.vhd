----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2023 17:31:34
-- Design Name: 
-- Module Name: Twos_Complement - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

    holding_val <= (not Input) + 1;

end process;

Output <= holding_val;

end Behavioral;
