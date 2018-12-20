
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FU_RS_TopLevel is
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
			 
end FU_RS_TopLevel;

architecture Behavioral of FU_RS_TopLevel is
	
	component ReservationStation1 is
		port(
			 RST    : in  std_logic;
			 CLK    : in  std_logic;
			 ex 	  : in std_logic;
			 WE     : in  std_logic_vector(2 downto 0); 
			 Rg_Sel : in  std_logic_vector(1 downto 0); 
			 CDB_Q  : in  std_logic_vector(4 downto 0);
		    CDB_V  : in  std_logic_vector(31 downto 0);		
			 Op_in  : in  std_logic_vector(1 downto 0);
			 Qj_in  : in  std_logic_vector(4 downto 0);
			 Vj_in  : in  std_logic_vector(31 downto 0);
			 Qk_in  : in  std_logic_vector(4 downto 0);
			 Vk_in  : in  std_logic_vector(31 downto 0);
			 Op_out : out std_logic_vector(1 downto 0);
			 Vj_out : out std_logic_vector(31 downto 0);
			 Vk_out : out std_logic_vector(31 downto 0);
			 tag_out: out std_logic_vector(4 downto 0);
			 ready  : out std_logic_vector(2 downto 0);
			 busy   : out std_logic_vector(2 downto 0)
			 );
	end component;

	component ReservationStation2 is
		port(
			 RST    : in  std_logic;
			 CLK    : in  std_logic;
			 ex 	  : in std_logic;
			 WE     : in  std_logic_vector(1 downto 0); 
			 Rg_Sel : in  std_logic_vector(1 downto 0); 
			 CDB_Q  : in  std_logic_vector(4 downto 0);
		    CDB_V  : in  std_logic_vector(31 downto 0);	
			 Op_in  : in  std_logic_vector(1 downto 0);
			 Qj_in  : in  std_logic_vector(4 downto 0);
			 Vj_in  : in  std_logic_vector(31 downto 0);
			 Qk_in  : in  std_logic_vector(4 downto 0);
			 Vk_in  : in  std_logic_vector(31 downto 0);
			 Op_out : out std_logic_vector(1 downto 0);
			 Vj_out : out std_logic_vector(31 downto 0);
			 Vk_out : out std_logic_vector(31 downto 0);
			 tag_out: out std_logic_vector(4 downto 0);
			 ready     : out std_logic_vector(1 downto 0);
			 busy     : out std_logic_vector(1 downto 0)
			 );
	end component;

	component RS_ARBITER_A is
	Port ( 
		RST    : in  std_logic;
		CLK    : in  std_logic;	
		Fu_Busy : in std_logic;
		FU     : in  std_logic_vector(1 downto 0);
		Busy     : in  std_logic_vector(2 downto 0);
		Ready 	: in std_logic_vector(2 downto 0);
		rg_sel : out std_logic_vector(1 downto 0);
		ex 	: out std_logic;
		WE     : out std_logic_vector(2 downto 0)
	);
	end component;

	component RS_ARBITER_L is
	Port ( 
		RST    : in  std_logic;
		CLK    : in  std_logic;	
		Fu_Busy : in std_logic;
		FU     : in  std_logic_vector(1 downto 0);
		Busy     : in  std_logic_vector(1 downto 0);
		Ready 	: in std_logic_vector(1 downto 0);
		WE     : out std_logic_vector(1 downto 0);
		ex : out std_logic;
		rg_sel : out std_logic_vector(1 downto 0)
	);
	end component;

	component FU_1 is
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
	end component;
	
	component FU_2 is
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
	end component;
	
	signal rs1_we : std_logic_vector(2 downto 0);
	signal rs2_we : std_logic_vector(1 downto 0);
	signal rs1_rg,rs2_rg : std_logic_vector(1 downto 0);
	signal rs1_ready_sig,rs1_busy_sig : std_logic_vector(2 downto 0);
	signal rs2_ready_sig,rs2_busy_sig : std_logic_vector(1 downto 0);
	signal rs1_Op_sig,rs2_Op_sig : std_logic_vector(1 downto 0);
	signal rs1_Vj_out_sig,rs1_Vk_out_sig,rs2_Vj_out_sig,rs2_Vk_out_sig : std_logic_vector(31 downto 0);
	signal rs1_tag_out_sig,rs2_tag_out_sig : std_logic_vector(4 downto 0);
	signal cdb_tag_out1_sig,cdb_tag_out2_sig : std_logic_vector(4 downto 0);
	signal cdb_data_out1_sig,cdb_data_out2_sig : std_logic_vector(31 downto 0);
	signal fu1_busy,fu2_busy,ex1_sig,ex2_sig,cdb_request1_sig,cdb_request2_sig : std_logic;
	
	
