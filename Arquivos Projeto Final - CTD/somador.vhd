library ieee;
use ieee.std_logic_1164.all;

entity somador is
port(
	A: in  std_logic_vector(2 downto 0);
	B: in  std_logic_vector(2 downto 0);
	C: in  std_logic_vector(2 downto 0);
	D: in  std_logic_vector(2 downto 0);
	F: out  std_logic_vector(2 downto 0) 
	);
end somador;

architecture arch of somador is
signal res_soma1, res_soma2, res_soma3: std_logic_vector(3 downto 0);
signal C11, C12, C21, C22, C31, C32: std_logic;

component halfadder is
port (A: in std_logic;
      B: in std_logic;
      S: out std_logic;
      Cout: out std_logic
      );
end component;

component fulladder is
port (A: in std_logic;
      B: in std_logic;
      Cin: in std_logic;
      S: out std_logic;
      Cout: out std_logic);
end component;
begin
    HA1: halfadder port map (A(0), B(0), res_soma1(0), C11);
    FA11: fulladder port map(A(1), B(1), C11, res_soma1(1), C12);
    FA12: fulladder port map(A(2), B(2), C12, res_soma1(2), res_soma1(3));
    
    HA2: halfadder port map (C(0), D(0), res_soma2(0), C21);
    FA21: fulladder port map(C(1), D(1), C21, res_soma2(1), C22);
    FA22: fulladder port map(C(2), D(2), C22, res_soma2(2), res_soma2(3));
    
    HA3: halfadder port map (res_soma1(0), res_soma2(0), res_soma3(0), C31);
    FA31: fulladder port map(res_soma1(1), res_soma2(1), C31, res_soma3(1), C32);
    FA32: fulladder port map(res_soma1(2), res_soma2(2), C32, res_soma3(2), res_soma3(3));
    
    F <= res_soma3(2 downto 0);

end arch;