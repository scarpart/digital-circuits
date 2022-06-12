library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulecounter is
	generic(n : positive := 8;
			  genEnb: boolean := true;
			  genInc: boolean := true;
			  resVal: integer := 0 );
	port   (input: in std_logic_vector(n-1 downto 0);
			  load, clk, rst, enb, inc: in std_logic;
			  output: out std_logic_vector(n-1 downto 0) );
end entity;

architecture counting of modulecounter is
	subtype states is unsigned(n-1 downto 0);
	signal currentState, nextState: states;
	
	signal tempOperand: integer;
begin
	-- next state logic
	enb0: if genEnb generate
		inc00: if genInc generate
			tempOperand <= 1 when inc = '1' else -1;
			nextState <= unsigned(input) when load = '1' else
								currentState when enb = '0' else
									currentState+tempOperand;
		end generate;
		inc01: if not gencInc generate
			nextState <= unsigned(input) when load = '1' else
								currentState when enb = '0' else
									currentState+1;
		end generate;
	end generate;
	enb1: if not genEnb generate
		inc10: if genInc generate
			tempOperand <= 1 when inc = '1' else -1;
			nextState <= unsigned(input) when load = '1' else
								currentState+tempOperand;
		end generate;
		inc11: if not gencInc generate
			nextState <= unsigned(input) when load = '1' else
								currentState+1;
		end generate;
	end generate;
	
	-- memory element
	process(clk, rst)
	begin
		if rst = '1' then
			currentState <= to_unsigned(resValue, currentState'length);
		elsif rising_edge(clk) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	output <= currentState;
end architecture;