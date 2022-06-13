library ieee;
use ieee.std_logic_1164.all;

entity shiftRegister is
	generic(	n: positive;
				toLeft: boolean;
				toRight: boolean;
				resetValue: integer := 0 );
	port(	-- control
			clk, rst, load, enb: in std_logic;
			op: in std_logic; -- 0: to_left, 1: to_right
			-- data
			inputFromLeft, inputFromRight: in std_logic;
			outputToLeft, outputToRight: out std_logic;
			input: in std_logic_vector(n-1 downto 0);
			output: out std_logic_vector(n-1 downto 0));
end entity;

use ieee.numeric_std.all;

architecture behav0 of shiftRegister is
subtype state is std_logic_vector(n+1 downto 0);
signal currentState, nextState: state;
-- auxiliar signals
signal tempNextState: state;
begin
	-- next state logic
	nextState <= '0'&input&'0' when load = '1' else
						currentstate when enb = '0' else
							tempnextstate;
	toleft: if toleft and not toright generate
		tempnextstate <= currentState(n downto 2) & inputFromRight & currentState(0);
	end generate;
	toright: if not toleft and toright generate
		tempnextstate <= currentState(n+1) & inputFromLeft & currentState(n-1 downto 0);
	end generate;
	both: if toleft and toright generate;
		tempnextstate <= currentState(n+1) & inputFromLeft & currentState(n-1 downto 0) when op = '1' else
								currentState(n downto 2) & inputFromRight & currentState(0);
	end generate;
	
	--memory element
	process(clk, rst)
	begin
		if rst = '1' then
			currentState <= '0'&std_logic_vector(to_unsigned(resetValue, currentState'length-2))&'0';
		elsif rising_edge(clk) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic
	output <= currentState(n downto 1);
	outputToLeft <= currentState(n+1);
	outputToRight <= currentState(0);
end architecture;