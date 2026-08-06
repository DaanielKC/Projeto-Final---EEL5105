library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity datapath is 
port (S: in std_logic_vector(15 downto 0); -- dos switches
      clk,R1,R2,E1,E2,E3,E4,E5: in std_logic;
      end_game, end_time, end_round: out std_logic;
		HEX7,HEX6,HEX5,HEX4,HEX3,HEX2,HEX1,HEX0: out std_logic_vector(6 downto 0);
		LED:out std_logic_vector(15 downto 0));
end datapath;

architecture arqdtp of datapath is
signal SEL_MUX: std_logic_vector(1 downto 0);
signal Y,temp,X,Xb,Q,Q1,PREG,EREG,SELECC,F: std_logic_vector(3 downto 0);
signal RESULT: std_logic_vector(7 downto 0);
signal P,P_REG,E,E_REG,p0,p1,p2,p3: std_logic_vector(2 downto 0);
signal SEL, SPE, SPE_REG: std_logic_vector(5 downto 0);
signal USER,CODE,LEDR150,Z,m0,m1,m2,m3: std_logic_vector(15 downto 0);
signal h71,h61,h41,h31,h33,h20,h21,h22,hh22,h23,h11,h13,h00,h01,h02,hh02,h03, letraL, letraE, letraP, letraC, letrat, apagado: std_logic_vector(6 downto 0);
signal clk1,rst_divfreq,endgame,endtime,endround, e4orr1: std_logic;
signal SHX00: std_logic_vector(3 downto 0);

--para funcionar no emulador
signal decSignal0, decSignal1, decSignal2: std_logic_vector(3 downto 0);

signal PE_REG, PE: std_logic_vector(5 downto 0);


component somador is
port (A: in  std_logic_vector(2 downto 0);
		B: in  std_logic_vector(2 downto 0);
		C: in  std_logic_vector(2 downto 0);
		D: in  std_logic_vector(2 downto 0);
		F: out  std_logic_vector(2 downto 0));
end component;

component selector is 
port(in0, in1, in2, in3: in  std_logic;
     saida: out std_logic_vector(1 downto 0));    
end component;

component ROM3 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

component ROM2 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));    
end component;

component ROM1 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

component ROM0 is 
port(address : in  std_logic_vector(3 downto 0);
     data: out std_logic_vector(15 downto 0));
end component;

component registrador16 is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(15 downto 0); 
		Q: out std_logic_vector(15 downto 0)); 
end component;

component registrador6 is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(5 downto 0); 
		Q: out std_logic_vector(5 downto 0) ); 
end component;

component registrador is 
port (CLK, RST, EN: in std_logic; 
		D: in std_logic_vector(3 downto 0); 
		Q: out std_logic_vector(3 downto 0) ); 
end component;

