
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register43bit is
	port( 
		input_data : in std_logic_vector(42 downto 0);
		Clk : in std_logic;
		WE : in std_logic;
		arst : in std_logic;
		cdb_q : in std_logic_vector(4 downto 0 );
		cdb_data : in std_logic_vector(31 downto 0);
		output_data : out std_logic_vector(42 downto 0)
	);
end Register43bit;

architecture Behavioral of Register43bit is
signal tmp : std_logic_vector(42 downto 0);
begin
process
begin
	wait until clk'event and clk='1';
	if(arst ='1') then
		tmp <= "0000000000000000000000000000000000000000000";
	else 
			if(we='1') then 
				if(cdb_q = input_data(36 downto 32) and cdb_q /= "11000") then 
					tmp(42)<='1';
					tmp(41 downto 37) <= input_data(41 downto 37);
					tmp(36 downto 32) <= "00000";
					tmp(31 downto 0)<=cdb_data;
				elsif (cdb_q /= input_data(36 downto 32)) then 
					tmp <= input_data;
				end if;
			else
				if(cdb_q = tmp(36 downto 32) and cdb_q /="11000") then
					tmp(42)<='1';
					tmp(41 downto 37) <= tmp(41 downto 37);
					tmp(36 downto 32)<="00000";
					tmp(31 downto 0) <= cdb_data;
				else
					tmp <= tmp;
				end if;
			end if;
		end if;
end process;
output_data <= "0000000000000000000000000000000000000000000" when arst='1' else
					tmp;
end Behavioral;

