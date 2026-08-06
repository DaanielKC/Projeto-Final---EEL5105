library ieee;
use ieee.std_logic_1164.all;

entity comp_n is 
port (c, u: in  std_logic_vector(3 downto 0);
      P0:out std_logic_vector(2 downto 0)
);
end comp_n;

architecture arc_comp of comp_n is
signal comp: std_logic_vector(3 downto 0);

begin
    comp(0) <= c(0) xnor u(0);
    comp(1) <= c(1) xnor u(1);
    comp(2) <= c(2) xnor u(2);
    comp(3) <= c(3) xnor u(3);
	P0 <= "00" & (comp(0) and comp(1) and comp(2) and comp(3));
end arc_comp;