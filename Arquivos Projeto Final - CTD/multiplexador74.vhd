library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplexador74 is	
port (F1: in  std_logic_vector(6 downto 0);
		F2: in  std_logic_vector(6 downto 0);
		F3: in  std_logic_vector(6 downto 0);
		F4: in  std_logic_vector(6 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(6 downto 0));
end multiplexador74;

architecture mult of multiplexador74 is
begin
    
    with sel select F <= F1 when "00",
                                F2 when "01",
                                F3 when "10",
                                F4 when others;    
    
end mult;