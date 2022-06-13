library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sampleFSM is
port(start, stop, regreset: out std_logic;
	  counting: in std_logic;
	  clk, rst: in std_logic );
end entity;

architecture selecting of sampleFSM is
	type STATES is (s0, s1, s2);
	signal currstate, nextstate: STATES;
begin
	-- next state logic
	process(clk)
	begin
		case currstate is
			when s0 =>
				nextstate <= s1;
			when s1 =>
				if counting = '1' then
					nextstate <= s1;
				else
					nextstate <= s2;
				end if;
			when s2 =>
				nextstate <= s0;
		end case;
	end process;
	
	-- memory element
	process(clk, rst)
	begin
		if rst = '1' then
			currstate <= s0;
		elsif rising_edge(clk) then
			currstate <= nextstate;
		end if;
	end process;
	
	-- output logic
	with currstate select:
		start <= '1' when s0 else '0';
		stop <= '1' when s2 else '0';
		regreset <= '1' when s0  else '0';
end architecture;