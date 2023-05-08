----------------------------------------------------------------------------------
-- Company:  UC, ECE
-- Lecturer: Steve Weddell
-- 
-- Create Date:    23:24:33 02/07/2011 
-- Revised Date:   22:01:20 04/03/2019
-- Design Name: 
-- Module Name:    my_divider - Behavioral 
-- Project Name: 	For ENEL373 course on digital logic
-- Target Devices: Any
-- Tool versions:  Any
-- Description:   This clock divider will take a 100MHz clock and divide it down to 1Hz
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_divider is
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out_1Hz, Clk_out_40Hz, Clk_out_512Hz : out  STD_LOGIC);
			  
-- attributes - these are not needed, as they are provided in the constraints file	
end my_divider;

architecture Behavioral of my_divider is
--
--	constant clk_limit : std_logic_vector(27 downto 0) := X"17D783F"; -- 2 Hz output
    constant clk_limit_1 : std_logic_vector(27 downto 0) := X"2FAF080"; -- 1 Hz   "
    constant clk_limit_2 : std_logic_vector(23 downto 0) := X"2625A0";   -- 40 Hz   "
    constant clk_limit_3 : std_logic_vector(15 downto 0) := X"BEBC";   -- 2048 Hz   "

	signal clk_ctr_1 : std_logic_vector(27 downto 0);
	signal clk_ctr_2 : std_logic_vector(23 downto 0);
	signal clk_ctr_3 : std_logic_vector(15 downto 0);
	signal temp_clk_1, temp_clk_2, temp_clk_3 : std_logic;

begin

 	clock_1Hz: process (Clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr_1 = clk_limit_1 then				-- if counter == (1Hz count)/2
		  	 temp_clk_1 <= not temp_clk_1;				--  toggle clock
			 clk_ctr_1 <= X"0000000";					--  reset counter
		  else											-- else
		  	 clk_ctr_1 <= clk_ctr_1 + X"0000001";	--  counter = counter + 1
		  end if;
		end if;

	end process clock_1Hz;
    
    clock_40Hz: process (Clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr_2 = clk_limit_2 then				-- if counter == (1Hz count)/2
		  	 temp_clk_2 <= not temp_clk_2;				--  toggle clock
			 clk_ctr_2 <= X"000000";					--  reset counter
		  else											-- else
		  	 clk_ctr_2 <= clk_ctr_2 + X"000001";	--  counter = counter + 1
		  end if;
		end if;

	end process clock_40Hz;
	
	clock_512Hz: process (Clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr_3 = clk_limit_3 then				-- if counter == (1Hz count)/2
		  	 temp_clk_3 <= not temp_clk_3;				--  toggle clock
			 clk_ctr_3 <= X"0000";					--  reset counter
		  else											-- else
		  	 clk_ctr_3 <= clk_ctr_3 + X"0001";	--  counter = counter + 1
		  end if;
		end if;

	end process clock_512Hz;
    
	Clk_out_1Hz <= temp_clk_1;	
	Clk_out_40Hz <= temp_clk_2;
	Clk_out_512Hz <= temp_clk_3;

end Behavioral;

