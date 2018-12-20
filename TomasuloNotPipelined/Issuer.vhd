
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Issuer is
	port(
		Clk : in std_logic;
		RST : in std_logic;
		Issue : in std_logic;
		FU_type : in std_logic_vector(1 downto 0);
		busy_rs1 : in std_logic_vector(2 downto 0);
		busy_rs2 : in std_logic_vector(1 downto 0);
		F_OP : in std_logic_vector(1 downto 0);
		Rs : in std_logic_vector(4 downto 0);
		Rt : in std_logic_vector(4 downto 0);
		Rd : in std_logic_vector (4 downto 0);
		FU_out : out std_logic_vector(1 downto 0);
		F_OP_out : out std_logic_vector(1 downto 0);
		Rs_out : out std_logic_vector(4 downto 0);
		Rt_out : out std_logic_vector(4 downto 0);
		Rd_out : out std_logic_vector(4 downto 0);
		tag : out std_logic_vector(4 downto 0);
		Accepted :out std_logic
	);
end Issuer;

architecture Behavioral of Issuer is
--type state is (init,rst_state,RSfull,notIssued);
--signal currentState, nextState: state;

signal rf_tag : std_logic_vector(2 downto 0);
signal fu_tag,fu_out_sig : std_logic_vector(1 downto 0);
signal rf_tag2 : std_logic_vector(1 downto 0);
signal tag1,tag2 : std_logic_vector(4 downto 0);

begin


process(RST,Issue,fu_type,busy_rs1,busy_rs2)
begin
	if (rst = '1') then
		Fu_out_sig <= "11";
		Rs_out <= "00000";
		Rt_out <= "00000";
		Rd_out <= "00000";
		
		F_op_out <= "11";
		Accepted <= '0';
	else
		if (Issue= '1') then
				if(FU_type = "01") then --ARITHMETIC
					if(busy_rs1 = "111") then
						Accepted <= '0';
						FU_out_sig <= "11";
					elsif(busy_rs1(0) = '0') then
						Accepted <= '1';
						FU_out_sig <= "01";
					elsif(busy_rs1(1) = '0') then
						Accepted <= '1';
						FU_out_sig <= "01";
					elsif(busy_rs1(2) = '0') then
						Accepted <= '1';
						FU_out_sig <= "01";
					end if;
				elsif(FU_type = "00") then --LOGICAL
					if(busy_rs2 = "11") then
						Accepted <= '0';
						FU_out_sig <= "11";
					else
						Accepted <= '1';
						FU_out_sig <= "00";
					end if;	
				end if;
		else
			FU_out_sig <= "11";
			accepted <= '0';
		end if;
		--Fu_out <= "11";
		Rs_out <= rs;
		Rt_out <= Rt;
		Rd_out <= Rd;
		F_op_out <= F_op;
		
	end if;
end process;

process (busy_rs1,busy_rs2)
	begin
	if(busy_rs1 ="000")then
		rf_tag<="001";
	elsif(busy_rs1 ="001")then
		rf_tag<="010";
	elsif(busy_rs1 ="010")then
		rf_tag<="001";
	elsif(busy_rs1 ="011")then
		rf_tag<="100";
	elsif(busy_rs1 ="100")then
		rf_tag<="001";
	elsif(busy_rs1 ="101")then
		rf_tag<="010";
	elsif(busy_rs1 ="110")then
		rf_tag<="001";
	else
		rf_tag<="000";
	end if;
	
	if(busy_rs2 ="00")then
		rf_tag2<="01";
	elsif(busy_rs2 ="01")then
		rf_tag2<="10";
	elsif(busy_rs2 ="10")then
		rf_tag2<="01";
	else
		rf_tag2<="00";
	end if;
end process;
	
	rf_tag <= 	"001" when busy_rs1 ="000" else
					"010" when busy_rs1 ="001" else
					"001" when busy_rs1 ="010" else
					"100" when busy_rs1 ="011" else
					"001" when busy_rs1 ="100" else
					"010" when busy_rs1 ="101" else
					"001" when busy_rs1 ="110" else
					"000";
	fu_out <= fu_out_sig;
	
--	rf_tag2 <= 	"01" when busy_rs2 ="00" else
--					"10" when busy_rs2 ="01" else
--					"01" when busy_rs2 ="10" else
--					"00";				
	fu_tag <= 	"11" when issue='0' else
					Fu_out_sig;
					
	tag1 <= fu_tag & rf_tag;
	tag2 <= fu_tag & "0" & rf_tag2;
	tag  <= tag1 when fu_out_sig="01" else
			  tag2 when fu_out_sig="00" else
			  "11111";
	
end Behavioral;

