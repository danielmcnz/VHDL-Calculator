----------------------------------------------------------------------------------
--Module Name:
--Display (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;


entity Display is
    Port (
            Input: in std_logic_vector (23 downto 0);                                   -- Calculated resized 24-bit Value
            CA: out std_logic_vector (6 downto 0);                                      -- 7-Seg Display Segments
            AN: out std_logic_vector (7 downto 0);                                      -- 7-Seg Display Chosing
            State, Opcode: in std_logic_vector (1 downto 0);                            -- Vectors for Deciding on Whats Being Displayed
            CLK_15KHz, RESET, CLK_100MHz, Negative_Sign, Overflow_Flag: in std_logic    -- Input Bits for Display Component
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
		   Port ( bcd_in: in std_logic_vector (3 downto 0);	  -- Input BCD vector
    			leds_out: out std_logic_vector (6 downto 0)); -- Output 7-Seg vector 
end Component;

Component counter
    Port (
            CLK : in std_logic;
            CO : out std_logic_vector (2 downto 0)
            );
end Component;

Component Mux
    Port (
            Negative_Sign, Overflow_Flag: in std_logic;                                                         -- negative and overflown sign flags for the outputted number on the 7 segment displays
            Selector : in std_logic_vector (2 downto 0);                                                        -- determines which 7 segment display is active at any given time
            State, Opcode: in std_logic_vector (1 downto 0);                                                    -- current state from the state machine and the inputted op code for the current calculation
            Input_0, Input_1, Input_2, Input_3, Input_4, Input_5, Input_6 : in std_logic_vector (6 downto 0);   -- multiplexer inputs for the 7 segment display segments
            Output : out std_logic_vector (6 downto 0);                                                         -- output of the mux
            Output_Display : out std_logic_vector (7 downto 0)                                                  -- values for each segment of any given display 
            );
end Component;

-- signals for the display
signal bcd_temp, able: std_logic_vector (27 downto 0);
signal led_disp_0, led_disp_1, led_disp_2, led_disp_3, led_disp_4, led_disp_5, led_disp_6 : std_logic_vector (6 downto 0);
signal selector: std_logic_vector (2 downto 0);
signal start, ready: std_logic;

begin

-- counter for the multiplexer to determine which 7 segment display to activate at the current point in time
count_to_8: counter port map(CLK => CLK_15KHz, CO => selector);

-- converts the given binary input number to a BCD to be used for the ALU
Dec_BCD: bin_to_bcd port map(reset => RESET, clock => CLK_100MHz, start => CLK_15KHz, bin => Input, bcd => bcd_temp, ready => ready);

-- maps 4-bits to each 7 segment display from the BCD input to display the given number
BCD_7seg_0: BCD_to_7SEG port map(bcd_in => bcd_temp (3 downto 0), leds_out => led_disp_0);
BCD_7seg_1: BCD_to_7SEG port map(bcd_in => bcd_temp (7 downto 4), leds_out => led_disp_1);
BCD_7seg_2: BCD_to_7SEG port map(bcd_in => bcd_temp (11 downto 8), leds_out => led_disp_2);
BCD_7seg_3: BCD_to_7SEG port map(bcd_in => bcd_temp (15 downto 12), leds_out => led_disp_3);
BCD_7seg_4: BCD_to_7SEG port map(bcd_in => bcd_temp (19 downto 16), leds_out => led_disp_4);
BCD_7seg_5: BCD_to_7SEG port map(bcd_in => bcd_temp (23 downto 20), leds_out => led_disp_5);
BCD_7seg_6: BCD_to_7SEG port map(bcd_in => bcd_temp (27 downto 24), leds_out => led_disp_6);

-- sends the value of each seven segment display to the multiplexer to multiplex the display output
Multiplexer: Mux port map(Selector => selector, Input_0 => led_disp_0, Input_1 => led_disp_1, Input_2 => led_disp_2, Input_3 => led_disp_3, Input_4 => led_disp_4, Input_5 => led_disp_5, Input_6 => led_disp_6, Negative_Sign => Negative_Sign, Output => CA, Output_Display => AN, Overflow_Flag => Overflow_Flag, State => State, Opcode => Opcode);

end Behavioral;