component multiplexador74 is	
port (F1: in  std_logic_vector(6 downto 0);
		F2: in  std_logic_vector(6 downto 0);
		F3: in  std_logic_vector(6 downto 0);
		F4: in  std_logic_vector(6 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(6 downto 0));
end  component;

component multiplexador72 is	
port (F1: in  std_logic_vector(6 downto 0);
		F2: in  std_logic_vector(6 downto 0);
		sel: in  std_logic;
		F: out  std_logic_vector(6 downto 0));
end component;

component multiplexador16 is	
port (F1: in  std_logic_vector(15 downto 0);
		F2: in  std_logic_vector(15 downto 0);
		F3: in  std_logic_vector(15 downto 0);
		F4: in  std_logic_vector(15 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(15 downto 0));
end component;

component decodtermo is
port (X: in  std_logic_vector(3 downto 0);
		S: out std_logic_vector(15 downto 0));
end component;

component decod7seg is
port (G: in  std_logic_vector(3 downto 0);
		S: out std_logic_vector(6 downto 0));
end component;

component counter_time is 
port(R: in std_logic;
		clock: in std_logic;
		E: in std_logic;
		tempo: out std_logic_vector(3 downto 0);
		fim_tempo: out std_logic);
end component;

component counter_round is 
port(R: in std_logic;
	  E : in std_logic;
	  clock: in std_logic;
	  end_round: out std_logic;
	  X : out std_logic_vector(3 downto 0));
end component;

component comp4 IS
PORT (P: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		Peq4: OUT STD_LOGIC);
END component;

component comp_n is 
port(c, u: in  std_logic_vector(3 downto 0);
     P0: out std_logic_vector(2 downto 0));
end component;

component comp_e is 
port(inc, inu: in  std_logic_vector(15 downto 0);
     E: out std_logic_vector(2 downto 0));
end component;

component ButtonSync is 
port(KEY0, KEY1, CLK: in  std_logic;
     Enter, Reset   : out std_logic);
end component;

component Div_Freq_DE2 is -- Usar esse componente para a placa DE2
port (	clk: in std_logic;
	reset: in std_logic;
	CLK_1Hz: out std_logic
	);
end component;

component Div_Freq is -- Usar esse componente para o emulador
port (	clk: in std_logic;
	reset: in std_logic;
	CLK_1Hz, sim_2hz: out std_logic
	);
end component;

begin
	DIVFREQ_EMU: div_freq port map (clk, R2, clk1);	-- usar esse componente para o emulador
--	DIVFREQ: div_Freq_DE2 port map(clk, R2, clk1); -- usar esse componente para a placa	
    
    -- ENTRADA DO USUÁRIO
	reguser: registrador16 port map(clk, R2, E2, S, USER);
    
    -- MEMÓRIAS
    reg6sel: registrador6 port map(clk, R2, E1, S(5 downto 0), SEL);
    RM0: ROM0 port map (SEL(5 downto 2), m0);
    RM1: ROM1 port map (SEL(5 downto 2), m1);
    RM2: ROM2 port map (SEL(5 downto 2), m2);
    RM3: ROM3 port map (SEL(5 downto 2), m3);
    muxrom: multiplexador16 port map(m0, m1, m2, m3, SEL(1 downto 0), CODE);
    
    -- REGISTRADOR DO "P" E DO "E"
	SPE <= P & E;
	P_REG <= SPE_REG(5 downto 3);
	E_REG <= SPE_REG(2 downto 0);
	reg6pe: registrador6 port map(clk, R2, E4, SPE, SPE_REG);
	 
    -- COMPARADORES
	compe: comp_e port map (CODE, USER, E);
	comp0: comp_n port map (CODE(3 downto 0), USER(3 downto 0), p0);
	comp1: comp_n port map (CODE(7 downto 4), USER(7 downto 4), p1);
	comp2: comp_n port map (CODE(11 downto 8), USER(11 downto 8), p2);
	comp3: comp_n port map (CODE(15 downto 12), USER(15 downto 12), p3);
	compara4: comp4 port map (P, endgame);
	somap: somador port map (p0, p1, p2, p3, P);
    
    -- SELETOR DOS MULTIPLEXADORES DAS SAÍDAS HEX0 À HEX3
    E4orR1 <= E4 OR R1;
    seletor: selector port map(E1, E2, e4orr1, E5, SEL_MUX);
    
    -- CONTADORES DE TEMPO E ROUNDS
	counterround: counter_round port map(R2, E3, clk, endround, X);
	countertime: counter_time port map (R1, clk1, E2, temp, endtime);
	
	-- SAÍDA ROUNDS
	decotermo: decodtermo port map (X, Z);
	LEDR150 <= Z and (not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1) & not(E1));
	LED <= "0000000000000000" when (R2 = '1') else LEDR150;
	
	-- RESULTADO
	F <= X and (not(endtime) & not(endtime) & not(endtime) & not(endtime));
	RESULT <= "000" & endgame & F;
	
    -- SAÍDA HEX0
    SHX00 <= "00" & SEL(1 downto 0);
    EREG <= '0' & E_REG(2 downto 0);
    decodhx00: decod7seg port map (SHX00, h00);
    decodhx01: decod7seg port map (USER(3 downto 0), h01);
    decodhx02: decod7seg port map (EREG, h02);
    decodhx03: decod7seg port map (CODE(3 downto 0), h03);
    hh02 <= apagado when (R2 = '1') else h02;
    muxh0: multiplexador74 port map (h00, h01, hh02, h03, SEL_MUX, HEX0);
    
    -- SAÍDA HEX1
    letraL <= "1000111";
    letraE <= "0000110";
    decodhx11: decod7seg port map(USER(7 downto 4), h11);
    decodhx13: decod7seg port map(CODE(7 downto 4), h13);
    muxh1: multiplexador74 port map(letraL, h11, letraE, h13, SEL_MUX, HEX1);
    
    -- SAÍDA HEX2
    PREG <= '0' & P_REG;
    decodhx20: decod7seg port map(SEL(5 downto 2), h20);
    decodhx21: decod7seg port map(USER(11 downto 8), h21);
    decodhx22: decod7seg port map(PREG, h22);
    decodhx23: decod7seg port map(CODE(11 downto 8), h23);
    hh22 <= apagado when (R2 = '1') else h22;
	muxh2: multiplexador74 port map(h20, h21, hh22, h23, SEL_MUX, HEX2);
	
	-- SAÍDA HEX3
	letraC <= "1000110";
	letraP <= "0001100";
	decodhx31: decod7seg port map(USER(15 downto 12), h31);
	decodhx33: decod7seg port map(CODE(15 downto 12), h33);
	muxh3: multiplexador74 port map(letraC, h31, letraP, h33, SEL_MUX, HEX3);
	
	-- SAÍDA HEX4
	apagado <= "1111111";
	decodhx41: decod7seg port map(temp, h41);
	muxh4: multiplexador72 port map(apagado, h41, E2, HEX4);
	
	-- SAÍDA HEX5
	apagado <= "1111111";
	letrat <= "0000111";
	muxh5: multiplexador72 port map(apagado, letrat, E2, HEX5);
	
	-- SAÍDA HEX6
	decodhx61: decod7seg port map(RESULT(3 downto 0), h61);
	muxh6: multiplexador72 port map(apagado, h61, E5, HEX6);
	
	-- SAÍDA HEX7
	decodhx71: decod7seg port map(RESULT(7 downto 4), h71);
	muxh7: multiplexador72 port map(apagado, h71, E5, HEX7);
	
	-- INDICADORES DE FIM DE JOGO/TEMPO/ROUND
	end_game <= endgame;
	end_time <= endtime;
	end_round <= endround;
end arqdtp;
