
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1_5bit is
port( 
		Q0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Q1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Mux_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		Selector : IN STD_LOGIC
);
end Mux2to1_5bit;

architecture Behavioral of Mux2to1_5bit is
	
	signal mux_output_signal : std_logic_vector(4 downto 0);

begin

	mux_output_signal <= Q0 when selector='0' else Q1;
	Mux_out <= mux_output_signal;
end Behavioral;

