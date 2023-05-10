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
  Port (
        Negative_Sign, Overflow_Flag: in std_logic;
        Selector : in std_logic_vector (2 downto 0);
        State, Opcode: in std_logic_vector (1 downto 0);
        Input_0, Input_1, Input_2, Input_3, Input_4, Input_5, Input_6 : in std_logic_vector (6 downto 0);
        Output : out std_logic_vector (6 downto 0);
        Output_Display : out std_logic_vector (7 downto 0)
        );
end Mux;

architecture Behavioral of Mux is
begin 
    process (Selector)
    begin
        case State is
            when "01" =>
                case Opcode is
                    when "00" =>
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
                case Overflow_Flag is
                    when '1' => 
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
    
    process (Selector)
    begin
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
