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
           Load, BTN_Check: in std_logic);
end Register_2bit;

architecture Behavioral of Register_2bit is

signal temp_output: std_logic_vector (1 downto 0) := "00";

begin

process(BTN_Check) is
begin
    if (Load = '1' and BTN_Check = '1') then
            
        temp_output <= Input;
        
    end if;
end process;

Output <= temp_output;

end Behavioral;
