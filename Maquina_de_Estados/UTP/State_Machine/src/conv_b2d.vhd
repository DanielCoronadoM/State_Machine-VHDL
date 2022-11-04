--Covertidor Binario a decimal con algoritmo de m�quina de estados
--Algorith state machine

library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas
use ieee.std_logic_unsigned.all;


entity conv_b2d is
	port(
		BIN				:in std_logic_vector(7 downto 0);
		start			:in std_logic;
		clk, ena, rst 	:in std_logic;
		U, D, C			:out std_logic_vector(3 downto 0)
	);
end entity;

architecture artithmetic of conv_b2d is

signal Qp, Qf			:std_logic_vector(3 downto 0):="0000";
signal Q					:std_logic_vector(3 downto 0):="0000";
signal busy				:std_logic:= '0';	   				--Bandera de "ocupado"
signal Bs				:unsigned(7 downto 0):= (others =>'0');	   	--unsigned para binario natural sin signo
signal As, Rs			:unsigned(3 downto 0):= (others =>'0');

--Auxiliares 
signal U_aux			:unsigned(3 downto 0):= (others =>'0'); --auxiliar para tomar solo los primeros 4 bits de Bs
signal aux_0			:std_logic_vector(3 downto 0):= (others =>'0');
signal busy_0			:std_logic:= '0';
signal busy_1			:std_logic:= '1';

begin
	

	FF: process(clk) --Lista de sensibilidad (A que reacciona)
	begin
		if rising_edge(clk) then  --Detector de flancos positivos
			if (rst = '1') then
				Qp <=  x"1"; --S0
			elsif (ena = '1') then
				Qp <= Qf;  
			   
			Case Qp is		 --Se usa formato hexadecimal	
				------------------------------State 0
			when x"1" => 	--S0
				busy <= busy_0;
				
				if(start = '1')then 	--True
					Qf <= x"2";	--S1
				else
					Qf <= x"1";	--S0	--False
				end if;
				
			-----------------------------State 1
			when x"2" =>
				busy <= busy_1;
				As <= "0000";
				Bs <= unsigned(BIN);
				Rs <= "0000";
				
				Qf <= x"3"; --S2
		
			-----------------------------State 2
			when x"3" =>
				if(Bs < x"64")then	 --x64 = 100 Decimal   --True
					Qf <= x"5"; --S4
				else
					Qf <= x"4"; --S3		 			   --False
				end if;
			
			------------------------------State 3
			when x"4" =>
				Bs <= Bs - 100;
				As <= As + 1;
				
				Qf <= x"3"; --S2
				
				
			------------------------------State 4
			when x"5" =>
				Rs <= As;
				As <= "0000"; --As = 0
				
				Qf <= x"6"; --S5
				
			------------------------------State 5
			when x"6" =>	
				if(Bs < x"A")then	--xA = 10 Decimal  --True
					
					Qf <= x"8"; --S7
				else
					Qf <= x"7"; --S6  				  --False
				end if;
				
				
			------------------------------State 6
			when x"7" =>	
				Bs <= Bs - 10;
				As <= As + 1;
				
				Qf <= x"6"; --S5
				
			----------------------------State 7	
			when others =>
				U_aux <= Bs(3 downto 0); --Se "recorta" el vector Bs de 0 a 3 y se asigna a U_aux
				U <= std_logic_vector(U_aux);	 --U toma el valor de U_aux para la salida de 4 bits
				D <= std_logic_vector(As);
				C <= std_logic_vector(Rs);
				
				Qf <= x"1"; --S0
				
			end case;
				
			end if;
		end if;
	end process;
	
end architecture;