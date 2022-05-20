library ieee;
use ieee.std_Logic_1164.all;

entity datapath is port( 
    
    Switches                     : in  std_logic_vector(15 downto 0);
    Clock1, Clock500             : in  std_logic;
    R1, R2                       : in  std_logic;
    E1, E2, E3, E4, E5           : in  std_logic;
    ledr                         : out std_logic_vector(15 downto 0);
    hex0, hex1, hex2, hex3       : out std_logic_vector(6 downto 0);
    hex4, hex5, hex6, hex7       : out std_logic_vector(6 downto 0);
    end_game, end_time, end_round: out std_logic);
    
end datapath;


architecture arc_data of datapath is


signal code, user, s_dec_term, rom0_s, rom1_s, rom2_s, rom3_s: std_logic_vector(15 downto 0); 
signal result: std_logic_vector(7 downto 0);
signal h0_00, h0_01, h0_10, h0_11, h1_01, h1_11, h2_00, h2_01, h2_10, h2_11, h3_01, h3_11, h4_1, h6_1, h7_1: std_logic_vector(6 downto 0);
signal sel: std_logic_vector(5 downto 0);
signal s_time, X, s_soma, F: std_logic_vector(3 downto 0);
signal P, P_reg, E, E_reg: std_logic_vector(2 downto 0);
signal sel_mux: std_logic_vector(1 downto 0);
signal concat0, concat1, concat2: std_logic_vector(3 downto 0);
signal end_gamee, end_timee, cmp0_s, cmp1_s, cmp2_s, cmp3_s: std_logic;

    component Registrador is
    generic (n : integer := 4);
    port (
        PROX_ESTADO: in std_logic_vector(n-1 downto 0 );
        RESET      : in std_logic;
        ENABLE     : in std_logic;
        CLK        : in std_logic;
        S          : out std_logic_vector(n-1 downto 0) );
    end component;
    
    component Comparador4 is port(
        A: in std_logic_vector(2 downto 0);
        S: out std_logic );
    end component;
    
    component Comparador is port(
        EntUser: in std_logic_vector(3 downto 0);
        EntCode: in std_logic_vector(3 downto 0);
        S      : out std_logic );
    end component;
    
    component SomaP is port (
        CompIn0, CompIn1, CompIn2, CompIn3: in std_logic;
        S                                 : out std_logic_vector(2 downto 0) );
    end component;
    
    component counter_round is
    port (
        RST: in std_logic;
        EN : in std_logic;
        CLK: in std_logic;
        TC : out std_logic;
        S  : out std_logic_vector(3 downto 0) := (others => '0') );
    end component;
    
    component counter_time is
    port (
        RST: in std_logic;
        EN : in std_logic;
        CLK: in std_logic;
        TC : out std_logic;
        S  : out std_logic_vector(3 downto 0) := (others => '0') );
    end component;
    
    component dec7seg is
    port (
        A: in std_logic_vector(3 downto 0);
        S: out std_logic_vector(6 downto 0) );
    end component;
    
    component mux2x1 is
    port (
        entr0, entr1: in std_logic_vector(6 downto 0);
        selecao     : in std_logic;
        S           : out std_logic_vector(6 downto 0) );
    end component;
    
    component mux4x1 is
    generic (n : integer := 8);
    port (
        entr0, entr1, entr2, entr3: in std_logic_vector(n-1 downto 0);
        selecao                   : in std_logic_vector(1 downto 0);
        S                         : out std_logic_vector(n-1 downto 0) );
    end component;
    
    
    component decoder_termometrico is
    port(
        tempo: in std_logic_vector(3 downto 0);
        E_and: in std_logic;
        s_dec: out std_logic_vector(15 downto 0)
        );
    end component;
    
    component selector is
    port(
        in0, in1, in2, in3: in  std_logic;
        saida             : out std_logic_vector(1 downto 0) );
    end component;
    
    component comp_e is
    port (
        inc, inu: in  std_logic_vector(15 downto 0);
        E       : out std_logic_vector(2 downto 0) );
    end component;
    
    component ROM0 is
    port (
        address: in std_logic_vector(3 downto 0);
        data   : out std_logic_vector(15 downto 0) );
    end component;
    
    component ROM1 is
    port (
        address: in std_logic_vector(3 downto 0);
        data   : out std_logic_vector(15 downto 0) );
    end component;

    component ROM2 is
    port (
        address: in std_logic_vector(3 downto 0);
        data   : out std_logic_vector(15 downto 0) );
    end component;

    component ROM3 is
    port (
        address: in std_logic_vector(3 downto 0);
        data   : out std_logic_vector(15 downto 0) );
    end component;
    

begin

