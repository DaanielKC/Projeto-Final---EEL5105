library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0101010000010000",  --5410   
	01 => "0100010100100001",  --4521   
   02 => "0001001001010100",  --1254
	03 => "0001001000110101",  --1235
	04 => "0001001000110100",  --1234
	05 => "0000010001010010",  --0452
	06 => "0000001001000011",  --0243
	07 => "0101010000110010",  --5432
	08 => "0101000000110010",  --5032
	09 => "0010001100000101",  --2305
   10 => "0001001101010010",  --1352
	11 => "0000001000110001",  --0231
	12 => "0010000000010011",  --2013
	13 => "0101001101000001",  --5341
	14 => "0101010000000010",  --5402
	15 => "0001001001010011"); --1253
	 
	
begin
   process (address)
   begin
       case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
	    when "1010" => data <= my_rom(10);
	    when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
	    when "1101" => data <= my_rom(13);
	    when "1110" => data <= my_rom(14);
	    when others => data <= my_rom(15);
     end case;
  end process;
end architecture Rom_Arch;