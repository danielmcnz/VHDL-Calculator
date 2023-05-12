----------------------------------------------------------------------------------
--Module Name:
--2bit Register (Behavioral)
--
--Written by:
--Freddie Pankhurst, Daniel Mcgregor, Jono Braithwaite
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux is
    port (
            Negative_Sign, Overflow_Flag: in std_logic;                                                         -- negative and overflown sign flags for the outputted number on the 7 segment displays
            Selector : in std_logic_vector (2 downto 0);                                                        -- determines which 7 segment display is active at any given time
            State, Opcode: in std_logic_vector (1 downto 0);                                                    -- current state from the state machine and the inputted op code for the current calculation
            Input_0, Input_1, Input_2, Input_3, Input_4, Input_5, Input_6 : in std_logic_vector (6 downto 0);   -- multiplexer inputs for the 7 segment display segments
            Output : out std_logic_vector (6 downto 0);                                                         -- output of the mux
            Output_Display : out std_logic_vector (7 downto 0)                                                  -- values for each segment of any given display 
          );
end Mux;

architecture Behavioral of Mux is
begin 
    process (Selector)  -- When Selector Bits Change
    begin
        -- Checks for What the Current State of the System is
        case State is
            when "01" =>
                -- If in the Opcode Selecting State, it Displays Words Depending on the Current Opcode
                case Opcode is
                    when "00" =>
                        -- Displays "Add" (Addition)
                        case Selector is
                            when "000"  => Output <= "0100001"; 
                            when "001"  => Output <= "0100001"; 
                            when "010"  => Output <= "0001000";
                            when "011"  => Output <= "1111111";
                            when "100"  => Output <= "1111111"; 
                            when "101"  => Output <= "1111111";
                            when "110"  => Output <= "1111111";
                            when others => Output <= "1111111";
                        end case;
                    when "01" =>
                        -- Displays "Sub" (Subtraction)
                        case Selector is
                            when "000"  => Output <= "0000011"; 
                            when "001"  => Output <= "1100011"; 
                            when "010"  => Output <= "0010010";
                            when "011"  => Output <= "1111111";
                            when "100"  => Output <= "1111111"; 
                            when "101"  => Output <= "1111111";
                            when "110"  => Output <= "1111111";
                            when others => Output <= "1111111";
                        end case;
                    when "10" =>
                        -- Displays "X" (Multiplication)
                        case Selector is
                            when "000"  => Output <= "1000110"; 
                            when "001"  => Output <= "0111111"; 
                            when "010"  => Output <= "1110000";
                            when "011"  => Output <= "1111111";
                            when "100"  => Output <= "1111111"; 
                            when "101"  => Output <= "1111111";
                            when "110"  => Output <= "1111111";
                            when others => Output <= "1111111";
                        end case;
                    when others =>
                        -- Displays "^2" (Squared)
                        case Selector is
                            when "000"  => Output <= "0100100"; 
                            when "001"  => Output <= "1011100"; 
                            when "010"  => Output <= "1111111";
                            when "011"  => Output <= "1111111";
                            when "100"  => Output <= "1111111"; 
                            when "101"  => Output <= "1111111";
                            when "110"  => Output <= "1111111";
                            when others => Output <= "1111111";
                        end case;
                end case;
            when "11" =>
                -- If in the Calculate State it Displays either the Value or Overflow Depending on Overflow Flag
                case Overflow_Flag is
                    when '1' => 
                        -- If Overflow is True then Display "Error"
                        case Selector is
                            when "000"  => Output <= "0101111"; 
                            when "001"  => Output <= "0100011"; 
                            when "010"  => Output <= "0101111";
                            when "011"  => Output <= "0101111";
                            when "100"  => Output <= "0000110"; 
                            when "101"  => Output <= "1111111";
                            when "110"  => Output <= "1111111";
                            when others => Output <= "1111111";
                        end case;
                    when others =>
                        -- Else Display the Calculated Value
                        case Selector is
                            when "000" => Output <= Input_0; 
                            when "001" => Output <= Input_1; 
                            when "010" => Output <= Input_2;
                            when "011" => Output <= Input_3;
                            when "100" => Output <= Input_4; 
                            when "101" => Output <= Input_5;
                            when "110" => Output <= Input_6;
                            when others => 
                                case Negative_Sign is
                                    when '0'    => Output <= "1111111";
                                    when others => Output <= "0111111";
                                end case;
                        end case;
                end case;
            when others =>
                -- Else if in any Other State Display the Recived Value
                case Selector is
                    when "000" => Output <= Input_0; 
                    when "001" => Output <= Input_1; 
                    when "010" => Output <= Input_2;
                    when "011" => Output <= Input_3;
                    when "100" => Output <= Input_4; 
                    when "101" => Output <= Input_5;
                    when "110" => Output <= Input_6;
                    when others => 
                        case Negative_Sign is
                            when '0'    => Output <= "1111111";
                            when others => Output <= "0111111";
                        end case;
                end case;
        end case;
    end process;
    
    process (Selector)  -- When the Selector Changes
    begin
        -- Alternate between Which Display is Currently Active (Out of the Eight)
        case Selector is
            when "000"  => Output_Display <= "11111110"; 
            when "001"  => Output_Display <= "11111101"; 
            when "010"  => Output_Display <= "11111011";
            when "011"  => Output_Display <= "11110111";
            when "100"  => Output_Display <= "11101111"; 
            when "101"  => Output_Display <= "11011111";
            when "110"  => Output_Display <= "10111111";
            when others => Output_Display <= "01111111"; 
        end case;
    
    end process;

end Behavioral;
