library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regnbits is
	generic(n : positive := 8;
			  rstVal: integer := 0;
			  genEnb: boolean := true );
	port(input: in std_logic_vector(n-1 downto 0);
		  clk, load, enb, rst: in std_logic;
		  output: out std_logic_vector(n-1 downto 0) );
end entity;

architecture registering of regnbits is
	subtype states is std_logic_vector(n-1 downto 0);
	signal currentState, nextState: states;
begin
	-- next state logic
	gen0: if genEnb generate
		nextState <= currentState when enb = '0' else input;
	end generate;
	
	gen1: if not genEnb generate
		nextState <= input;
	end generate;
	
	-- memory element
	process(clk, rst)
	begin
		if rst = '1' then
			currentState <= std_logic_vector(to_unsigned(rstVal, currentState'length));
		elsif rising_edge(clk) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	output <= currentState;
end architecture;