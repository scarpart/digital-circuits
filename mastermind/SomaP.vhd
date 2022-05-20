library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SomaP is port (
    CompIn0, CompIn1, CompIn2, CompIn3: in std_logic;
    S: out std_logic_vector(2 downto 0) );
end SomaP;

architecture somando of SomaP is
signal soma: std_logic_vector(2 downto 0) := "000";
begin
    S <= soma + CompIn0 + CompIn1 + CompIn2 + CompIn3;
end somando;