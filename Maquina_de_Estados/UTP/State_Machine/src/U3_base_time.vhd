--Base time, entidad para convertidor de binario a decimal

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas

entity base_time is
	port(
		clk, ena, rst :in std_logic;
		bt            :out std_logic
	);
end entity;

architecture structural of base_time is

	
component adder_nbits is	--> Sumador
	generic(N:integer:=20);
	port(
		A, B 	:in std_logic_vector(N-1 downto 0);
		Y		:out std_logic_vector(N-1 downto 0)
	);
end component;

component reg_nbits is	  --> Registro tipo D
	generic(N:integer:=20);
	port(
		clk, rst, ena 	:in std_logic;
		D				:in std_logic_vector(N-1 downto 0);
		Q				:out std_logic_vector(N-1 downto 0)
	);	
end component;

component comp_n_bits is   --> Comparador de n bits
	generic(N : integer :=20);  
	port(
		A, B 	:in std_logic_vector(N-1 downto 0);
		Y		:out std_logic
	);
end component;

--Conectar-------------------



signal aux_1 	 : std_logic_vector(19 downto 0):=x"00001";  --Inicializaci�n en 1 del sumador 
signal sm, int_s : std_logic_vector (19 downto 0):= (others =>'0');	
signal as        : std_logic;
--signal nLim      : std_logic_vector (19 downto 0):=x"3d08f";   --249,999  15ms 
--signal nLim      : std_logic_vector (19 downto 0):=x"493df";   --299,999   
--signal nLim      : std_logic_vector (19 downto 0):=x"14437";   --82,999
--signal nLim      : std_logic_vector (19 downto 0):=x"b71af";	--749,999 --tal vez este
signal nLim      : std_logic_vector (19 downto 0):=x"249f0"; 	--150,000
--signal nLim      : std_logic_vector (19 downto 0):=x"c34ff";	--799,999
--signal nLim      : std_logic_vector (19 downto 0):=x"41103";	--266,499
--signal nLim      : std_logic_vector (19 downto 0):=x"00032";	  --50 en Decimal para simulaci�n

begin 
	
   U0: adder_nbits generic map(N=>20)	--Sumador
   port map( 

   A => int_s,
   B => aux_1,
   Y => sm
   );
   
   U1: reg_nbits generic map(N=>20)	--Registro de 20 bits
   port map(
   
   clk => clk,
   ena => ena, 
   rst => as,
   D   => sm,
   Q   => int_s
   );
   
   bt <=  as;
   
   U2: comp_n_bits generic map(N=>20)   --Comparador de 20 bits
   port map(
   
   A => int_s,
   B => nLim,
   Y => as --
   );
   
	
end architecture;