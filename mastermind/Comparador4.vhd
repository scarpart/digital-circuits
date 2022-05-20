library ieee;
use ieee.std_logic_1164.all;

entity Comparador4 is port(
    A: in std_logic_vector(2 downto 0);
    S: out std_logic );
end Comparador4;

architecture compara of Comparador4 is
begin
    process(A)
    begin
        if (A = "100") then
            S <= '1';
        else
            S <= '0';
        end if;
    end process;
end compara;