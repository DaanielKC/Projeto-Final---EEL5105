library ieee;
use ieee.std_logic_1164.all;

entity comp4 is 
port (P: in std_logic_vector(2 downto 0);
		Peq4: out std_logic
);
end comp4;

architecture arc_comp of comp4 is
signal comp: std_logic_vector(2 downto 0);

begin
    comp(0) <= P(0) xnor '0';
    comp(1) <= P(1) xnor '0';
    comp(2) <= P(2) xnor '1';
	Peq4 <= comp(0) and comp(1) and comp(2);
end arc_comp;