begin

	RS1 : ReservationStation1 
	port map(
		RST => rst,
		CLK => clk,
		ex => ex1_sig,
		WE => rs1_we,
		Rg_Sel => rs1_rg,
		CDB_Q => CDB_Q,
		CDB_V => CDB_V,	
		Op_in => Op_in,
		Qj_in => Qj_in,
		Vj_in => Vj_in,
		Qk_in => Qk_in,
		Vk_in => Vk_in,
		Op_out => rs1_Op_sig ,
		Vj_out => rs1_Vj_out_sig,
		Vk_out => rs1_Vk_out_sig,
		tag_out => rs1_tag_out_sig ,
		ready => rs1_ready_sig,
		busy  => rs1_busy_sig
	);
	
	RS1_ARB : RS_ARBITER_A 
	port map(
		RST => rst,
		CLK => clk,
		Fu_Busy => fu1_busy ,
		FU     => FU,
		Busy   => rs1_busy_sig ,
		Ready => rs1_ready_sig,
		rg_sel => rs1_rg,
		ex => ex1_sig,
		WE => rs1_we
	);
	
	FU1 : FU_1
	port map(
		Clk => clk,
		RST => rst,
		OP=> rs1_Op_sig,
		EX => ex1_sig ,
		Vj => rs1_Vj_out_sig,
		Vk => rs1_Vk_out_sig,
		cdb_data_out => cdb_data_out1_sig ,
	   fu_busy => fu1_busy,
		cdb_tag => rs1_tag_out_sig,
		cdb_tag_out => cdb_tag_out1_sig,
		cdb_request => cdb_request1_sig,
		cdb_grant_reject=> cdb_grant_request1 
	);
	
	RS2 : ReservationStation2
	port map(
		RST => rst,
		CLK => clk,
		ex => ex2_sig,
		WE => rs2_we,
		Rg_Sel => rs2_rg,
		CDB_Q => CDB_Q,
		CDB_V => CDB_V,	
		Op_in => Op_in,
		Qj_in => Qj_in,
		Vj_in => Vj_in,
		Qk_in => Qk_in,
		Vk_in => Vk_in,
		Op_out => rs2_Op_sig,
		Vj_out => rs2_Vj_out_sig,
		Vk_out => rs2_Vk_out_sig,
		tag_out=> rs2_tag_out_sig,
		ready => rs2_ready_sig,
		busy  => rs2_busy_sig
	);
	
	RS2_ARB : RS_ARBITER_L
	port map(
		RST => rst,
		CLK => clk,
		FU => FU,
		fu_busy => fu2_busy,
		busy => rs2_busy_sig ,
		ready => rs2_ready_sig,
		rg_sel => rs2_rg,
		ex => ex2_sig ,
		WE  => rs2_we
	);
	
	FU2 : FU_2
	port map(
		Clk => clk,
		RST => rst,
		OP=> rs2_Op_sig,
		EX => ex2_sig,
		Vj => rs2_Vj_out_sig,
		Vk => rs2_Vk_out_sig,
		cdb_data_out => cdb_data_out2_sig,
	   fu_busy => fu2_busy,
		cdb_tag => rs2_tag_out_sig,
		cdb_tag_out => cdb_tag_out2_sig,
		cdb_request => cdb_request2_sig ,
		cdb_grant_reject=> cdb_grant_request2
	);
	
	cdb_data_out1 <= cdb_data_out1_sig;
	cdb_data_out2 <= cdb_data_out2_sig;
	cdb_tag_out1 <= cdb_tag_out1_sig;
	cdb_tag_out2 <= cdb_tag_out2_sig;
	cdb_request1 <= cdb_request1_sig;
	cdb_request2 <= cdb_request2_sig;
	busy_rs1 <= rs1_busy_sig;
	busy_rs2 <= rs2_busy_sig;
end Behavioral;

