library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulecounterr is
    generic(n          : positive := 8;
            generateEnb: boolean := true;
            generateInc: boolean := true;
            resetValue : integer := 0;
            module     : integer := 6 );
    port   (input: in std_logic_vector(n-1 downto 0);
            load, enb, clk, rst, inc: in std_logic;
            output: out std_logic_vector(n-1 downto 0) );
end entity;

architecture counting of modulecounterr is
    subtype states is unsigned(n-1 downto 0);
    signal currentState, nextState: states;
    
    -- intermediary helper signal
    signal tempOperand: integer;
begin
    -- next state logic
    generate0: if generateEnb generate
        generate00: if generateInc generate
            tempOperand <= 1 when inc = '1' else -1;
            nextState   <= unsigned(input) when load = '1' else
                                currentState when enb = '0' else
                                    currentState+tempOperand;
        end generate;
        generate01: if not generateInc generate
            nextState <= unsigned(input) when load = '1' else
                            currentState when enb = '0' else
                                currentState+1;
        end generate;
    end generate;
    
    generate1: if not generateEnb generate
        generate10: if generateInc generate
            tempOperand <= 1 when inc = '1' else -1;
            nextState   <= unsigned(input) when load = '1' else
                            currentState+tempOperand;
        end generate;
        generate11: if not generateInc generate
            nextState   <= unsigned(input) when load = '1' else
                            currentState+1;
        end generate;
    end generate;
    
    -- memory element
    process(clk, rst)
    begin
        if (rst = '1') or (to_integer(unsigned(currentState))) = module then
            currentState <= to_unsigned(resetValue, currentState'length);
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;
    
    -- output logic
    output <= std_logic_vector(currentState);
end architecture;
