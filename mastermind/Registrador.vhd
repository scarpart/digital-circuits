library IEEE;
use IEEE.std_logic_1164.all;

entity Registrador is 
generic(n : integer := 16); 
port (
    PROX_ESTADO: in std_logic_vector(n-1 downto 0);
    RESET: in std_logic;
    ENABLE: in std_logic;
    CLK: in std_logic;
    S: out std_logic_vector(n-1 downto 0) );
end Registrador;

architecture registrador1 of Registrador is
begin
    PROCESS1: process(CLK, RESET)
    begin
        if (RESET = '1') then
            S <= (others => '1');
        elsif (CLK'event and CLK = '1' and ENABLE = '1') then
            S <= PROX_ESTADO;
        end if;
    end process;
end registrador1;

        
