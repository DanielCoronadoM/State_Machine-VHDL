library ieee;
use ieee.std_logic_1164.all;

entity conv_b2sel is
	port(
		a, b, c : in std_logic;
		SEL  	: out std_logic_vector(1 downto 0)
	);
end entity;

architecture flow_data of conv_b2sel is 
signal an, bn, cn, m1, m2, s1, s2 : std_logic;

begin
	an <= not a;
	bn <= not b;
	cn <= not c;
	m1 <= cn and b and an;
	m2 <= c and bn and an;
	s1 <= cn and bn and a;
	s2 <= c and bn and an; 
	
	--Salidas
	SEL(1) <= m1 or m2;
	SEL(0) <= s1 or s2;
	
end architecture;