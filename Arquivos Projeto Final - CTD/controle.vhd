library ieee;
use ieee.std_logic_1164.all;

entity controle is port(
			  clock,K1,K0,endtime,endgame,endround: in std_logic;			  
			  R1,R2,E1,E2,E3,E4,E5: out std_logic);
end controle;

architecture bhv of controle is
type ESTADOS is (init, rst, setup, play, count_round, check, espera, result);
signal EAtual, PEstado: ESTADOS := init;

begin

process(clock,K0)
  begin
    if (K0 = '1') then
	  EAtual <= rst;
	elsif (clock'event AND clock = '1') then 
  	  EAtual <= PEstado;
	end if;
  end process;
  
  process(EAtual, K1, endtime)
  begin
  
    case EAtual is
        when init =>
            PEstado <= init;
            R1 <= '1';
            R2 <= '1';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
        when rst =>
            PEstado <= setup;
            R1 <= '1';
            R2 <= '1';
            E1 <= '1';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
        when setup =>
            if (K1 = '1') then
                PEstado <= play;
            else
                PEstado <= setup;
            end if;
            R1 <= '0';
            R2 <= '0';
            E1 <= '1';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
        when play =>
            if (endtime = '1') then
                PEstado <= result;
            elsif (K1 = '1') then
                PEstado <= count_round;
            else
                PEstado <= play;
            end if;
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '1';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
        when count_round =>
            PEstado <= check;
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '1';
            E4 <= '0';
            E5 <= '0';
        when check =>
            if (endgame = '1' or endround = '1') then
                PEstado <= result;
            else
                PEstado <= espera;
            end if;
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '0';
        when espera =>
            if (K1 = '1') then
                PEstado <= play;
            else
                PEstado <= espera;
            end if;
            R1 <= '1';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '1';
            E5 <= '0';
        when result =>
            if (K1 = '1') then
                PEstado <= init;
            else
                PEstado <= result;
            end if;
            R1 <= '0';
            R2 <= '0';
            E1 <= '0';
            E2 <= '0';
            E3 <= '0';
            E4 <= '0';
            E5 <= '1';
    end case;
  end process;


end bhv;