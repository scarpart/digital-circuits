library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0000001100100100",  -- 0324
	01 => "0100001100010000",  -- 4310
    02 => "0011000101000000",  -- 3140
	03 => "0000000101000101",  -- 0145
	04 => "0100000000110101",  -- 4035
	05 => "0010001100010100",  -- 2314
	06 => "0011000001000000",  -- 3040
	07 => "0001001100100000",  -- 1320
	08 => "0011000100000010",  -- 3102
	09 => "0001010100000011",  -- 1503
    10 => "0010000101010011",  -- 2153
	11 => "0010010101000001",  -- 2541
	12 => "0001010000100011",  -- 1423
	13 => "0001001101000010",  -- 1342
	14 => "0100000100000011",  -- 4103
	15 => "0011010100010100"); -- 3514
	 
	
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