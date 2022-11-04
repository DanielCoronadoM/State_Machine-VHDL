--Contador ascendente arquitectura funcional
library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas

entity  dec_ctrl_bin2dec7seg is
	port(
		BIN				:in std_logic_vector(7 downto 0);
		clk, ena, rst	:in std_logic;
		SEG				:out std_logic_vector(6 downto 0);
		DISP_U			:out std_logic;
		DISP_D			:out std_logic;
		DISP_C			:out std_logic	
	);
end entity;

architecture structural of dec_ctrl_bin2dec7seg is

--Llamar componentes--------------------------------	
component conv_b2d is	--> Convertidor B2D (Maquina de estados)
	port(
		BIN				:in std_logic_vector(7 downto 0);
		start			:in std_logic;
		clk, ena, rst 	:in std_logic;
		U, D, C			:out std_logic_vector(3 downto 0)
	);
end component;


component decod_bcd2seg7 is	  --> Decodificador bcd 7 seg
	port(
		BCD 			: in std_logic_vector(3 downto 0);
		SEG				: out std_logic_vector(6 downto 0)
	);	
end component;


component conv_b2sel is   --> Selector (SEL)  
	port(
		a, b, c : in std_logic;
		SEL  	: out std_logic_vector(1 downto 0)
	);
end component;


component mux_3_to_1_4b is --> Multiplexor
	Port(
		U, D, C : in std_logic_vector (3 downto 0);
		S       : in std_logic_vector (1 downto 0);
		Y       : out std_logic_vector (3 downto 0)
	);
end component;


component starter is	  --> Starter
	port(
		a,b,c 	: in std_logic ;
		y       : out std_logic
	);	
end component;


component base_time is	  --> Base time
	port(
		clk, ena, rst :in std_logic;
		bt            :out std_logic
	);	
end component;


component reg_ser_par_3b is	  --> Registro serie-paralelo
	port(
		clk,ena,rst : in std_logic ; 
		d,sh 		: in std_logic ;
		Q       	: out std_logic_vector (2 downto 0)
	);	
end component;

--Conectar componentes -----------------------------------------------	



signal bt_s, st_s, start_s 			:std_logic;			--Se�ales de 1 bits

signal conv_U, conv_D, conv_C, Ys	:std_logic_vector(3 downto 0):=(others => '0'); --Se�ales de 4 bits

signal SEL_s						:std_logic_vector(1 downto 0);					--Se�ales de 2 bits

signal U_s, D_s, C_s				:std_logic;					--Se�ales de 1 bits




--signal As, Np	 : std_logic_vector(27 downto 0):=(others => '0');
--signal aux_1 	: std_logic_vector(27 downto 0):=x"00001";



begin
	 UO : conv_b2d 	--Convertidor binario a decimal
		port map(
			BIN 	=>	BIN,					   
			start 	=>	start_s,
			clk 	=>	clk,
			ena	   	=>	ena,
			rst		=>	rst,
			U		=>	conv_U,
			D		=>	conv_D,
			C	 	=>	conv_C
		);
	
	U1 : mux_3_to_1_4b 	--Multiplexor
		port map(
			U  		=>	conv_U,
			D		=>  conv_D,
			C		=>  conv_C,
			S		=>  SEL_s,
			Y		=>	Ys
		);
	
	U2 : decod_bcd2seg7 	--decodificador 7seg
		port map(
			BCD		=>  Ys,
			SEG		=>	SEG
		);
	
	U3 : base_time 	--base_time
		port map(
			clk		=> 	clk,
			ena		=>	ena,
			rst		=>	rst,
			bt		=>	bt_s
		);
		
	U4 : reg_ser_par_3b 	--registro serie-paralelo
		port map(
			d		=>	st_s,
			sh		=>	bt_s,
			clk		=> 	clk,
			ena		=>	ena,
			rst		=>	rst,
			Q(0)	=>	U_s,
			Q(1)	=>	D_s,
			Q(2)	=>	C_s
		);
	
	U5 : conv_b2sel 	--selector de multiplexor
		port map(
			a		=>	U_s,
			b		=>	D_s,
			c		=>	C_s,
			SEL		=>	SEL_s
		);
	
	U6 : starter 	--starter
		port map(
			a		=>	U_s,
			b		=>	D_s,
			c		=>	C_s,
			y		=>	st_s
		);
		
	start_s <= st_s and bt_s;	
	
	DISP_U <=	U_s;
	DISP_D <=	D_s;
	DISP_C <=	C_s;
	
	
end architecture;