----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2023 11:28:09
-- Design Name: 
-- Module Name: 12bit_Register - Behavioral
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

entity Register_12bit is
    port ( Input: in std_logic_vector (11 downto 0);
           Output: out std_logic_vector (11 downto 0);
           Load, BTN_Check: in std_logic);
end Register_12bit;

architecture Behavioral of Register_12bit is
Component Tristate_Buffer_12bit
    Port ( Load, BTN_Check: in std_logic;
           Input: in std_logic_vector (11 downto 0);	-- Input BCD vector
    	   Output: out	std_logic_vector (11 downto 0));
end Component;

begin

Buffer_In : Tristate_Buffer_12bit port map(Load => Load, Input => Input, Output => Output, BTN_Check => BTN_Check);

end Behavioral;