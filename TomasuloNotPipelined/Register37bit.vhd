library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register37bit is
	port( 
			Data : in std_logic_vector(31 downto 0);
			Q : in std_logic_vector(4 downto 0);
	      Clk : in std_logic;
			Data_WE : in std_logic;
			Q_WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(31 downto 0);
			Qout : out std_logic_vector(4 downto 0)
	);
end Register37bit;

architecture Behavioral of Register37bit is

	signal tmp : std_logic_vector(36 downto 0);

begin
	process(arst,Q,Q_WE,DATA_we,data)
	 begin
	 if (arst = '1') then
		tmp <=  "0000000000000000000000000000000000000";
	 else
		 if (Data_WE = '1') then
				tmp(31 downto 0) <= Data;
				tmp(36 downto 32) <= "00000";
		 end if;
		 if (Q_WE = '1' AND tmp(36 downto 32) = "00000") then
				tmp(36 downto 32) <= Q;
				tmp(31 downto 0) <= "00000000000000000000000000000000";
		 end if;
		 if(arst = '0' and Data_WE = '0' and (Q_WE = '0' OR tmp(36 downto 32) /= "00000")) then
				tmp <= tmp;
		 end if;
	end if;
	end process;	
	Dout <= tmp(31 downto 0);
	Qout <= tmp(36 downto 32);	
end Behavioral;

