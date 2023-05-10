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
    Port ( BTNC, BTNR : in std_logic;
           SW: in std_logic_vector (15 downto 0);
           LED: out std_logic_vector (15 downto 0);
           CA: out std_logic_vector (6 downto 0);
           AN: out std_logic_vector (7 downto 0);
           CLK100MHZ : in std_logic);
end Calculator;

architecture Behavioral of Calculator is
Component my_divider
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out_1Hz, Clk_out_40Hz, Clk_out_512Hz : out  STD_LOGIC);
end Component;

Component State_Machine
    port(BTNC, BTNR, CLK_512Hz, CLK_100MHz, CLK_40HZ, Negative_SW, Reg_View: in std_logic;
         LED: out std_logic_vector (15 downto 0);
         SW: in std_logic_vector (11 downto 0);
         CA: out std_logic_vector (6 downto 0);
         AN: out std_logic_vector (7 downto 0)
         );
end Component;

Component Debouncing
    Port (
            Clk_in, BTN: in std_logic;
            Debounced_Button: out std_logic
            );
end Component;

signal btnc_input, btnr_input, CLK1HZ, CLK_40HZ, CLK512HZ: std_logic;


begin

Clock: my_divider port map(Clk_in => CLK100MHZ, Clk_out_1Hz => CLK1HZ, Clk_out_40Hz => CLK_40HZ, Clk_out_512Hz => CLK512HZ);
BTNC_Debouncer: Debouncing port map(Clk_in => CLK100MHZ, BTN => BTNC, Debounced_Button => btnc_input);
BTNR_Debouncer: Debouncing port map(Clk_in => CLK100MHZ, BTN => BTNR, Debounced_Button => btnr_input);
SM: State_Machine port map(BTNC => btnc_input, BTNR => btnr_input, CLK_40HZ => CLK_40HZ, CLK_512Hz => CLK512HZ, CLK_100MHz => CLK100MHZ, LED => LED, SW => SW (11 downto 0), CA => CA, AN => AN, Negative_SW => SW(15), Reg_View => SW(14));


end Behavioral;
