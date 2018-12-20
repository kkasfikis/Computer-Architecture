library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rb_RegFile is
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
end rb_RegFile;

architecture Behavioral of rb_RegFile is
signal we_sig,decoder_output : std_logic_vector(31 downto 0);
signal d0,d1,reg0_out,reg1_out,reg2_out,reg3_out,reg4_out,reg5_out,reg6_out,reg7_out,reg8_out,reg9_out,reg10_out,reg11_out,reg12_out,reg13_out,reg14_out,reg15_out,reg16_out,reg17_out,reg18_out,reg19_out,reg20_out,reg21_out,reg22_out,reg23_out,reg24_out,reg25_out,reg26_out,reg27_out,reg28_out,reg29_out,reg30_out,reg31_out: std_logic_vector(31 downto 0 );
component Register32bit is
	port( 
		Data : in std_logic_vector(31 downto 0);
		Clk : in std_logic;
		WE : in std_logic;
		arst : in std_logic;
		Dout : out std_logic_vector(31 downto 0)
	);
	end component;
	
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


begin
	
	Decoder_Tags: Decoder5to32
	port map( 
		input => Awr,
		output => decoder_output
	);
	
	Read1 : Mux32to5 
	port map( 
		R0 =>reg0_out,
		R1 =>reg1_out,
		R2 =>reg2_out,
		R3 =>reg3_out,
		R4 =>reg4_out,
		R5 =>reg5_out,
		R6 =>reg6_out,
		R7 =>reg7_out,
		R8 =>reg8_out,
		R9 =>reg9_out,
		R10 =>reg10_out,
		R11 =>reg11_out,
		R12 =>reg12_out,
		R13 =>reg13_out,
		R14 =>reg14_out,
		R15 =>reg15_out,
		R16 =>reg16_out,
		R17 =>reg17_out,
		R18 =>reg18_out,
		R19 =>reg19_out,
		R20 =>reg20_out,
		R21 =>reg21_out,
		R22 =>reg22_out,
		R23 =>reg23_out,
		R24 =>reg24_out,
		R25 =>reg25_out,
		R26 =>reg26_out,
		R27 =>reg27_out,
		R28 =>reg28_out,
		R29 =>reg29_out,
		R30 =>reg30_out,
		R31 =>reg31_out,
		Mux_out =>d0,
		Selector =>Ard1
	);

	Read2 : Mux32to5 
	port map( 
		R0 =>reg0_out,
		R1 =>reg1_out,
		R2 =>reg2_out,
		R3 =>reg3_out,
		R4 =>reg4_out,
		R5 =>reg5_out,
		R6 =>reg6_out,
		R7 =>reg7_out,
		R8 =>reg8_out,
		R9 =>reg9_out,
		R10 =>reg10_out,
		R11 =>reg11_out,
		R12 =>reg12_out,
		R13 =>reg13_out,
		R14 =>reg14_out,
		R15 =>reg15_out,
		R16 =>reg16_out,
		R17 =>reg17_out,
		R18 =>reg18_out,
		R19 =>reg19_out,
		R20 =>reg20_out,
		R21 =>reg21_out,
		R22 =>reg22_out,
		R23 =>reg23_out,
		R24 =>reg24_out,
		R25 =>reg25_out,
		R26 =>reg26_out,
		R27 =>reg27_out,
		R28 =>reg28_out,
		R29 =>reg29_out,
		R30 =>reg30_out,
		R31 =>reg31_out,
		Mux_out =>d1,
		Selector =>Ard2
	);

reg0 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(0),
		arst =>arst,
		Dout => reg0_out
	);
reg1 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(1),
		arst =>arst,
		Dout => reg1_out
	);
reg2 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(2),
		arst =>arst,
		Dout => reg2_out
	);
reg3 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(3),
		arst =>arst,
		Dout => reg3_out
	);
reg4 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(4),
		arst =>arst,
		Dout => reg4_out
	);
reg5 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(5),
		arst =>arst,
		Dout => reg5_out
	);
reg6 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(6),
		arst =>arst,
		Dout => reg6_out
	);
reg7 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(7),
		arst =>arst,
		Dout => reg7_out
	);
