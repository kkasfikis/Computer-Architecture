
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Comparator5bit is
     port( input1 : in std_logic_vector(4 downto 0);
	        input2 : in std_logic_vector(4 downto 0);
			  output : out std_logic;
			  rst : in std_logic
			  );
end Comparator5bit;

architecture Behavioral of Comparator5bit is

begin
	output <=	'1' When input1=input2 else 
					'0' when rst='1' 
					else '0';
end Behavioral;

