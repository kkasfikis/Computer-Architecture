library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register37bit_cdb is
	port( 
			Data : in std_logic_vector(31 downto 0);
			Q : in std_logic_vector(4 downto 0);
	      Clk : in std_logic;
			WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(31 downto 0);
			Qout : out std_logic_vector(4 downto 0)
	);
end Register37bit_cdb;

architecture Behavioral of Register37bit_cdb is

	signal tmp : std_logic_vector(36 downto 0);

begin

	process(arst,WE,Q,Data)
	 begin
	 --wait until clk'event and clk ='1';
	 if (arst = '1') then
		tmp <=  "1100000000000000000000000000000000000";
	 else
		 if (WE = '1') then
				tmp(31 downto 0) <= Data;
				tmp(36 downto 32) <= Q;
		 else
				tmp <= tmp;
		 end if;
	end if;
	end process;	
	Dout <= tmp(31 downto 0);
	Qout <= tmp(36 downto 32);	
end Behavioral;