----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2023 12:00:28
-- Design Name: 
-- Module Name: State_Machine - Behavioral
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

entity State_Machine is
    port(BTNC, BTNR, CLK_512Hz, CLK_100MHz, CLK_40HZ: in std_logic;
         LED: out std_logic_vector (15 downto 0);
         SW: in std_logic_vector (11 downto 0);
         CA: out std_logic_vector (6 downto 0);
         AN: out std_logic_vector (7 downto 0)
         );
         
end State_Machine;

architecture Behavioral of State_Machine is
Component Register_12bit
    port ( Input: in std_logic_vector (11 downto 0);
           Output: out std_logic_vector (11 downto 0);
           Load, BTN_Check: in std_logic);
end Component;

Component Register_2bit
    port ( Input: in std_logic_vector (1 downto 0);
           Output: out std_logic_vector (1 downto 0);
           Load, BTN_Check: in std_logic);
end Component;

Component ALU
    Port (
            Register_0, Register_2: in std_logic_vector (11 downto 0);
            Register_1: in std_logic_vector (1 downto 0);
            Output: out std_logic_vector (11 downto 0);
            Calculate: in std_logic
            );
end Component;

Component Display
    Port (
            Input: in std_logic_vector (11 downto 0);
            CA: out std_logic_vector (6 downto 0);
            AN: out std_logic_vector (7 downto 0);
            CLK_40HZ, CLK_512Hz, RESET, CLK_100MHz: in std_logic
            );
end Component;

signal state: std_logic_vector (1 downto 0) := "00";
signal Load_0, Load_1, Load_2, Load_3, reset: std_logic;
signal reg_0, reg_2, result, display_val: std_logic_vector (11 downto 0);
signal reg_1: std_logic_vector (1 downto 0);

begin

Regi_0: Register_12bit port map(Input => SW, Output => reg_0, Load => Load_0, BTN_Check => BTNC);
Regi_1: Register_2bit port map(Input => SW (1 downto 0), Output => reg_1, Load => Load_1, BTN_Check => BTNC);
Regi_2: Register_12bit port map(Input => SW, Output => reg_2, Load => Load_2, BTN_Check => BTNC);

ALU_0: ALU port map(Register_0 => reg_0, Register_1 => reg_1, Register_2 => reg_2, Output => result, Calculate => Load_3);

Disp: Display port map(Input => display_val, CA => CA, AN => AN, CLK_40HZ => CLK_40HZ, CLK_512Hz => CLK_512Hz, RESET => reset, CLK_100MHz => CLK_100MHz);

my_seg_proc: process (BTNR)		-- Enter this process whenever BCD input changes state
begin
    if BTNR = '1' and BTNR'event then
        case state is
            when "00" => state <= "01"; --process first 12-bit
            when "01" => state <= "10";-- process second 12-bit
            when "10" => state <= "11";
            when others => state <= "00";
        end case;
    end if;
end process my_seg_proc;

process (state)
begin
    if (state = "00") then
            LED <= "0000111111111111";
            display_val <= SW;
            Load_0 <= '1';
            Load_1 <= '0';
            Load_2 <= '0';
            Load_3 <= '0';
        elsif state = "01" then
            LED <= "0000000000000011";
            display_val <= "0000000000" & SW (1 downto 0);
            Load_0 <= '0';
            Load_1 <= '1';
            Load_2 <= '0';
            Load_3 <= '0';
        elsif state = "10" then
            LED <= "1000111111111111";
            display_val <= SW;
            Load_0 <= '0';
            Load_1 <= '0';
            Load_2 <= '1';
            Load_3 <= '0';
        elsif state = "11" then
            LED <= "0000000000000000";
            display_val <= result;
            Load_0 <= '0';
            Load_1 <= '0';
            Load_2 <= '0';
            Load_3 <= '1';
        end if;
end process;



end Behavioral;
