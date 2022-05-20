library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
port (
    entr0, entr1: in std_logic_vector(6 downto 0);
    selecao: in std_logic;
    S: out std_logic_vector(6 downto 0)
    );
end mux2x1;

architecture selecao of mux2x1 is
begin
    S <= entr0 when selecao = '0' else
         entr1;
end selecao;