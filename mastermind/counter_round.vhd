library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter_round is
port (
    RST: in std_logic;
    EN: in std_logic;
    CLK: in std_logic;
    TC: out std_logic;
    S: out std_logic_vector(3 downto 0) );
end counter_round;

architecture Contando of counter_round is
    
    signal cnt: std_logic_vector(3 downto 0) := "0000";
    
    begin
        process(CLK, RST)
        begin
            if (RST = '1') then
                cnt <= "0000";
            elsif (CLK'event and CLK = '1' and EN = '1') then
                cnt <= cnt + "0001";
            else
                cnt <= cnt;
            end if;
        end process;
        
        TC <= '1' when cnt = "1111" else '0';
        S <= cnt;
    
    end Contando;