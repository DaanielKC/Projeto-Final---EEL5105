library ieee;
use ieee.std_logic_1164.all;

entity decodtermo is
port (X: in  std_logic_vector(3 downto 0);
		S: out std_logic_vector(15 downto 0));
end decodtermo;

architecture arch of decodtermo is
begin
 with X select S <= "0000000000000000" when "0000", 
                    "0000000000000001" when "0001",
                    "0000000000000011" when "0010",
                    "0000000000000111" when "0011",
                    "0000000000001111" when "0100",
                    "0000000000011111" when "0101",
                    "0000000000111111" when "0110",
                    "0000000001111111" when "0111",
                    "0000000011111111" when "1000",
                    "0000000111111111" when "1001",
                    "0000001111111111" when "1010",
                    "0000011111111111" when "1011",
                    "0000111111111111" when "1100",
                    "0001111111111111" when "1101",
                    "0011111111111111" when "1110",
                    "0111111111111111" when others;
end arch;