end_game <= end_gamee;
end_time <= end_timee;
    
    --- Selecionando o código a partir de um input do jogador:
    RegCode: Registrador generic map(6) port map(Switches(5 downto 0), R2, E1, Clock500, SEL);
    ROM_0: ROM0 port map(SEL(5 downto 2), rom0_s);
    ROM_1: ROM1 port map(SEL(5 downto 2), rom1_s);
    ROM_2: ROM2 port map(SEL(5 downto 2), rom2_s);
    ROM_3: ROM3 port map(SEL(5 downto 2), rom3_s);
    MuxCode: Mux4x1 generic map(16) port map(rom0_s, rom1_s, rom2_s, rom3_s, SEL(1 downto 0), code);
    
    --- Selecionando a tentativa do usuário:
    RegUser: Registrador generic map(16) port map(Switches(15 downto 0), R2, E2, Clock500, user);
    
    --- Comparando a entrada do usuário com o código secreto:
        --- Parte do P:
        COMP_0: Comparador port map(user(3 downto 0), code(3 downto 0), cmp0_s);
        COMP_1: Comparador port map(user(7 downto 4), code(7 downto 4), cmp1_s);
        COMP_2: Comparador port map(user(11 downto 8), code(11 downto 8), cmp2_s);
        COMP_3: Comparador port map(user(15 downto 12), code(15 downto 12), cmp3_s);
        SOMA_P: SomaP port map(cmp0_s, cmp1_s, cmp2_s, cmp3_s, P);
    
        --- Parte do E:
        E_COMP: Comp_e port map(user, code, E);
    
    --- Verificação se P é 4, que indica que o usuário acertou e o jogo acabará:
    COMP_4_P: Comparador4 port map(P, end_gamee);
    
    --- P_REG e E_REG que vão para os dec7seg:
    REG_P: Registrador generic map(3) port map(P, R2, E4, Clock500, P_Reg);
    REG_E: Registrador generic map(3) port map(E, R2, E4, Clock500, E_Reg);
    
    --- Contadores de tempo e de round:
    COUNTER1: Counter_time port map(R1, E2, Clock1, end_timee, s_time);
    COUNTER2: Counter_round port map(R2, E3, Clock500, end_round, X);
        --- Do contador de round, vamos para o Decoder Termométrico:
        DEC_TERM: decoder_termometrico port map(X, E1, s_dec_term);
        LEDR <= s_dec_term;
        
        --- Soma para achar obter o F:
        F <= not X when end_timee = '0' else
             "0000";
        
    --- Gerando o resultado:
    result <= "000" & end_gamee & F;

    --- Gerando a entrada de seleção dos multiplexadores:
    SLC: Selector port map(E1, E2, R1, E5, sel_mux);
    
    --- Selecionando as sáidas nos multiplexadores (de baixo para cima no mapa):
        --- Concatenações de bits:
        concat0 <= "00" & SEL(1 downto 0);
        concat1 <= '0' & E_REG(2 downto 0);
        concat2 <= '0' & P_REG(2 downto 0);
        
        --- MUX0 com seleção sel_mux:
        decod1: dec7seg port map(concat0, h0_00);
        decod2: dec7seg port map(user(3 downto 0), h0_01);
        decod3: dec7seg port map(concat1, h0_10);
        decod4: dec7seg port map(code(3 downto 0), h0_11);
        mux0: mux4x1 generic map(7) port map(h0_00, h0_01, h0_10, h0_11, sel_mux, HEX0);
        
        --- MUX1 com seleção sel_mux, os vetores no port do mux são L e E, respectivamente:
        decod5: dec7seg port map(user(7 downto 4), h1_01);
        decod6: dec7seg port map(code(7 downto 4), h1_11);
        mux1: mux4x1 generic map(7) port map("1000111", h1_01, "0000110", h1_11, sel_mux, HEX1);
        
        --- MUX2 com seleção sel_mux:
        decod7 : dec7seg port map(SEL(5 downto 2), h2_00);
        decod8 : dec7seg port map(user(11 downto 8), h2_01);
        decod9 : dec7seg port map(concat2, h2_10);
        decod10: dec7seg port map(code(11 downto 8), h2_11);
        mux2: mux4x1 generic map(7) port map(h2_00, h2_01, h2_10, h2_11, sel_mux, HEX2);
        
        --- MUX3 com seleção sel_mux, os vetores no port do mux são C e P, respectivamente:
        decod11: dec7seg port map(user(15 downto 12), h3_01);
        decod12: dec7seg port map(code(15 downto 12), h3_11);
        mux3: mux4x1 generic map(7) port map("1000110", h3_01, "0001100", h3_11, sel_mux, HEX3);
        
        --- MUX4 com seleção E2:
        decod13: dec7seg port map(s_time, h4_1);
        mux4: mux2x1 port map("1111111", h4_1, E2, HEX4);
        
        --- MUX5 com seleção E2, o segundo vetor do port é a letra 't':
        mux5: mux2x1 port map("1111111", "0000111", E2, HEX5);
        
        --- MUX6 com seleção E5:
        decod14: dec7seg port map(result(3 downto 0), h6_1);
        mux6: mux2x1 port map("1111111", h6_1, E5, HEX6);
        
        --- MUX7 com seleção E5:
        decod15: dec7seg port map(result(7 downto 4), h7_1);
        mux7: mux2x1 port map("1111111", h7_1, E5, HEX7);
        

end arc_data;
