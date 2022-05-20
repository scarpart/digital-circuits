library ieee;
use ieee.std_logic_1164.all;

entity decoder_termometrico is
port(
    tempo: in std_logic_vector(3 downto 0);
    E_and: in std_logic;
    s_dec: out std_logic_vector(15 downto 0)
    );
end decoder_termometrico;

architecture dec of decoder_termometrico is
signal Sleds: std_logic_vector(15 downto 0);
begin

    Sleds <= "0000000000000011" when tempo = "0001" else
             "0000000000000111" when tempo = "0010" else
             "0000000000001111" when tempo = "0011" else
             "0000000000011111" when tempo = "0100" else
             "0000000000111111" when tempo = "0101" else
             "0000000001111111" when tempo = "0110" else
             "0000000011111111" when tempo = "0111" else
             "0000000111111111" when tempo = "1000" else
             "0000001111111111" when tempo = "1001" else
             "0000011111111111" when tempo = "1010" else
             "0000111111111111" when tempo = "1011" else
             "0001111111111111" when tempo = "1100" else
             "0011111111111111" when tempo = "1101" else
             "0111111111111111" when tempo = "1110" else
             "1111111111111111" when tempo = "1111" else
             "0000000000000001";
    
    s_dec <= Sleds when E_and = '0' else
             (others => '0');
    
end dec;
