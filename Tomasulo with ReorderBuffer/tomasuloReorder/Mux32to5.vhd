
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux32to5 is
      port( R0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R4 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R5 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R6 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R7 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R8 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R9 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R10 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R11 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R12 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R13 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R14 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R15 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R16 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R17 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R18 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R19 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R20 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R21 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R22 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R23 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R24 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R25 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R26 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R27 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R28 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R29 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R30 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				R31 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				Mux_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				Selector : IN STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
end Mux32to5;

architecture Behavioral of Mux32to5 is
	
	signal mux_output_signal : std_logic_vector(31 downto 0);

begin

	mux_output_signal <= R0 when selector="00000" else
								R1 when selector="00001" else
								R2 when selector="00010" else
								R3 when selector="00011" else
								R4 when selector="00100" else
								R5 when selector="00101" else
								R6 when selector="00110" else
								R7 when selector="00111" else
								R8 when selector="01000" else
								R9 when selector="01001" else
								R10 when selector="01010" else
								R11 when selector="01011" else
								R12 when selector="01100" else
								R13 when selector="01101" else
								R14 when selector="01110" else
								R15 when selector="01111" else
								R16 when selector="10000" else
								R17 when selector="10001" else
								R18 when selector="10010" else
								R19 when selector="10011" else
								R20 when selector="10100" else
								R21 when selector="10101" else
								R22 when selector="10110" else
								R23 when selector="10111" else
								R24 when selector="11000" else
								R25 when selector="11001" else
								R26 when selector="11010" else
								R27 when selector="11011" else
								R28 when selector="11100" else
								R29 when selector="11101" else
								R30 when selector="11110" else
								R31 when selector="11111" else
								mux_output_signal;
	Mux_out <= mux_output_signal;
end Behavioral;

