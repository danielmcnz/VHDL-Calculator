----------------------------------------------------------------------------------
--Module Name:
--12bit Tristate Buffer (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Tristate_Buffer_2bit is
    Port ( Load, BTN_Check, Flag_in: in std_logic;
           Flag_out: out std_logic;
           Input: in std_logic_vector (1 downto 0);	-- Input BCD vector
    	   Output: out	std_logic_vector (1 downto 0));	
end Tristate_Buffer_2bit;

architecture Behavioral of Tristate_Buffer_2bit is

begin

    Output <= Input when (Load = '1' and BTN_Check = '1') else "ZZ"; --output becomes the input when load is active and the middle button is pressed (for entering operator into 2bit register)
    Flag_out <= Flag_in when (Load = '1' and BTN_Check = '1') else 'Z'; --flag used for knowing that a value has been entered into the 2bit register

end Behavioral;
