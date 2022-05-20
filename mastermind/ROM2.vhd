library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (

    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
    
end ROM2;

architecture Rom_Arch of ROM2 is
  
type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

	00 => "0111010000010011",  -- 7413
	01 => "0101001001100011",  -- 5263
    02 => "0101010000100011",  -- 5423
	03 => "0111001100000001",  -- 7301
	04 => "0110001100010010",  -- 6312
	05 => "0111010000110000",  -- 7430
	06 => "0001011100000011",  -- 1703
	07 => "0000011000010010",  -- 0612
	08 => "0010000001000111",  -- 2047
	09 => "0011000101100111",  -- 3167
    10 => "0000011001110100",  -- 0674
	11 => "0100011100010000",  -- 4710
	12 => "0001000000110110",  -- 1036
	13 => "0100000101100101",  -- 4165
	14 => "0010011101000110",  -- 2746 
	15 => "0110010101000111"); -- 6547
	 
	
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