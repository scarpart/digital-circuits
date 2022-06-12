library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity graycounter is
	generic(n : positive := 8;
			  rstVal: integer := 0
			  genEnb: boolean := true );
	port   (input: in std_logic_vector(n-1 downto 0);
			  clk, inc, load, rst, enb: in std_logic;
			  output: out std_logic_vector(n-1 downto 0) );
end entity;

architecture counting of graycounter is
	subtype states is unsigned(n-1 downto 0);
	signal currentState, nextState: states;
begin
	-- next state logic
	gen0: if genEnb generate
		nextState <= currentState+1 when enb = '1' else
							currentState;
	end generate;
	gen1: if not genEnb generate
		nextState <= currentState+1;
	end generate;
	
	-- memory element
	process(clk, rst)
	begin
		if rst = '1' then
			currentState <= to_unsigned(rstVal, currentState'length);
		elsif rising_edge(clk) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	output <= currentState xor ('0' & currentState(n-1 downto 1));
end architecture;
			  