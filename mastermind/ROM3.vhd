library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM3;

architecture Rom_Arch of ROM3 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "1001011100110110",  -- 9736
	01 => "0101100001000011",  -- 5843
    02 => "0111010000100001",  -- 7421 
	03 => "1000001110010000",  -- 8390
	04 => "0110000101001001",  -- 6149
	05 => "1000011110010000",  -- 8790
	06 => "0000100100100001",  -- 0921
	07 => "0000011100011000",  -- 0718
	08 => "1000011000001001",  -- 8609
	09 => "0010100100000001",  -- 2901
    10 => "0011011110000000",  -- 3780
	11 => "0100010100111000",  -- 4538
	12 => "1001000001000010",  -- 9042
	13 => "0111100100010011",  -- 7913
	14 => "1000010001100010",  -- 8462
	15 => "0001001001110000"); -- 1270
	 
	
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