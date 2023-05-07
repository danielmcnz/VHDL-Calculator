----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2023 11:29:40
-- Design Name: 
-- Module Name: Register_12bit - Behavioral
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

entity Register_2bit is
    port ( Input: in std_logic_vector (1 downto 0);
           Output: out std_logic_vector (1 downto 0);
           Load, BTN_Check, Flag: in std_logic);
end Register_2bit;

architecture Behavioral of Register_2bit is
Component Tristate_Buffer_2bit
    Port ( Load, BTN_Check, Flag_in: in std_logic;
           Flag_out: out std_logic;
           Input: in std_logic_vector (1 downto 0);	-- Input BCD vector
    	   Output: out	std_logic_vector (1 downto 0));
end Component;

begin

Buffer_In : Tristate_Buffer_2bit port map(Load => Load, Input => Input, Output => Output, BTN_Check => BTN_Check, Flag_in => Flag, Flag_out => temp_flag);

Output <= temp_output when (BTN_Check = '1' and Load = '1');

end Behavioral;
