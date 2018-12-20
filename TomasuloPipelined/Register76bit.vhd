
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register76bit is
	port(
		WE : in STD_LOGIC;
		RST : in STD_LOGIC;
		Clk : in STD_LOGIC;
		Data : IN STD_LOGIC_VECTOR(75 DOWNTO 0);
		Update: in std_logic;
		update_data: in std_logic_vector(73 downto 0);
		DOUT : out STD_LOGIC_VECTOR (75 DOWNTO 0)
	);
end Register76bit;

architecture Behavioral of Register76bit is
	signal tmp : std_logic_vector(73 downto 0);
	signal op_sig : std_logic_vector(1 downto 0);
	
begin
	process(we,rst,update,update_data)
	begin
		--wait until clk'event and clk='1';
		if (RST = '1') then
			tmp <=  "11111000000000000000000000000000000001111100000000000000000000000000000000";
			op_sig <= "11";
		end if;
			if (WE = '1' and update = '0') then
				tmp <= Data(73 downto 0);
				op_sig <= Data(75 downto 74);
			end if;
			if (update = '1') then
				tmp <= update_data;
			end if;
	end process;	
	DOUT <= op_sig & tmp;
end Behavioral;

