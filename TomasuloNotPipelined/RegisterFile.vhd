library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
       port( Ard1 :in std_logic_vector(4 downto 0);
		       Ard2 :in std_logic_vector(4 downto 0);
				 Awr :in std_logic_vector(4 downto 0);
				 Dout1 :out std_logic_vector(31 downto 0);
				 Qout1 : out std_logic_vector(4 downto 0);
				 Dout2 :out std_logic_vector(31 downto 0);
				 Qout2 : out std_logic_vector(4 downto 0);
				 Qin :in std_logic_vector(4 downto 0);
				 Clk :in std_logic;
				 arst : in std_logic;
				 WrEn :in std_logic;
				 CDB_Q : in std_logic_vector(4 downto 0);
				 CDB_DATA: in std_logic_vector(31 downto 0)
				 );
end RegisterFile;

architecture Behavioral of RegisterFile is

	component Decoder5to32 is
		 port(  input : in std_logic_vector(4 downto 0);
				  output : out std_logic_vector(31 downto 0));
	end component;
	
	component Mux32to5 is 
	     port(  R0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
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
	end component;
	
	component Mux32to5_5bit is 
	  port( 
			Q0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
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
	end component;
	
	component Mux2to1 is
	port( 
		D0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		D1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Mux_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Selector : IN STD_LOGIC
	);
	end component;
	
	component Mux2to1_5bit is
	port( 
		Q0 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Q1 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Mux_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		Selector : IN STD_LOGIC
	);
	end component;
	
	component Comparator5bit is
		port( 
		  input1 : in std_logic_vector(4 downto 0);
		  input2 : in std_logic_vector(4 downto 0);
		  rst : in std_logic;
		  output : out std_logic
		);
	end component;
	
	component Register37bit is 
		port( 
			Data : in std_logic_vector(31 downto 0);
			Q : in std_logic_vector(4 downto 0);
	      Clk : in std_logic;
			Data_WE : in std_logic;
			Q_WE : in std_logic;
			arst : in std_logic;
			Dout : out std_logic_vector(31 downto 0);
			Qout : out std_logic_vector(4 downto 0)
		);
	end component;

	signal  decoder_Output : std_logic_vector(31 downto 0);
	
	signal data_WE, Q_WE : std_logic_vector(31 downto 0);
	
	signal r0_data,r1_data,r2_data,r3_data,r4_data,r5_data,r6_data,r7_data,r8_data,r9_data,r10_data,r11_data,r12_data,r13_data,r14_data,r15_data,r16_data,r17_data,r18_data,r19_data,r20_data,r21_data,
			 r22_data,r23_data,r24_data,r25_data,r26_data,r27_data,r28_data,r29_data,r30_data,r31_data : std_logic_vector(31 downto 0);
	
	signal r0_Q,r1_Q,r2_Q,r3_Q,r4_Q,r5_Q,r6_Q,r7_Q,r8_Q,r9_Q,r10_Q,r11_Q,r12_Q,r13_Q,r14_Q,r15_Q,r16_Q,r17_Q,r18_Q,r19_Q,r20_Q,r21_Q,
			 r22_Q,r23_Q,r24_Q,r25_Q,r26_Q,r27_Q,r28_Q,r29_Q,r30_Q,r31_Q : std_logic_vector(4 downto 0);		 
	
	signal read1_t,read2_t : std_logic_vector(31 downto 0);
	signal q1_t,q2_t :std_logic_vector(4 downto 0 );
	signal check1,check2 : std_logic;

begin
	
	Q_WE(0) <= decoder_Output(0) and WrEn; 
	Q_WE(1) <= decoder_Output(1) and WrEn; 
	Q_WE(2) <= decoder_Output(2) and WrEn; 
	Q_WE(3) <= decoder_Output(3) and WrEn; 
	Q_WE(4) <= decoder_Output(4) and WrEn;
	Q_WE(5) <= decoder_Output(5) and WrEn; 
	Q_WE(6) <= decoder_Output(6) and WrEn; 
	Q_WE(7) <= decoder_Output(7) and WrEn; 
	Q_WE(8) <= decoder_Output(8) and WrEn; 
	Q_WE(9) <= decoder_Output(9) and WrEn;
	Q_WE(10) <= decoder_Output(10) and WrEn; 
	Q_WE(11) <= decoder_Output(11) and WrEn; 
	Q_WE(12) <= decoder_Output(12) and WrEn; 
	Q_WE(13) <= decoder_Output(13) and WrEn; 
	Q_WE(14) <= decoder_Output(14) and WrEn;
	Q_WE(15) <= decoder_Output(15) and WrEn; 
	Q_WE(16) <= decoder_Output(16) and WrEn; 
	Q_WE(17) <= decoder_Output(17) and WrEn; 
	Q_WE(18) <= decoder_Output(18) and WrEn; 
	Q_WE(19) <= decoder_Output(19) and WrEn;
	Q_WE(20) <= decoder_Output(20) and WrEn; 
	Q_WE(21) <= decoder_Output(21) and WrEn; 
	Q_WE(22) <= decoder_Output(22) and WrEn; 
	Q_WE(23) <= decoder_Output(23) and WrEn; 
	Q_WE(24) <= decoder_Output(24) and WrEn;
	Q_WE(25) <= decoder_Output(25) and WrEn; 
	Q_WE(26) <= decoder_Output(26) and WrEn; 
	Q_WE(27) <= decoder_Output(27) and WrEn; 
	Q_WE(28) <= decoder_Output(28) and WrEn; 
	Q_WE(29) <= decoder_Output(29) and WrEn;
	Q_WE(30) <= decoder_Output(30) and WrEn; 
	Q_WE(31) <= decoder_Output(31) and WrEn; 
	

	Read1 : Mux32to5 
	port map( 
		R0 =>r0_data,
		R1 =>r1_data,
		R2 =>r2_data,
		R3 =>r3_data,
		R4 =>r4_data,
		R5 =>r5_data,
		R6 =>r6_data,
		R7 =>r7_data,
		R8 =>r8_data,
		R9 =>r9_data,
		R10 =>r10_data,
		R11 =>r11_data,
		R12 =>r12_data,
		R13 =>r13_data,
		R14 =>r14_data,
		R15 =>r15_data,
		R16 =>r16_data,
		R17 =>r17_data,
		R18 =>r18_data,
		R19 =>r19_data,
		R20 =>r20_data,
		R21 =>r21_data,
		R22 =>r22_data,
		R23 =>r23_data,
		R24 =>r24_data,
		R25 =>r25_data,
		R26 =>r26_data,
		R27 =>r27_data,
		R28 =>r28_data,
		R29 =>r29_data,
		R30 =>r30_data,
		R31 =>r31_data,
		Mux_out =>read1_t,
		Selector =>Ard1
	);

	Read2 : Mux32to5 
	port map( 
		R0 =>r0_data,
		R1 =>r1_data,
		R2 =>r2_data,
		R3 =>r3_data,
		R4 =>r4_data,
		R5 =>r5_data,
		R6 =>r6_data,
		R7 =>r7_data,
		R8 =>r8_data,
		R9 =>r9_data,
		R10 =>r10_data,
		R11 =>r11_data,
		R12 =>r12_data,
		R13 =>r13_data,
		R14 =>r14_data,
		R15 =>r15_data,
		R16 =>r16_data,
		R17 =>r17_data,
		R18 =>r18_data,
		R19 =>r19_data,
		R20 =>r20_data,
		R21 =>r21_data,
		R22 =>r22_data,
		R23 =>r23_data,
		R24 =>r24_data,
		R25 =>r25_data,
		R26 =>r26_data,
		R27 =>r27_data,
		R28 =>r28_data,
		R29 =>r29_data,
		R30 =>r30_data,
		R31 =>r31_data,
		Mux_out =>read2_t,
		Selector =>Ard2
	);

	Qout1A : Mux32to5_5bit 
	port map( 
		Q0 =>r0_Q,
		Q1 =>r1_Q,
		Q2 =>r2_Q,
		Q3 =>r3_Q,
		Q4 =>r4_Q,
		Q5 =>r5_Q,
		Q6 =>r6_Q,
		Q7 =>r7_Q,
		Q8 =>r8_Q,
		Q9 =>r9_Q,
		Q10 =>r10_Q,
		Q11 =>r11_Q,
		Q12 =>r12_Q,
		Q13 =>r13_Q,
		Q14 =>r14_Q,
		Q15 =>r15_Q,
		Q16 =>r16_Q,
		Q17 =>r17_Q,
		Q18 =>r18_Q,
		Q19 =>r19_Q,
		Q20 =>r20_Q,
		Q21 =>r21_Q,
		Q22 =>r22_Q,
		Q23 =>r23_Q,
		Q24 =>r24_Q,
		Q25 =>r25_Q,
		Q26 =>r26_Q,
		Q27 =>r27_Q,
		Q28 =>r28_Q,
		Q29 =>r29_Q,
		Q30 =>r30_Q,
		Q31 =>r31_Q,
		Mux_out =>q1_t,
		Selector =>Ard1
	);
	
	Qout2B : Mux32to5_5bit 
	port map( 
		Q0 =>r0_Q,
		Q1 =>r1_Q,
		Q2 =>r2_Q,
		Q3 =>r3_Q,
		Q4 =>r4_Q,
		Q5 =>r5_Q,
		Q6 =>r6_Q,
		Q7 =>r7_Q,
		Q8 =>r8_Q,
		Q9 =>r9_Q,
		Q10 =>r10_Q,
		Q11 =>r11_Q,
		Q12 =>r12_Q,
		Q13 =>r13_Q,
		Q14 =>r14_Q,
		Q15 =>r15_Q,
		Q16 =>r16_Q,
		Q17 =>r17_Q,
		Q18 =>r18_Q,
		Q19 =>r19_Q,
		Q20 =>r20_Q,
		Q21 =>r21_Q,
		Q22 =>r22_Q,
		Q23 =>r23_Q,
		Q24 =>r24_Q,
		Q25 =>r25_Q,
		Q26 =>r26_Q,
		Q27 =>r27_Q,
		Q28 =>r28_Q,
		Q29 =>r29_Q,
		Q30 =>r30_Q,
		Q31 =>r31_Q,
		Mux_out =>q2_t,
		Selector =>Ard2
	);
	
	CDB_Read1_Check : Comparator5bit
	port map(
		input1 => CDB_Q,
	   input2 => q1_t,
		rst => arst,
		output => check1
	);	
	
	CDB_Read2_Check : Comparator5bit
	port map(
		input1 => CDB_Q,
	   input2 => q2_t,
		rst => arst,
		output => check2
	);
	
	final_read1: Mux2to1
	port map(
		D0 => read1_t,
		D1 => CDB_DATA,
		Mux_out => Dout1,
		Selector => check1
	);
	final_read2: Mux2to1
	port map(
		D0 => read2_t,
		D1 => CDB_DATA,
		Mux_out => Dout2,
		Selector => check2
	);
	final_q1: Mux2to1_5bit
	port map(
		Q0 => q1_t,
		Q1 => "00000",
		Mux_out => Qout1,
		Selector => check1
	);
	final_q2: Mux2to1_5bit
	port map(
		Q0 => q2_t,
		Q1 => "00000",
		Mux_out => Qout2,
		Selector => check2
	);
	comp_R0 : Comparator5bit
	port map(
		input1 => R0_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(0)
	);
	
	comp_R1 : Comparator5bit
	port map(
		input1 => R1_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(1)
	);
	
	comp_R2 : Comparator5bit
	port map(
		input1 => R2_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(2)
	);
	
	comp_R3 : Comparator5bit
	port map(
		input1 => R3_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(3)
	);
	
	comp_R4 : Comparator5bit
	port map(
		input1 => R4_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(4)
	);
	
	comp_R5 : Comparator5bit
	port map(
		input1 => R5_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(5)
	);	
	
	comp_R6 : Comparator5bit
	port map(
		input1 => R6_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(6)
	);
	
	comp_R7 : Comparator5bit
	port map(
		input1 => R7_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(7)
	);
	
	comp_R8 : Comparator5bit
	port map(
		input1 => R8_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(8)
	);
	
	comp_R9 : Comparator5bit
	port map(
		input1 => R9_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(9)
	);
	
	comp_R10 : Comparator5bit
	port map(
		input1 => R10_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(10)
	);
	
	comp_R11 : Comparator5bit
	port map(
		input1 => R11_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(11)
	);
	
	comp_R12 : Comparator5bit
	port map(
		input1 => R12_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(12)
	);
	
	comp_R13 : Comparator5bit
	port map(
		input1 => R13_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(13)
	);
	
	comp_R14 : Comparator5bit
	port map(
		input1 => R14_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(14)
	);
	
	comp_R15 : Comparator5bit
	port map(
		input1 => R15_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(15)
	);	
	
	comp_R16 : Comparator5bit
	port map(
		input1 => R16_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(16)
	);
	
	comp_R17 : Comparator5bit
	port map(
		input1 => R17_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(17)
	);
	
	comp_R18 : Comparator5bit
	port map(
		input1 => R18_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(18)
	);
	
	comp_R19 : Comparator5bit
	port map(
		input1 => R19_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(19)
	);
	
	comp_R20 : Comparator5bit
	port map(
		input1 => R20_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(20)
	);
	
	comp_R21 : Comparator5bit
	port map(
		input1 => R21_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(21)
	);
	
	comp_R22 : Comparator5bit
	port map(
		input1 => R22_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(22)
	);
	
	comp_R23 : Comparator5bit
	port map(
		input1 => R23_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(23)
	);
	
	comp_R24 : Comparator5bit
	port map(
		input1 => R24_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(24)
	);
	
	comp_R25 : Comparator5bit
	port map(
		input1 => R25_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(25)
	);	
	
	comp_R26 : Comparator5bit
	port map(
		input1 => R26_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(26)
	);
	
	comp_R27 : Comparator5bit
	port map(
		input1 => R27_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(27)
	);
	
	comp_R28 : Comparator5bit
	port map(
		input1 => R28_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(28)
	);
	
	comp_R29 : Comparator5bit
	port map(
		input1 => R29_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(29)
	);
	
	comp_R30 : Comparator5bit
	port map(
		input1 => R30_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(30)
	);
	
	comp_R31 : Comparator5bit
	port map(
		input1 => R31_Q,
	   input2 => CDB_Q,
		rst => arst,
		output => data_WE(31)
	);
	
	Decoder_Tags: Decoder5to32
       port map( input => Awr,
		           output => decoder_Output
					  );
	
	Reg0 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(0),
			Q_WE => Q_WE(0),
			Dout => r0_data,
			Qout => r0_Q
		);

	Reg1 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(1),
			Q_WE => Q_WE(1),
			Dout => r1_data,
			Qout => r1_Q
		);
		
	Reg2 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(2),
			Q_WE => Q_WE(2),
			Dout => r2_data,
			Qout => r2_Q
		);

	Reg3 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(3),
			Q_WE => Q_WE(3),
			Dout => r3_data,
			Qout => r3_Q
		);
		
	Reg4 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(4),
			Q_WE => Q_WE(4),
			Dout => r4_data,
			Qout => r4_Q
		);
		
	Reg5 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(5),
			Q_WE => Q_WE(5),
			Dout => r5_data,
			Qout => r5_Q
		);
		
	Reg6 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(6),
			Q_WE => Q_WE(6),
			Dout => r6_data,
			Qout => r6_Q
		);
		
	Reg7 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(7),
			Q_WE => Q_WE(7),
			Dout => r7_data,
			Qout => r7_Q
		);
		
	Reg8 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(8),
			Q_WE => Q_WE(8),
			Dout => r8_data,
			Qout => r8_Q
		);
		
	Reg9 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(9),
			Q_WE => Q_WE(9),
			Dout => r9_data,
			Qout => r9_Q
		);
		
	Reg10 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(10),
			Q_WE => Q_WE(10),
			Dout => r10_data,
			Qout => r10_Q
		);
		
	Reg11 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(11),
			Q_WE => Q_WE(11),
			Dout => r11_data,
			Qout => r11_Q
		);
		
	Reg12 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(12),
			Q_WE => Q_WE(12),
			Dout => r12_data,
			Qout => r12_Q
		);
		
	Reg13 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(13),
			Q_WE => Q_WE(13),
			Dout => r13_data,
			Qout => r13_Q
		);
		
	Reg14 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(14),
			Q_WE => Q_WE(14),
			Dout => r14_data,
			Qout => r14_Q
		);
		
	Reg15 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(15),
			Q_WE => Q_WE(15),
			Dout => r15_data,
			Qout => r15_Q
		);
		
	Reg16 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(16),
			Q_WE => Q_WE(16),
			Dout => r16_data,
			Qout => r16_Q
		);
		
	Reg17 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(17),
			Q_WE => Q_WE(17),
			Dout => r17_data,
			Qout => r17_Q
		);
		
	Reg18 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(18),
			Q_WE => Q_WE(18),
			Dout => r18_data,
			Qout => r18_Q
		);
		
	Reg19 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(19),
			Q_WE => Q_WE(19),
			Dout => r19_data,
			Qout => r19_Q
		);
		
	Reg20 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(20),
			Q_WE => Q_WE(20),
			Dout => r20_data,
			Qout => r20_Q
		);
		
	Reg21 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(21),
			Q_WE => Q_WE(21),
			Dout => r21_data,
			Qout => r21_Q
		); 
		
	Reg22 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(22),
			Q_WE => Q_WE(22),
			Dout => r22_data,
			Qout => r22_Q
		);
	Reg23 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(23),
			Q_WE => Q_WE(23),
			Dout => r23_data,
			Qout => r23_Q
		);
		
	Reg24 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(24),
			Q_WE => Q_WE(24),
			Dout => r24_data,
			Qout => r24_Q
		);
		
	Reg25 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(25),
			Q_WE => Q_WE(25),
			Dout => r25_data,
			Qout => r25_Q
		);
		
	Reg26 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(26),
			Q_WE => Q_WE(26),
			Dout => r26_data,
			Qout => r26_Q
		);
		
	Reg27 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(27),
			Q_WE => Q_WE(27),
			Dout => r27_data,
			Qout => r27_Q
		);
		
	Reg28 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(28),
			Q_WE => Q_WE(28),
			Dout => r28_data,
			Qout => r28_Q
		);

	Reg29 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(29),
			Q_WE => Q_WE(29),
			Dout => r29_data,
			Qout => r29_Q
		);
		
	Reg30 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(30),
			Q_WE => Q_WE(30),
			Dout => r30_data,
			Qout => r30_Q
		);
	Reg31 : Register37bit 	
		port map (
			Data => CDB_DATA,
			arst => arst,
			Q => Qin,
	      Clk => Clk,
			Data_WE => data_WE(31),
			Q_WE => Q_WE(31),
			Dout => r31_data,
			Qout => r31_Q
		);	
		
end Behavioral;

