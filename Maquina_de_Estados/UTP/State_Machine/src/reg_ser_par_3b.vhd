library ieee;
use ieee.std_logic_1164.all;


entity reg_ser_par_3b is
	port(
		clk,ena,rst : in std_logic ; 
		d,sh 		: in std_logic ;
		Q       	: out std_logic_vector (2 downto 0)
	);
end entity;	


architecture functional of reg_ser_par_3b is
--signal ena_s: std_logic;	
signal Qp,Qf: std_logic_vector (2 downto 0) := (others =>'0');
begin

	--ena_s <= sh and ena;
	Qf <= Qp (1 downto 0) & d; 
	Q<= Qp;

	Reg: process (clk)		 
	begin 
	if rising_edge (clk) then 
		if (rst='1') then 
			Qp <= (others =>'0');
		elsif (ena ='1') and (sh = '1') then 
			Qp<= Qf;   
		end if;
	end if;

	end process;
end architecture;