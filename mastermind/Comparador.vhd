library IEEE;
use IEEE.std_logic_1164.all;

entity Comparador is port (
    EntUser: in std_logic_vector(3 downto 0);
    EntCode: in std_logic_vector(3 downto 0);
    S: out std_logic );
end Comparador;

architecture comparando of Comparador is
begin
    process(EntUser, EntCode)
    begin
        S <= '0';
        if (EntUser = EntCode) then
            S <= '1';
        end if;
    end process;
end comparando;