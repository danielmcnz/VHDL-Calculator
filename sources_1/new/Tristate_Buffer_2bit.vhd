----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2023 11:17:15
-- Design Name: 
-- Module Name: Tristate_Buffer - Behavioral
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

entity Tristate_Buffer_2bit is
    Port ( Load, BTN_Check, Flag_in: in std_logic;
           Flag_out: out std_logic;
           Input: in std_logic_vector (1 downto 0);	-- Input BCD vector
    	   Output: out	std_logic_vector (1 downto 0));	
end Tristate_Buffer_2bit;

architecture Behavioral of Tristate_Buffer_2bit is

begin

    Output <= Input when (Load = '1' and BTN_Check = '1') else "ZZ";
    Flag_out <= Flag_in when (Load = '1' and BTN_Check = '1') else 'Z';

end Behavioral;
