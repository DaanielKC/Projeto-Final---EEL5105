library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_time is 
port (R: in std_logic;
		clock: in std_logic;
		E: in std_logic;
		tempo: out std_logic_vector(3 downto 0);
		fim_tempo: out std_logic);
end counter_time;

architecture arch of counter_time is
signal Stempo: std_logic_vector(3 downto 0);
begin
    process(clock, R)
    begin
        if (R = '1') then
            Stempo <= "0000";
        elsif (clock'event AND clock = '1') then
            if (E = '1' and Stempo < "1001") then
                Stempo <= Stempo + '1';    
            end if;
        end if;
    end process;
    fim_tempo <= '1' when Stempo = "1001" else '0';
    tempo <= Stempo;
end arch;