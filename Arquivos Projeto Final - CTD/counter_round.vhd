library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_round is 
port(R: in std_logic;
	  E : in std_logic;
	  clock: in std_logic;
	  end_round: out std_logic;
	  X : out std_logic_vector(3 downto 0));
end counter_round;

architecture arch of counter_round is
signal SX: std_logic_vector(3 downto 0);
begin
    process(clock, R)
    begin
        if (R = '1') then
            SX <= "1111";
        elsif (clock'event AND clock = '1') then
            if (E = '1' and SX > "0000") then
                SX <= SX - '1';
            end if;
        end if;
    end process;
    end_round <= '1' when SX = "0000" else '0';
    X <= SX;
end arch;