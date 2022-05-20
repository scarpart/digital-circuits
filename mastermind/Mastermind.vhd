library ieee;
use ieee.std_logic_1164.all;

entity Mastermind is
port(SW                : in std_logic_vector(15 downto 0);
     LEDR              : out std_logic_vector(15 downto 0);
     CLK_1Hz, CLK_500Hz: in std_logic;
     KEY               : in std_logic_vector(1 downto 0);
     hex0, hex1, hex2  : out std_logic_vector(6 downto 0);
     hex3, hex4, hex5  : out std_logic_vector(6 downto 0);
     hex6, hex7        : out std_logic_vector(6 downto 0) );
end Mastermind;

architecture jogo of Mastermind is
signal end_game, end_time, end_round: std_logic;
signal R1, R2, E1, E2, E3, E4, E5   : std_logic;
signal enter, reset                 : std_logic;

    component ButtonSync is
    port(KEY0, KEY1, CLK: in  std_logic;
         Enter, Reset   : out std_logic);
    end component;
    
    component FSMPR is
    port(clock, reset, enter, end_game, end_time, end_round: in std_logic;
         R1, R2, E1, E2, E3, E4, E5: out std_logic);
    end component;
    
    component Datapath is
    port(Switches                     : in  std_logic_vector(15 downto 0);
         Clock1, Clock500             : in  std_logic;
         R1, R2                       : in  std_logic;
         E1, E2, E3, E4, E5           : in  std_logic;
         ledr                         : out std_logic_vector(15 downto 0);
         hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
         hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
         end_game, end_time, end_round: out std_logic);
    end component;
    
begin
    
    Synch   : ButtonSync port map(KEY(0), KEY(1), CLK_500Hz, enter, reset);
    
    Controle: FSMPR port map(CLK_500Hz, reset, enter, end_game, end_time, end_round,
                             R1, R2, E1, E2, E3, E4, E5);

    Data    : Datapath port map(SW(15 downto 0), CLK_1Hz, CLK_500Hz, R1, R2,
                                E1, E2, E3, E4, E5, LEDR(15 downto 0), hex0, hex1,
                                hex2, hex3, hex4, hex5, hex6, hex7, end_game,
                                end_time, end_round);

end jogo;
        
     