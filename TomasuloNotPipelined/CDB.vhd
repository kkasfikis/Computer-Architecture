
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CDB is
	PORT(
		clk : in std_logic;
		rst : in std_logic;
		FU_1_tag : in std_logic_vector(4 downto 0);
		FU_1_data : in std_logic_vector(31 downto 0);
		FU_1_request : in std_logic;
		FU_1_grant_reject : out std_logic;
		
		FU_2_tag : in std_logic_vector(4 downto 0);
		FU_2_data : in std_logic_vector(31 downto 0);
		FU_2_request : in std_logic;
		FU_2_grant_reject : out std_logic;
		
		FU_3_tag : in std_logic_vector(4 downto 0);
		FU_3_data : in std_logic_vector(31 downto 0);
		FU_3_request : in std_logic;
		FU_3_grant_reject : out std_logic;
		
		CDB_Q : out std_logic_vector(4 downto 0);
		CDB_data : out std_logic_vector(31 downto 0);
		CDB_valid : out std_logic
	);
end CDB;


architecture Behavioral of CDB is
component register37bit_cdb is
	port( 
		Data : in std_logic_vector(31 downto 0);
		Q : in std_logic_vector(4 downto 0);
	   Clk : in std_logic;
		WE : in std_logic;
		arst : in std_logic;
		Dout : out std_logic_vector(31 downto 0);
		Qout : out std_logic_vector(4 downto 0)
	);
end component;

signal we_sig : std_logic;
signal q_in_sig, q_out_sig : std_logic_vector(4 downto 0);
signal data_in_sig : std_logic_vector(31 downto 0);
signal reg_out_sig : std_logic_vector(31 downto 0);
signal s0,s1,s2,rst_sig : std_logic;
signal check_sig : std_logic_vector(36 downto 0);
signal fu_1_grant_reject_sig, fu_2_grant_reject_sig, fu_3_grant_reject_sig : std_logic;
begin

cdbReg:Register37bit_cdb
 port map (
	Data => data_in_sig,
	Q => q_in_sig,
	Clk => clk,
	WE => we_sig,
	arst => rst_sig, 
	Dout => reg_out_sig,
	Qout => q_out_sig
);	
						
process(rst,fu_1_request,fu_2_request,fu_3_request,fu_2_data,fu_2_tag,fu_1_data,fu_1_tag)
	BEGIN
	--wait until clk'event and clk ='1';
	IF (rst ='1') then
		data_in_sig <= "11000000000000000000000000000000";
		we_sig <= '0';
		rst_sig<='1';
		q_in_sig <= "11000";
		fu_1_grant_reject_sig <= '0';
		fu_2_grant_reject_sig <= '0';
		fu_3_grant_reject_sig <= '0';
	else
		
		if(FU_1_request ='1' or FU_2_request ='1' or FU_3_request ='1') then
			if(FU_1_request ='1') then
				rst_sig<='0';
				data_in_sig <= fu_1_data;
				we_sig <= '1';
				q_in_sig <= fu_1_tag;
				fu_1_grant_reject_sig <= '1';
				fu_2_grant_reject_sig <= '0';
				fu_3_grant_reject_sig <= '0';
			else
				if(FU_2_request ='1')  then
					rst_sig<='0';
					data_in_sig <= fu_2_data;
					we_sig <= '1';
					q_in_sig <= fu_2_tag;
					fu_1_grant_reject_sig <= '0';
					fu_2_grant_reject_sig <= '1';
					fu_3_grant_reject_sig <= '0';
				else
					if(FU_3_request ='1') then
						rst_sig<='0';
						data_in_sig <= fu_3_data;
						we_sig <= '1';
						q_in_sig <= fu_3_tag;
						fu_1_grant_reject_sig <= '0';
						fu_2_grant_reject_sig <= '0';
						fu_3_grant_reject_sig <= '1';
					else
						data_in_sig <= "11000000000000000000000000000000";
						we_sig <= '0';
						q_in_sig <= "11000";
						rst_sig<='1';
						fu_1_grant_reject_sig <= '0';
						fu_2_grant_reject_sig <= '0';
						fu_3_grant_reject_sig <= '0';
						we_sig <= '0';
					end if;
				end if;
			end if;	
		else
			data_in_sig <= "11000000000000000000000000000000";
			rst_sig<='1';
			q_in_sig <= "11000";
			fu_1_grant_reject_sig <= '0';
			fu_2_grant_reject_sig <= '0';
			fu_3_grant_reject_sig <= '0';
			we_sig <= '0';	
		end if;
	end if;
	end process;
	
	process
	begin
		wait until clk'event and clk ='1';
		if(rst ='1') then
			cdb_valid <= '0';
			check_sig <= "1111100000000000000000000000000000000";
		else
			if(reg_out_sig /= check_sig(31 downto 0) or q_out_sig /= check_sig(36 downto 32)) then
				check_sig(31 downto 0) <= reg_out_sig;
				check_sig(36 downto 32) <= q_out_sig;
				cdb_valid <= '1';
			else
				cdb_valid <= '0';
			end if;
		end if;
	end process;
	
	CDB_Q <= q_out_sig;
	CDB_data <= reg_out_sig;
	fu_1_grant_reject <= fu_1_grant_reject_sig;
	fu_2_grant_reject <= fu_2_grant_reject_sig;
	fu_3_grant_reject <= fu_3_grant_reject_sig;

end Behavioral;

