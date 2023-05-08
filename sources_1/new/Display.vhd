----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2023 14:31:48
-- Design Name: 
-- Module Name: Display - Behavioral
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
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Display is
    Port (
            Input: in std_logic_vector (23 downto 0);
            CA: out std_logic_vector (6 downto 0);
            AN: out std_logic_vector (7 downto 0);
            State, Opcode: in std_logic_vector (1 downto 0);
            CLK_40HZ, CLK_512Hz, RESET, CLK_100MHz, Negative_Sign, Overflow_Flag: in std_logic
            );
end Display;

architecture Behavioral of Display is

Component bin_to_bcd
    generic (
            BCD_SIZE : integer := 28; --! Length of BCD signal
            NUM_SIZE : integer := 24 --! Length of binary input
        );
    port (
            reset : in std_logic;                                --! Asynchronous reset
            clock : in std_logic;                                --! System clock
            start : in std_logic;                                --! Assert to start conversion
            bin   : in std_logic_vector(NUM_SIZE - 1 downto 0);  --! Binary input
            bcd   : out std_logic_vector(BCD_SIZE - 1 downto 0); --! Binary coded decimal output
            ready : out std_logic                                --! Asserted once conversion is finished
        );
end Component;

Component BCD_to_7SEG
		   Port ( bcd_in: in std_logic_vector (3 downto 0);	-- Input BCD vector
    			leds_out: out std_logic_vector (6 downto 0));		-- Output 7-Seg vector 
end Component;

Component counter
    Port (
            CLK : in std_logic;
            CO : out std_logic_vector (2 downto 0)
            );
end Component;

Component Mux
    Port (
            Negative_Sign, Overflow_Flag: in std_logic;
            Selector : in std_logic_vector (2 downto 0);
            State, Opcode: in std_logic_vector (1 downto 0);
            Input_0, Input_1, Input_2, Input_3, Input_4, Input_5, Input_6 : in std_logic_vector (6 downto 0);
            Output : out std_logic_vector (6 downto 0);
            Output_Display : out std_logic_vector (7 downto 0)
            );
end Component;

signal bcd_temp, able: std_logic_vector (27 downto 0);
signal led_disp_0, led_disp_1, led_disp_2, led_disp_3, led_disp_4, led_disp_5, led_disp_6 : std_logic_vector (6 downto 0);
signal selector: std_logic_vector (2 downto 0);
signal start, ready: std_logic;

begin

count_to_8: counter port map(CLK => CLK_512HZ, CO => selector);

Dec_BCD: bin_to_bcd port map(reset => RESET, clock => CLK_100MHz, start => CLK_512HZ, bin => Input, bcd => bcd_temp, ready => ready);
--Dec_BCD: bin_to_bcd port map(reset => RESET, clock => CLK_100MHz, start => CLK_40HZ, bin => Input, bcd => bcd_temp, ready => ready);

BCD_7seg_0: BCD_to_7SEG port map(bcd_in => bcd_temp (3 downto 0), leds_out => led_disp_0);
BCD_7seg_1: BCD_to_7SEG port map(bcd_in => bcd_temp (7 downto 4), leds_out => led_disp_1);
BCD_7seg_2: BCD_to_7SEG port map(bcd_in => bcd_temp (11 downto 8), leds_out => led_disp_2);
BCD_7seg_3: BCD_to_7SEG port map(bcd_in => bcd_temp (15 downto 12), leds_out => led_disp_3);
BCD_7seg_4: BCD_to_7SEG port map(bcd_in => bcd_temp (19 downto 16), leds_out => led_disp_4);
BCD_7seg_5: BCD_to_7SEG port map(bcd_in => bcd_temp (23 downto 20), leds_out => led_disp_5);
BCD_7seg_6: BCD_to_7SEG port map(bcd_in => bcd_temp (27 downto 24), leds_out => led_disp_6);

Multiplexer: Mux port map(Selector => selector, Input_0 => led_disp_0, Input_1 => led_disp_1, Input_2 => led_disp_2, Input_3 => led_disp_3, Input_4 => led_disp_4, Input_5 => led_disp_5, Input_6 => led_disp_6, Negative_Sign => Negative_Sign, Output => CA, Output_Display => AN, Overflow_Flag => Overflow_Flag, State => State, Opcode => Opcode);

--able <= "1001100001110110010101000011";

end Behavioral;
