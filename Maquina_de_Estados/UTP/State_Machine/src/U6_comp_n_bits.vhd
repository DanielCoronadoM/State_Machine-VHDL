--Comparador 2 entradas de 4 bits
library ieee;
use ieee.std_logic_1164.all;

entity comp_n_bits is
	generic(N : integer :=20);  --> Parametrizacion
	port(
		A, B 	:in std_logic_vector(N-1 downto 0);
		Y		:out std_logic
	);
end entity;

architecture funtional of comp_n_bits is

begin
	Y <= '1' when A>B else '0';	   --	When, else, operador relacional

end architecture;