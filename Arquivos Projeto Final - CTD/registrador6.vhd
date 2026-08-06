library ieee;
use ieee.std_logic_1164.all;

entity registrador6 is 
port (CLK, RST, EN: in std_logic; 
	  D: in std_logic_vector(5 downto 0); 
	  Q: out std_logic_vector(5 downto 0));
end registrador6;

architecture behv of registrador6 is
begin
    process(CLK, RST)
    begin
        if (RST = '1') then
            Q <= "000000";
        elsif (CLK'event and CLK = '1') then
            if (EN = '1') then
                Q <= D;
            end if;
        end if;
end process;
end behv;