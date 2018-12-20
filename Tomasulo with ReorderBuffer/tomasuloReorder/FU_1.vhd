
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity FU_1 is
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
end FU_1;

architecture Behavioral of FU_1 is
component Register38bit is
	port( 
			Data : in std_logic_vector(37 downto 0);
	      Clk : in std_logic;
			Data_WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(37 downto 0)
	);
end component;

	signal Vj_sig,Vk_sig,cdb_data_out_sig : std_logic_vector(31 downto 0);
	signal OP_sig : std_logic_vector(1 downto 0);
	signal name_tag : std_logic_vector(4 downto 0);
	signal count : std_logic_vector(1 downto 0);
	signal fu_busy_sig,c1,c2,c3,c4,request_sig :std_logic;
	signal result,add_result,sub_result:std_logic_vector(31 downto 0);
	signal data1,data2,data3,data4 : std_logic_vector(37 downto 0);
	signal t1,t2,t3,t4 :std_logic;
begin
	reg1: register38bit
	port map(
		Data => data1,
		clk => clk,
		Data_we =>ex,
		arst => t1,
		Dout => data2
	);

	reg2: register38bit
	port map(
		Data => data2,
		clk => clk,
		Data_we => t2,
		arst => t4,
		Dout => data3
	);
	
	reg3: register38bit
	port map(
		Data => data3,
		clk => clk,
		Data_we => t3,
		arst => rst,
		Dout => data4
	);
	process(data4,data3,cdb_grant_reject,rst)
	begin
		if(rst='1')then
			fu_busy_sig<='0';
			cdb_request<='0';
		else
			if(data4(37)='1')then
				cdb_request <='1';
			end if;
			if(cdb_grant_reject='1' and data4(37)='0')then
				cdb_request<='0';
			end if;
			if(cdb_grant_reject='1')then
				fu_busy_sig<='0';
			else
				if(cdb_grant_reject='0' and data4(37)='1')then
					fu_busy_sig<='1';
				end if;
			end if;
		end if;
	end process;
	add_result <= vj + vk;
	sub_result <= vj - vk;
	
	t1 <= (not(ex) or rst);
	t4 <= not(data2(37)) or rst;
	t2 <= (data2(37) or cdb_grant_reject);
	t3 <= (data3(37) or cdb_grant_reject);
	c1 <= not(op(0)) and not(op(1)) and ex;
	c2 <= op(0) and not(op(1)) and ex;
	c3 <= c1 or c2;
	
	result <= add_result when c1='1' else
				 sub_result when c2='1' else
				 "00000000000000000000000000000000" when rst = '1' else
				 "00000000000000000000000000000000";
	
	name_tag <= cdb_tag when c3='1' else
					"00000" when rst='1' else
					"00000";
	
	request_sig <= '1' when c3='1' else
						'0' when rst='1' else
						'0';
	
	data1<= "00000000000000000000000000000000000000" when rst='1' else
				request_sig & name_tag & result;
				
	Fu_busy <=	Fu_busy_sig;
	cdb_data_out <= data4(31 downto 0);
	cdb_tag_out <= data4(36 downto 32);
	
end Behavioral;

