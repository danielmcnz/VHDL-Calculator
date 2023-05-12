----------------------------------------------------------------------------------
--Module Name:
--Calculator (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Calculator is
    Port (
            BTNC, BTNR : in std_logic;               -- FGPA Button's
            SW: in std_logic_vector (15 downto 0);   -- FGPA Switch's
            LED: out std_logic_vector (15 downto 0); -- FGPA LED's
            CA: out std_logic_vector (6 downto 0);   -- 7-Seg Display Segments
            AN: out std_logic_vector (7 downto 0);   -- 7-Seg Display Chosing
            CLK100MHZ : in std_logic                 --  System Clock
         );               
end Calculator;

architecture Behavioral of Calculator is
Component my_divider
    Port (
            Clk_in : in  STD_LOGIC;          -- System Clock
            Clk_out_15KHz : out  STD_LOGIC   -- 15KHz Clock
         );
end Component;

Component State_Machine
    port(
            BTNC, BTNR, CLK_15KHz, CLK_100MHz, Negative_SW, Reg_View: in std_logic; -- Single Bit Input Flags / Clocks
            LED: out std_logic_vector (15 downto 0);                                -- FGPA LED's
            SW: in std_logic_vector (11 downto 0);                                  -- FGPA Switches
            CA: out std_logic_vector (6 downto 0);                                  -- 7-Seg Display Segments
            AN: out std_logic_vector (7 downto 0)                                   -- 7-Seg Display Chosing
         );
end Component;

Component Debouncing
    Port (
            Clk_in, BTN: in std_logic;      -- Single Bit System Clock / Button Press Input
            Debounced_Button: out std_logic -- Debounced Button Press Output
            );
end Component;

signal btnc_input, btnr_input, CLK15KHZ: std_logic; -- Setting Debounced Button and Divided Clock Signals


begin

Clock: my_divider port map(Clk_in => CLK100MHZ, Clk_out_15KHz => CLK15KHZ);                             -- Getting Dividing System Clock for 15KHz Clock
BTNC_Debouncer: Debouncing port map(Clk_in => CLK100MHZ, BTN => BTNC, Debounced_Button => btnc_input);  -- Debouncing for Center Button
BTNR_Debouncer: Debouncing port map(Clk_in => CLK100MHZ, BTN => BTNR, Debounced_Button => btnr_input);  -- Debouncing for Right Button
SM: State_Machine port map(BTNC => btnc_input, BTNR => btnr_input, CLK_15KHz => CLK15KHz, CLK_100MHz => CLK100MHZ, LED => LED, SW => SW (11 downto 0), CA => CA, AN => AN, Negative_SW => SW(15), Reg_View => SW(14)); -- Calling State Machine and Sending Through Required Flags


end Behavioral;
