
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity FU_2 is
	port(
		Clk : in std_logic;
		RST : in std_logic;
		OP: in STD_LOGIC_VECTOR(1 DOWNTO 0);
		EX :in STD_LOGIC;
		Vj : in STD_LOGIC_VECTOR(31 downto 0);
		Vk : in STD_LOGIC_VECTOR(31 DOWNTO 0);
		cdb_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	   fu_busy : out std_logic;
		cdb_tag : in std_logic_vector(4 downto 0);
		cdb_tag_out : out std_logic_vector(4 downto 0);
		cdb_request : out std_logic;
		cdb_grant_reject: in std_logic
	);
end FU_2;

architecture Behavioral of FU_2 is
	
	type state is (init,RSTs,c1,c2);
	signal Vj_sig,Vk_sig,cdb_data_out_sig : std_logic_vector(31 downto 0);
	signal OP_sig : std_logic_vector(1 downto 0);
	signal name_tag : std_logic_vector(4 downto 0);
	signal count : std_logic_vector(1 downto 0);
	signal fu_busy_sig :std_logic;
begin
	
	process--(ex,rst,count,cdb_grant_reject)						
	begin
		wait until clk'event and clk ='1';
		if(rst='1')then
			cdb_data_out_sig<="00000000000000000000000000000000";
			Vj_sig <= "00000000000000000000000000000000";
			Vk_sig <= "00000000000000000000000000000000";
			cdb_data_out_sig<="00000000000000000000000000000000";
			OP_sig <= "00";
			name_tag <="00000";
			cdb_request <='0';
			count <= "00";
		else
			if(count ="00") then
				if(ex = '1') then
					count <= count +1;
					Vj_sig <= Vj;
					Vk_sig <= Vk;
					op_sig <= op;
					name_tag <= cdb_tag;
				end if;			
			elsif(count="01") then
				if(OP = "00") then
					cdb_data_out_sig <= not(Vj_sig); 
				elsif(OP = "01") then
					cdb_data_out_sig <= Vj_sig and Vk_sig;
				elsif(OP = "10") then
					cdb_data_out_sig <= Vj_sig or Vk_sig;
				end if;
				cdb_request <='1';
				count<=count+1;
			elsif(count ="10") then
				if(cdb_grant_reject ='1') then
					cdb_request <='0';
					count <= "00";
				end if;
			end if;	
		end if;
	end process;

	cdb_tag_out <= name_tag;
	cdb_data_out <= cdb_data_out_sig;
	FU_busy_sig <= 	'1' when ex='1' else
							'0' when rst='1' else
							'0' when cdb_grant_reject='1' else
							Fu_busy_sig;
	Fu_busy <=	Fu_busy_sig;
end Behavioral;

