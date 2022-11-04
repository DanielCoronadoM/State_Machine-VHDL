library ieee;
use ieee.std_logic_1164.all;


entity starter is
	port(
		a,b,c 	: in std_logic ;
		y       : out std_logic
	);
end entity;	


architecture functional of starter is
signal an,bn: std_logic;
begin

an <= not a;
bn <= not b; 
y<= bn and an;

end architecture;