----------------------------------------------------------------------------------
--Module Name:
--State Machine (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity State_Machine is
    port(
            BTNC, BTNR, CLK_15KHz, CLK_100MHz, Negative_SW, Reg_View: in std_logic; -- Single Bit Input Flags / Clocks
            LED: out std_logic_vector (15 downto 0);                                -- FGPA LED's
            SW: in std_logic_vector (11 downto 0);                                  -- FGPA Switches
            CA: out std_logic_vector (6 downto 0);                                  -- 7-Seg Display Segments
            AN: out std_logic_vector (7 downto 0)                                   -- 7-Seg Display Chosing
         );
end State_Machine;

architecture Behavioral of State_Machine is
Component Register_12bit
    port (
            Input: in std_logic_vector (11 downto 0);   -- 12-Bit Input for the Register
            Output: out std_logic_vector (11 downto 0); -- 12-Bit Stored Register Value
            Load, BTN_Check, Flag_in: in std_logic;     -- Flags for Loading the Register and the Negative Flag
            Flag_out: out std_logic                     -- Negative Flag Output
         );
end Component;

Component Register_2bit
    port ( 
            Input: in std_logic_vector (1 downto 0);    -- 2-Bit Input for the Register
            Output: out std_logic_vector (1 downto 0);  -- 2-Bit Stored Register Value
            Load, BTN_Check: in std_logic               -- Flags for Loading the Register
          );
end Component;

Component ALU
    Port (
            Register_0, Register_2: in std_logic_vector (11 downto 0);  -- Two Operands
            Register_1: in std_logic_vector (1 downto 0);               -- Operator
            Output: out std_logic_vector (23 downto 0);                 -- Calcualated Value
            Calculate, Sign_Reg_0, Sign_Reg_2: in std_logic;            -- Negative Sign Flags and Calculate State
            Sign_output, Overflow_Flag: out std_logic                   -- Calculate Negative Sign and Overflow FLag
          );
end Component;

Component Display
    Port (
            Input: in std_logic_vector (23 downto 0);                                   -- Calculated resized 24-bit Value
            CA: out std_logic_vector (6 downto 0);                                      -- 7-Seg Display Segments
            AN: out std_logic_vector (7 downto 0);                                      -- 7-Seg Display Chosing
            State, Opcode: in std_logic_vector (1 downto 0);                            -- Vectors for Deciding on Whats Being Displayed
            CLK_15KHz, RESET, CLK_100MHz, Negative_Sign, Overflow_Flag: in std_logic    -- Input Bits for Display Component
          );
end Component;

signal state, opcode: std_logic_vector (1 downto 0) := "00";    -- Initially Setting the State and Opcode to 0
signal Load_0, Load_1, Load_2, Load_3, reset, Sign_Reg_0, Sign_Reg_2, sign_output, negative_sign, overflow_flag: std_logic; -- Setting Required 1-Bit Signals for Settig States, Negatives, and Overflow
signal reg_0, reg_2: std_logic_vector (11 downto 0);        -- Output Values for 12-Bit Registers
signal result, display_val: std_logic_vector (23 downto 0); -- Setting 24-Bit vectors that are Sent to be Displayed
signal reg_1: std_logic_vector (1 downto 0);                -- Output value for the 2-Bit Register (Opcode)

begin

Regi_0: Register_12bit port map(Input => SW, Output => reg_0, Load => Load_0, BTN_Check => BTNC, Flag_in => Negative_SW, Flag_out => Sign_Reg_0);   -- Initialising the 12 and 2-Bit Registers
Regi_1: Register_2bit port map(Input => SW (1 downto 0), Output => reg_1, Load => Load_1, BTN_Check => BTNC);
Regi_2: Register_12bit port map(Input => SW, Output => reg_2, Load => Load_2, BTN_Check => BTNC, Flag_in => Negative_SW, Flag_out => Sign_Reg_2);

ALU_0: ALU port map(Register_0 => reg_0, Register_1 => reg_1, Register_2 => reg_2, Output => result, Calculate => Load_3, Sign_Reg_0 => Sign_Reg_0, Sign_Reg_2 => Sign_Reg_2, Sign_output => sign_output, Overflow_Flag => overflow_flag);  -- Initialising the ALU module for the Calculations and Recieving the Output

Disp: Display port map(Input => display_val, Negative_Sign => negative_sign, CA => CA, AN => AN, CLK_15KHz => CLK_15KHz, RESET => reset, CLK_100MHz => CLK_100MHz, Overflow_Flag => overflow_flag, State => state, Opcode => opcode);       -- Sending Information to the Display Function to Choose what is Currently being displayed

my_seg_proc: process (BTNR) --- Process for when Debouced Right Button is Pressed
begin
    if BTNR = '1' and BTNR'event then   -- On Rising Edge of Debounced Right Button
        case state is                   -- Switches State to the Next State
            when "00" => state <= "01";
            when "01" => 
                case reg_1 is           -- If Opcode is in Squared Mode then Skip Second Register Value Input
                    when "11" => state <= "11";
                    when others => state <= "10";
                end case;
            when "10" => state <= "11";
            when others => state <= "00";
        end case;
    end if;
end process my_seg_proc;

process (state) -- When State Change
begin
    if (state = "00") then  -- First 12-Bit Value Input State
            LED <= "0000111111111111"; -- Set Current 
            
            if Reg_View = '0' then
                display_val <= "000000000000" & SW;
                negative_sign <= Negative_SW;  
            else
                display_val <= "000000000000" & reg_0;
                negative_sign <= Sign_Reg_0;  
            end if;
            
            Load_0 <= '1';
            Load_1 <= '0';
            Load_2 <= '0';
            Load_3 <= '0';
        elsif state = "01" then
            LED <= "0000000000000011";
            
            if Reg_View = '0' then
                opcode <= SW (1 downto 0);
            else
                opcode <= reg_1;
            end if;
            
            negative_sign <= '0';
            Load_0 <= '0';
            Load_1 <= '1';
            Load_2 <= '0';
            Load_3 <= '0';
        elsif state = "10" then
            LED <= "1000111111111111";
            
            if Reg_View = '0' then
                display_val <= "000000000000" & SW;
                negative_sign <= Negative_SW; 
            else
                display_val <= "000000000000" & reg_2;
                negative_sign <= Sign_Reg_2;  
            end if;
            
            Load_0 <= '0';
            Load_1 <= '0';
            Load_2 <= '1';
            Load_3 <= '0';
        elsif state = "11" then
            LED <= "0000000000000000";
            display_val <= result;
            negative_sign <= sign_output;
            Load_0 <= '0';
            Load_1 <= '0';
            Load_2 <= '0';
            Load_3 <= '1';    
        end if;
end process;

end Behavioral;