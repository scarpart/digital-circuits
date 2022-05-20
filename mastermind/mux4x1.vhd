library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
generic (n : integer := 16);
port (
    entr0, entr1, entr2, entr3: in std_logic_vector(n-1 downto 0);
    selecao: in std_logic_vector(1 downto 0);
    S: out std_logic_vector(n-1 downto 0)
    );
end mux4x1;

architecture selecao of mux4x1 is
begin
    S <= entr0 when selecao = "00" else
         entr1 when selecao = "01" else
         entr2 when selecao = "10" else
         entr3;
end selecao;