reg8 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(8),
		arst =>arst,
		Dout => reg8_out
	);
reg9 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(9),
		arst =>arst,
		Dout => reg9_out
	);
reg10 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(10),
		arst =>arst,
		Dout => reg10_out
	);
reg11: Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(11),
		arst =>arst,
		Dout => reg11_out
	);
reg12 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(12),
		arst =>arst,
		Dout => reg12_out
	);
reg13 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(13),
		arst =>arst,
		Dout => reg13_out
	);
reg14 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(14),
		arst =>arst,
		Dout => reg14_out
	);
reg15 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(15),
		arst =>arst,
		Dout => reg15_out
	);
reg16 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(16),
		arst =>arst,
		Dout => reg16_out
	);
reg17 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(17),
		arst =>arst,
		Dout => reg17_out
	);
reg18 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(18),
		arst =>arst,
		Dout => reg18_out
	);
reg19 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(19),
		arst =>arst,
		Dout => reg19_out
	);
reg20 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(20),
		arst =>arst,
		Dout => reg20_out
	);
reg21 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(21),
		arst =>arst,
		Dout => reg21_out
	);
reg22 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(22),
		arst =>arst,
		Dout => reg22_out
	);
reg23 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(23),
		arst =>arst,
		Dout => reg23_out
	);
reg24 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(24),
		arst =>arst,
		Dout => reg24_out
	);
reg25 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(25),
		arst =>arst,
		Dout => reg25_out
	);
reg26 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(26),
		arst =>arst,
		Dout => reg26_out
	);
reg27 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(27),
		arst =>arst,
		Dout => reg27_out
	);
reg28 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(28),
		arst =>arst,
		Dout => reg28_out
	);
reg29 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(29),
		arst =>arst,
		Dout => reg29_out
	);
reg30 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(30),
		arst =>arst,
		Dout => reg30_out
	);
reg31 : Register32bit
	port map(
		Data=>data_in,
		Clk =>Clk,
		WE =>we_sig(31),
		arst =>arst,
		Dout => reg31_out
	);

we_sig(0) <= decoder_output(0) and WrEn ; 
we_sig(1) <= decoder_output(1) and WrEn ; 
we_sig(2) <= decoder_output(2) and WrEn ; 
we_sig(3) <= decoder_output(3) and WrEn ; 
we_sig(4) <= decoder_output(4) and WrEn ; 
we_sig(5) <= decoder_output(5) and WrEn ; 
we_sig(6) <= decoder_output(6) and WrEn ; 
we_sig(7) <= decoder_output(7) and WrEn ; 
we_sig(8) <= decoder_output(8) and WrEn ; 
we_sig(9) <= decoder_output(9) and WrEn ; 

we_sig(10) <= decoder_output(10) and WrEn ; 
we_sig(11) <= decoder_output(11) and WrEn ; 
we_sig(12) <= decoder_output(12) and WrEn ; 
we_sig(13) <= decoder_output(13) and WrEn ; 
we_sig(14) <= decoder_output(14) and WrEn ; 
we_sig(15) <= decoder_output(15) and WrEn ; 
we_sig(16) <= decoder_output(16) and WrEn ; 
we_sig(17) <= decoder_output(17) and WrEn ; 
we_sig(18) <= decoder_output(18) and WrEn ; 
we_sig(19) <= decoder_output(19) and WrEn ; 


we_sig(20) <= decoder_output(20) and WrEn ; 
we_sig(21) <= decoder_output(21) and WrEn ; 
we_sig(22) <= decoder_output(22) and WrEn ; 
we_sig(23) <= decoder_output(23) and WrEn ; 
we_sig(24) <= decoder_output(24) and WrEn ; 
we_sig(25) <= decoder_output(25) and WrEn ; 
we_sig(26) <= decoder_output(26) and WrEn ; 
we_sig(27) <= decoder_output(27) and WrEn ; 
we_sig(28) <= decoder_output(28) and WrEn ; 
we_sig(29) <= decoder_output(29) and WrEn ;

we_sig(30) <= decoder_output(30) and WrEn ; 
we_sig(31) <= decoder_output(31) and WrEn ;

Dout1 <= d0;
Dout2 <= d1; 
end Behavioral;

