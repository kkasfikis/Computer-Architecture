
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
		Accepted :out std_logic;
		rb_full : in std_logic
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
	component ReorderBuffer is
	port(
		clk : in std_logic;
		rst : in std_logic;	
		accepted : in std_logic;
		cdb_q : in std_logic_vector(4 downto 0);
		cdb_data : in std_logic_vector(31 downto 0);		
		issue : in std_logic;
		tag_in : in std_logic_vector(4 downto 0);
		rd : in std_logic_vector(4 downto 0);		
		awr : out std_logic_vector(4 downto 0);
		data_out : out std_logic_vector(31 downto 0);
		commit : out std_logic;
		read1_addr : in std_logic_vector(4 downto 0);
		read1_data : in std_logic_vector(31 downto 0);
		read2_addr : in std_logic_vector(4 downto 0);
		read2_data : in std_logic_vector(31 downto 0);		
		rb_full : out std_logic;
		read1_data_out : out std_logic_vector(31 downto 0);
		read1_q_out : out std_logic_vector(4 downto 0);
		read2_data_out : out std_logic_vector(31 downto 0);
		read2_q_out : out std_logic_vector(4 downto 0)
	);
	end component;
	component rb_RegFIle is
		port(
			Ard1 :in std_logic_vector(4 downto 0);
			Ard2 :in std_logic_vector(4 downto 0);
			Awr :in std_logic_vector(4 downto 0);
			Dout1 :out std_logic_vector(31 downto 0);
			Dout2 :out std_logic_vector(31 downto 0);
			data_in : in std_logic_vector(31 downto 0);
			Clk :in std_logic;
			arst : in std_logic;
			WrEn :in std_logic
		);
	end component;

signal rs_out_sig,rt_out_sig,rd_out_sig,tag_out_sig,Qk_out_sig,Qj_out_sig,cdb_tagout1_sig,cdb_tagout2_sig,cdb_qout_sig : std_logic_vector(4 downto 0);  
signal fu_out_sig,fu_op_out_sig,busy_rs2_sig : std_logic_vector(1 downto 0);
signal Dout1_sig,Dout2_sig,cdb_data_out1_sig,cdb_data_out2_sig,cdb_vout_sig : std_logic_vector(31 downto 0);
signal cdb_grant_request1_sig,cdb_grant_request2_sig,cdb_request1_sig,cdb_request2_sig,accepted_sig,cdb_valid_sig,fu3_grantreject_sig : std_logic;
signal busy_rs1_sig :std_logic_vector(2 downto 0);
signal rb_full_sig,commit_sig : std_logic;
signal awr_sig : std_logic_vector(4 downto 0);
signal regfile_out1,regfile_out2,rb_out : std_logic_vector(31 downto 0);
  
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
	ReorderBuff : ReorderBuffer
	port map(
		clk =>clk,
		rst =>rst,		
		cdb_q =>cdb_qout_sig,
		accepted => accepted_sig,
		cdb_data =>cdb_vout_sig,
		issue =>issue,
		tag_in =>tag_out_sig,
		rd =>rd,	
		awr =>awr_sig,
		data_out=>rb_out,
		commit =>commit_sig,
		read1_addr =>rs_out_sig,
		read1_data =>regfile_out1,
		read2_addr =>rt_out_sig,
		read2_data=>regfile_out2,		
		rb_full =>rb_full_sig,
		read1_data_out =>Dout1_sig,
		read1_q_out =>Qj_out_sig,
		read2_data_out =>Dout2_sig,
		read2_q_out =>Qk_out_sig
	);
	RegisterFile : rb_RegFile
	port map(
		Ard1 =>rs_out_sig,
		Ard2 =>rt_out_sig,
		Awr =>awr_sig,
		Dout1 =>regfile_out1,
		Dout2 =>regfile_out2,
		data_in =>rb_out,
		Clk =>clk,
		arst =>rst,
		WrEn =>commit_sig
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
		Accepted=>accepted_sig,
		rb_full => rb_full_sig
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

