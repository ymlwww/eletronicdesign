library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity vgacontroller is
	port(
		 zombykind: in std_logic_vector(9 downto 0);
		 zombystoration: out std_logic_vector(8 downto 0);
		 recovertime: out std_logic_vector(6 downto 0);
		 fire: out std_logic_vector(7 downto 0);
		 fireinterval: out std_logic_vector(3 downto 0);
		 fireradius: out std_logic_vector(7 downto 0);
		 sunariseinterval: out std_logic_vector(5 downto 0);
		 address:out std_logic_vector(18 downto 0); --注意加零
		 lasttime:out std_logic_vector(3 downto 0)
	);
end vgacontroller;