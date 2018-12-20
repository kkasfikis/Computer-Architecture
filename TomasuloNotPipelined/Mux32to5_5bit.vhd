
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux32to5_5bit is
      port( Q0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q2 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q3 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q4 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q5 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q6 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q7 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q8 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q9 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q10 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q11 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q12 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q13 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q14 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q15 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q16 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q17 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q18 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q19 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q20 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q21 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q22 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q23 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q24 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q25 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q26 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q27 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q28 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q29 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q30 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Q31 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
				Mux_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
				Selector : IN STD_LOGIC_VECTOR(4 DOWNTO 0)
		);
end Mux32to5_5bit;

architecture Behavioral of Mux32to5_5bit is
	
	signal mux_output_signal : std_logic_vector(4 downto 0);

begin

	mux_output_signal <= Q0 when selector="00000" else
								Q1 when selector="00001" else
								Q2 when selector="00010" else
								Q3 when selector="00011" else
								Q4 when selector="00100" else
								Q5 when selector="00101" else
								Q6 when selector="00110" else
								Q7 when selector="00111" else
								Q8 when selector="01000" else
								Q9 when selector="01001" else
								Q10 when selector="01010" else
								Q11 when selector="01011" else
								Q12 when selector="01100" else
								Q13 when selector="01101" else
								Q14 when selector="01110" else
								Q15 when selector="01111" else
								Q16 when selector="10000" else
								Q17 when selector="10001" else
								Q18 when selector="10010" else
								Q19 when selector="10011" else
								Q20 when selector="10100" else
								Q21 when selector="10101" else
								Q22 when selector="10110" else
								Q23 when selector="10111" else
								Q24 when selector="11000" else
								Q25 when selector="11001" else
								Q26 when selector="11010" else
								Q27 when selector="11011" else
								Q28 when selector="11100" else
								Q29 when selector="11101" else
								Q30 when selector="11110" else
								Q31 when selector="11111" else
								mux_output_signal;
	Mux_out <= mux_output_signal;
end Behavioral;

