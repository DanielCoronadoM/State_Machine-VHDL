library ieee;
use ieee.std_logic_1164.all;

entity mux_3_to_1_4b is
	Port(
	U, D, C : in std_logic_vector (3 downto 0);
	S       : in std_logic_vector (1 downto 0);
	Y       : out std_logic_vector (3 downto 0)
	);
end entity;

architecture functional of mux_3_to_1_4b is
begin
	with S select
	Y <= 	U when "01",
			D when "10",
			C when others;
end architecture;
