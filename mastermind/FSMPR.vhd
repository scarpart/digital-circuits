library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity FSMPR is port (
    clock, reset, enter, end_game, end_time, end_round: in std_logic;
    R1, R2, E1: out std_logic; 
    E2, E3, E4, E5: out std_logic);
end FSMPR;

architecture behv of FSMPR is
type STATES is (Init, Setup, Play, Count_round, Check, Waiting, Result); 
signal EAtual, PEstado: STATES;
begin 

    process (clock, reset)
        begin
            if (reset = '1') then -- Vai pro estado Init que reseta tudo
        		EAtual <= Init;
        		
            elsif (clock'event and clock = '1') then
                EAtual <= PEstado;
            end if;
        end process;
        
    process(EAtual, enter, end_game, end_time, end_round)
    	begin
    		case EAtual is
    			when Init =>
                    PEstado <= Setup;
                    R1 <= '1'; -- Reseta o contador de segundos do Play
        		    R2 <= '1'; -- Reseta o resto
        		    E1 <= '0'; -- Disable em todos os Enables
        	    	E2 <= '0';
        		    E3 <= '0';
        		    E4 <= '0';
        		    E5 <= '0';
                    
    			when Setup =>
    			    if enter = '1' then
    				    PEstado <= Play;
    				    R1 <= '0'; 
    				    R2 <= '0'; 
    				    E1 <= '1'; -- Enable no Setup
    				else 
    				    PEstado <= Setup;
    				    R1 <= '0'; 
    				    R2 <= '0'; 
    				    E1 <= '1'; -- Enable no Setup
    				end if;
    				
    			when Play =>
    				if enter = '1' then
    				    PEstado <= Check;
    				    E1 <= '0'; -- Disable no setup
    				    E2 <= '1'; -- Enable Registrador da Tentativa e Segundos
    				    E4 <= '0'; -- Disable do Estado Waiting
    				    R1 <= '0'; 
    				elsif end_time = '1' then 
                        PEstado <= Result;
                        E1 <= '0';
                        E2 <= '1'; 
                        E4 <= '0';
                        R1 <= '0';
                    else 
                        PEstado <= Play;
                        E1 <= '0';
                        E2 <= '1';
                        E4 <= '0';
                        R1 <= '0';
                    end if;
                     
                     
                when Check =>
    			    if (end_round = '1' or end_game = '1') then
    			        PEstado <= Result;
    			        E2 <= '0'; -- Disable do Reg de Tentativa e Segundos
    			        R1 <= '1'; -- Reseta o contador de segundos
                    else
                        PEstado <= Count_round;
                        E2 <= '0'; 
                        R1 <= '1'; 
                        end if;
                        
    			when Count_round => 
    			    PEstado <= Waiting;
    				E3 <= '1'; -- Enable do Reg de Contagem de Round
    			    
                        
                when Waiting =>
                    if enter = '1' then
                        PEstado <= Play;
                        E3 <= '0'; -- Disable do Reg de Contagem de Round
                        E4 <= '1'; -- Enable do estado Waiting
                    else
                        PEstado <= Waiting;
                        E3 <= '0'; 
                        E4 <= '1';
                    end if;
                    
                when Result => 
                    if enter = '1' then
                        PEstado <= Init;
                        R1 <= '0'; -- Reseta o contador de segundos
                        E2 <= '0'; -- Desabilita o Reg de Tentativa e Segundos
    			        E5 <= '1'; -- Enable do estado Result
                    else
                        PEstado <= Result;
                        R1 <= '0';
                        E2 <= '0'; 
    				    E5 <= '1';
                    end if;
    			
    		end case;
    	end process;

end behv;