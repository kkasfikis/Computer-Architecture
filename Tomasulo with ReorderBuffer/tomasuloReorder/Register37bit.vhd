library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register37bit is
	port( 
			Data : in std_logic_vector(31 downto 0);
	      Clk : in std_logic;
			WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(31 downto 0)
	);
end Register37bit;

architecture Behavioral of Register37bit is

	signal tmp : std_logic_vector(31 downto 0);

begin
	process--(arst,Q_WE,DATA_we)
	 
	 begin
	 wait until clk'event and clk='1';
	 if (arst = '1') then
		tmp <=  "00000000000000000000000000000000";
	 else
		 if (WE = '1') then
			tmp(31 downto 0) <= Data;
		 else 
			tmp <= tmp;
		 end if;
	end if;
	end process;	
	Dout <= tmp(31 downto 0);
end Behavioral;

