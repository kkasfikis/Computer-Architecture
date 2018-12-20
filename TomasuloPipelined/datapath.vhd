
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
	port(
		clk : in std_logic;
		rst : in std_logic;
		issue : in std_logic;
		FU_type : in std_logic_vector(1 downto 0);
		F_OP : in std_logic_vector(1 downto 0);
		Rs : in std_logic_vector(4 downto 0);
		Rt : in std_logic_vector(4 downto 0);
		Rd : in std_logic_vector (4 downto 0);
		accepted : out std_logic	
	);
end datapath;

architecture Behavioral of datapath is

	component FU_RS_TopLevel is
		port( 
			 RST    : in  std_logic;
			 CLK    : in  std_logic;  
			 FU 	  : in  std_logic_vector(1 downto 0);
			 CDB_Q  : in  std_logic_vector(4 downto 0);
		    CDB_V  : in  std_logic_vector(31 downto 0);		
			 Op_in  : in  std_logic_vector(1 downto 0);
			 Qj_in  : in  std_logic_vector(4 downto 0);
			 Vj_in  : in  std_logic_vector(31 downto 0);
			 Qk_in  : in  std_logic_vector(4 downto 0);
			 Vk_in  : in  std_logic_vector(31 downto 0);
			 cdb_grant_request1 : in std_logic;
			 cdb_grant_request2 : in std_logic;
			 busy_rs1 : out std_logic_vector(2 downto 0);
			 busy_rs2 : out std_logic_vector(1 downto 0);
			 cdb_request1 : out std_logic;
			 cdb_request2 : out std_logic;
			 cdb_data_out1 : out std_logic_vector(31 downto 0);
 			 cdb_data_out2 : out std_logic_vector(31 downto 0);
			 cdb_tag_out1 : out std_logic_vector(4 downto 0);
			 cdb_tag_out2 : out std_logic_vector(4 downto 0)
		);
	end component;
	component Issuer is
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
	end component;
	component CDB is
	port(
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
	end component;
	component RegisterFile
   port(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Qout1 : OUT  std_logic_vector(4 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Qout2 : OUT  std_logic_vector(4 downto 0);
         Qin : IN  std_logic_vector(4 downto 0);
         Clk : IN  std_logic;
         arst : IN  std_logic;
         WrEn : IN  std_logic;
         CDB_Q : IN  std_logic_vector(4 downto 0);
         CDB_DATA : IN  std_logic_vector(31 downto 0)
    );	
    end component;

signal rs_out_sig,rt_out_sig,rd_out_sig,tag_out_sig,Qk_out_sig,Qj_out_sig,cdb_tagout1_sig,cdb_tagout2_sig,cdb_qout_sig : std_logic_vector(4 downto 0);  
signal fu_out_sig,fu_op_out_sig,busy_rs2_sig : std_logic_vector(1 downto 0);
signal Dout1_sig,Dout2_sig,cdb_data_out1_sig,cdb_data_out2_sig,cdb_vout_sig : std_logic_vector(31 downto 0);
signal cdb_grant_request1_sig,cdb_grant_request2_sig,cdb_request1_sig,cdb_request2_sig,accepted_sig,cdb_valid_sig,fu3_grantreject_sig : std_logic;
signal busy_rs1_sig :std_logic_vector(2 downto 0);

  
begin
	
	FU_RS_Unit : FU_RS_toplevel
	port map( 
		RST =>rst,
		CLK =>clk,  
		FU  =>fu_out_sig,
		CDB_Q =>cdb_qout_sig,
		CDB_V =>cdb_vout_sig,		
		Op_in =>fu_op_out_sig,
		Qj_in =>Qj_out_sig,
		Vj_in =>Dout1_sig,
		Qk_in =>Qk_out_sig,
		Vk_in =>Dout2_sig,
		busy_rs1 =>busy_rs1_sig,
		busy_rs2 =>busy_rs2_sig,
		cdb_grant_request1 =>cdb_grant_request1_sig,
		cdb_grant_request2 =>cdb_grant_request2_sig,
		cdb_request1 =>cdb_request1_sig,
		cdb_request2 =>cdb_request2_sig,
		cdb_data_out1 =>cdb_data_out1_sig,
		cdb_data_out2 =>cdb_data_out2_sig,
		cdb_tag_out1 =>cdb_tagout1_sig,
		cdb_tag_out2 =>cdb_tagout2_sig
	);
	RegFile:RegisterFile
	port map(
		Ard1=>rs_out_sig,
		Ard2=>rt_out_sig,
		Awr=>rd_out_sig,
		Dout1=>Dout1_sig,
		Qout1=>Qj_out_sig,
		Dout2=>Dout2_sig,
		Qout2=>Qk_out_sig,
		Qin=>tag_out_sig,
		Clk=>clk,
		arst=>rst,
		WrEn=>accepted_sig,
		CDB_Q=>cdb_qout_sig,
		CDB_DATA=>cdb_vout_sig
   );
	
	IssuerUnit : Issuer
	port map(
		Clk=>clk,
		RST=>rst,
		Issue=>issue,
		FU_type=>fu_type,
		busy_rs1=>busy_rs1_sig,
		busy_rs2=>busy_rs2_sig,
		F_OP=>f_op,
		Rs=>rs,
		Rt=>rt,
		Rd=>rd,
		FU_out=>fu_out_sig,
		F_OP_out=>fu_op_out_sig,
		Rs_out=>rs_out_sig,
		Rt_out=>rt_out_sig,
		Rd_out =>rd_out_sig,
		tag =>tag_out_sig,
		Accepted=>accepted_sig
	);
	 CDBUnit :CDB
	 port map(
		clk =>clk,
		rst =>rst,
		FU_1_tag =>cdb_tagout1_sig,
		FU_1_data =>cdb_data_out1_sig,
		FU_1_request =>cdb_request1_sig,
		FU_1_grant_reject =>cdb_grant_request1_sig,
		FU_2_tag =>cdb_tagout2_sig,
		FU_2_data =>cdb_data_out2_sig,
		FU_2_request =>cdb_request2_sig,
		FU_2_grant_reject =>cdb_grant_request2_sig,
		FU_3_tag => "10111",
		FU_3_data => "00000000000000000000000000000000",
		FU_3_request => '0',
		FU_3_grant_reject => fu3_grantreject_sig,
		CDB_Q =>cdb_qout_sig,
		CDB_data =>cdb_vout_sig,
		CDB_valid =>cdb_valid_sig
	);
	accepted <= accepted_sig;
end Behavioral;

