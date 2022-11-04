--Decodificador BCD 7seg Estilo funcional
library ieee;
use ieee.std_logic_1164.all;

entity decod_bcd2seg7 is
	Port(
		BCD 			: in std_logic_vector(3 downto 0);
		SEG				: out std_logic_vector(6 downto 0)
	);
end entity;

architecture funtional of decod_bcd2seg7 is

begin
	--	When, else, operador relacional
		with BCD select
		SEG 	<= 	"0111111" when "0000",
	 	       		"0000110" when "0001",
	 	       		"1011011" when "0010",
	 	       		"1001111" when "0011",
	 	       		"1100110" when "0100",
	 		   		"1101101" when "0101",
	           		"1111101" when "0110",
	           		"0000111" when "0111",
	           		"1111111" when "1000",
	           		"1101111" when "1001",
	           		"1000000" when others;
			   
	
	

end architecture;