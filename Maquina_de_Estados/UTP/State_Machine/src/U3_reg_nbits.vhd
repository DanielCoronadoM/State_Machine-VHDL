--Registro de N bits tipo D
--Registro serie-paralelo-8b "Descripcion funcional"
library ieee;
use ieee.std_logic_1164.all;

entity reg_nbits is
	generic(N:integer:=20);
	port(
		clk, rst, ena   :in std_logic;
		D				:in std_logic_vector(N-1 downto 0);
		Q				:out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture funtional of reg_nbits is

--signal Qn  :std_logic:='0';  --qn es el estado anterior y se inicializa en 0
signal Qn	: std_logic_vector(19 downto 0):=x"00000";

begin
	
	Q <= Qn;
	
	Reg:process(clk)
	begin
		if rising_edge(clk) then
			if (rst = '1') then
				Qn <= (others =>'0');
			elsif (ena = '1') then
				Qn <= D;
			end if;
		end if;
	end process;	
end architecture;