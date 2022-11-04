--Sumador "N" bits arquitectura funcional
library ieee;
use ieee.std_logic_1164.all; --> Operacione logicas
use ieee.numeric_std.all;	 --> Operaciones aritmeticas

entity adder_nbits is
	generic(N : integer :=20);  --> Parametrizacion
	port(
		A, B 	:in std_logic_vector(N-1 downto 0);
		Y		:out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture artithmetic of adder_nbits is

signal Ys	: signed(N-1 downto 0):= (others =>'0');  --"signed" son las señales de la biblioteca numeric

begin
	
	Ys <= signed(A) + signed(B);
	Y <= std_logic_vector(Ys);	--> para volver a convertir "Ys" a formato de "std_logic"
		
end architecture;