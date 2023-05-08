----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2023 15:30:51
-- Design Name: 
-- Module Name: TB_ALU - Behavioral
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

entity TB_ALU is
--  Port ( );
end TB_ALU;

architecture Behavioral of TB_ALU is

component ALU is
    Port (Register_0, Register_2: in std_logic_vector (11 downto 0);
          Register_1: in std_logic_vector (1 downto 0);
          Output: out std_logic_vector (23 downto 0);
          Calculate, Sign_Reg_0, Sign_Reg_2: in std_logic;
          Sign_output: out std_logic);
end component;

signal Register_0, Register_2 : std_logic_vector (11 downto 0);
signal Register_1 : std_logic_vector (1 downto 0);
signal Output: std_logic_vector (23 downto 0);
signal Calculate, Sign_Reg_0, Sign_Reg_2: std_logic;
signal Sign_output: std_logic;

begin

UUT: ALU port map (Register_0 => Register_0, Register_1 => Register_1, Register_2 => Register_2, Output => Output, Calculate => Calculate, Sign_Reg_0 => Sign_Reg_0, Sign_Reg_2 => Sign_Reg_2, Sign_output => Sign_output);

process is
    begin
    
    -- addition
    
    Calculate <= '0';
    Register_0 <= "000000000100";
    Register_1 <= "00";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000001100";
    Register_1 <= "00";
    Register_2 <= "000000000110";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '0';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "00";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '1';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "00";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '1';
    Sign_Reg_2 <= '1';
    Calculate <= '0';
    
    wait for 10 ns;
    
    -- subtraction
    
    Register_0 <= "000000000100";
    Register_1 <= "01";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000001100";
    Register_1 <= "01";
    Register_2 <= "000000000110";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '0';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "01";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '1';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "01";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '1';
    Sign_Reg_2 <= '1';
    Calculate <= '0';
    
    wait for 10 ns;
    
    -- multiplication
    
    Register_0 <= "000000000100";
    Register_1 <= "10";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000001100";
    Register_1 <= "10";
    Register_2 <= "000000000110";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '0';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "10";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '1';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "10";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '1';
    Sign_Reg_2 <= '1';
    Calculate <= '0';
    
    wait for 10 ns;
    
    -- check for overflow
    
    Register_0 <= "111111111111";
    Register_1 <= "10";
    Register_2 <= "111111111111";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Calculate <= '0';
    
    wait for 10 ns;
    
    -- squared
    
    Register_0 <= "000000000100";
    Register_1 <= "11";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000001100";
    Register_1 <= "11";
    Register_2 <= "000000000110";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '0';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "11";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '1';
    Calculate <= '1';
    
    wait for 10 ns;
    
    Register_0 <= "000000000100";
    Register_1 <= "11";
    Register_2 <= "000000000100";
    Sign_Reg_0 <= '1';
    Sign_Reg_2 <= '1';
    Calculate <= '0';
    
    wait for 10 ns;
    
    -- check for overflow
    
    Register_0 <= "111111111111";
    Register_1 <= "11";
    Register_2 <= "111111111111";
    Sign_Reg_0 <= '0';
    Sign_Reg_2 <= '0';
    Calculate <= '1';
    
    wait for 10 ns;

end process;


end Behavioral;
