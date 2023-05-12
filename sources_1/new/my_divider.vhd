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


entity my_divider is
    Port (
            Clk_in : in  STD_LOGIC;          -- System Clock
            Clk_out_15KHz : out  STD_LOGIC   -- 15KHz Clock
         );
			  	
end my_divider;

architecture Behavioral of my_divider is

    constant clk_limit : std_logic_vector(15 downto 0) := X"1A0A";  -- Setting Constant Limit of 6666

	signal clk_ctr : std_logic_vector(15 downto 0); -- This is the Counter that Counts up to Limit
	signal temp_clk : std_logic;                    -- Temporary Clock to set in Process

begin

	clock_15KHz: process (Clk_in)

		begin
		if Clk_in = '1' and Clk_in'Event then
		  if clk_ctr = clk_limit then				-- Checks if Counter has Hit Limit
		  	 temp_clk <= not temp_clk;				--  Toggle Temp Clock
			 clk_ctr <= X"0000";					--  Reset Counter
		  else											
		  	 clk_ctr <= clk_ctr + X"0001";	        --  Adds 1 to Counter
		  end if;
		end if;

	end process clock_15KHz;
    
	Clk_out_15KHz <= temp_clk;                      -- Assigns Temp Clock to the Output

end Behavioral;

