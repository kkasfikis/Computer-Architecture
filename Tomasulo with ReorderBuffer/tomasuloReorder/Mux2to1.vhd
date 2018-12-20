
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use UNISIM.VComponents.all;

entity Mux2to1 is
port( 
		D0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		D1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Mux_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Selector : IN STD_LOGIC
);
end Mux2to1;

architecture Behavioral of Mux2to1 is
	
	signal mux_output_signal : std_logic_vector(31 downto 0);

begin

	mux_output_signal <= D0 when selector='0' else D1;
	Mux_out <= mux_output_signal;
end Behavioral;

