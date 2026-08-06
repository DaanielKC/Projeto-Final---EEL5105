 library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM2;

architecture Rom_Arch of ROM2 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0111011001010100",  --7654  
	01 => "0100001100100001",  --4321  
   02 => "0001011101000110",  --1746
	03 => "0010011001110001",  --2671
	04 => "0001000001110110",  --1076
	05 => "0110011100100001",  --6721
	06 => "0110000000100011",  --6023
	07 => "0010000001110101",  --2075
	08 => "0101011001000010",  --5642
	09 => "0111011000010000",  --7610
   10 => "0101011101100010",  --5762
	11 => "0111010100100110",  --7526
	12 => "0001011100100101",  --1724
	13 => "0001011000100111",  --1627
	14 => "0001010000100101",  --1425
	15 => "0110001001110011"); --6273
	 
	
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