library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register38bit is
	port( 
			Data : in std_logic_vector(37 downto 0);
	      Clk : in std_logic;
			Data_WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(37 downto 0)
	);
end Register38bit;

architecture Behavioral of Register38bit is

	signal tmp : std_logic_vector(37 downto 0);

begin
	process(clk,arst)--(arst,Q,Q_WE,DATA_we,data)
	 begin
	 --wait until clk' event and clk='1';
	 if (arst='1' and rising_edge(clk))then
	  tmp <= "00000000000000000000000000000000000000";
	 else
		 if(rising_edge(clk))then
			 if (Data_WE = '1') then
					tmp <= data;
			 else
					tmp <=tmp;
			 end if;
		 end if;
	 end if;
	end process;	
	dout <= tmp;
end Behavioral;

