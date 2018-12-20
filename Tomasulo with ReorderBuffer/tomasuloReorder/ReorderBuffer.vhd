
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ReorderBuffer is
	port(
		clk : in std_logic;
		rst : in std_logic;
		cdb_q : in std_logic_vector(4 downto 0);
		cdb_data : in std_logic_vector(31 downto 0);
		issue : in std_logic;
		accepted : in std_logic;
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
end ReorderBuffer;

architecture Behavioral of ReorderBuffer is
	signal we_sig : std_logic_vector(6 downto 0);
	signal rst_sig : std_logic_vector(6 downto 0);
	signal commit_done1,sig : std_logic;
	signal output0,output1,output2,output3,output4,output5,output6,input0,input1,input2,input3,input4,input5,input6:std_logic_vector(42 downto 0);
	component Register43bit is
	port( 
		input_data : in std_logic_vector(42 downto 0);
		Clk : in std_logic;
		WE : in std_logic;
		arst : in std_logic;
		cdb_q : in std_logic_vector(4 downto 0 );
		cdb_data : in std_logic_vector(31 downto 0);
		output_data : out std_logic_vector(42 downto 0)
	);
	end component;
begin
	reg0 : Register43bit
	port map(
		input_data =>input0,
		Clk =>clk,
		WE =>we_sig(0),
		arst =>rst_sig(0),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output0
	);
	reg1 : Register43bit
	port map(
		input_data =>input1,
		Clk =>clk,
		WE =>we_sig(1),
		arst =>rst_sig(1),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output1
	);
	reg2 : Register43bit
	port map(
		input_data =>input2,
		Clk =>clk,
		WE =>we_sig(2),
		arst =>rst_sig(2),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output2
	);
	reg3 : Register43bit
	port map(
		input_data =>input3,
		Clk =>clk,
		WE =>we_sig(3),
		arst =>rst_sig(3),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output3
	);
	reg4 : Register43bit
	port map(
		input_data =>input4,
		Clk =>clk,
		WE =>we_sig(4),
		arst =>rst_sig(4),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output4
	);
	reg5 : Register43bit
	port map(
		input_data =>input5,
		Clk =>clk,
		WE =>we_sig(5),
		arst =>rst_sig(5),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output5
	);
	reg6 : Register43bit
	port map(
		input_data =>input6,
		Clk =>clk,
		WE =>we_sig(6),
		arst =>rst_sig(6),
		cdb_q =>cdb_q,
		cdb_data =>cdb_data,
		output_data =>output6
	);
	process(read1_addr,read2_addr,read1_data,read2_data,clk)
	begin
	if (rising_edge(clk)) then
		if(read1_addr=output0(41 downto 37)) then
			read1_q_out <= output0(36 downto 31);
			read1_data_out <= "00000000000000000000000000000000";
		else
			if(read1_addr=output1(41 downto 37)) then
				read1_q_out <= output1(36 downto 31);
				read1_data_out <= "00000000000000000000000000000000";
			else
				if(read1_addr=output2(41 downto 37)) then
					read1_q_out <= output2(36 downto 31);
					read1_data_out <= "00000000000000000000000000000000";
				else
					if(read1_addr=output3(41 downto 37)) then
						read1_q_out <= output3(36 downto 31);
						read1_data_out <= "00000000000000000000000000000000";
					else
						if(read1_addr=output4(41 downto 37)) then
							read1_q_out <= output4(36 downto 31);
							read1_data_out <= "00000000000000000000000000000000";
						else
							if(read1_addr=output5(41 downto 37)) then
								read1_q_out <= output5(36 downto 31);
								read1_data_out <= "00000000000000000000000000000000";
							else
								if(read1_addr=output6(41 downto 37)) then
									read1_q_out <= output6(36 downto 31);
									read1_data_out <= "00000000000000000000000000000000";
								else
									read1_q_out <= "00000";
									read1_data_out <= read1_data;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
		if(read2_addr=output0(41 downto 37)) then
			read2_q_out <= output0(36 downto 31);
			read2_data_out <= "00000000000000000000000000000000";
		else
			if(read2_addr=output1(41 downto 37)) then
				read2_q_out <= output1(36 downto 31);
				read2_data_out <= "00000000000000000000000000000000";
			else
				if(read2_addr=output2(41 downto 37)) then
					read2_q_out <= output2(36 downto 31);
					read2_data_out <= "00000000000000000000000000000000";
				else
					if(read2_addr=output3(41 downto 37)) then
						read2_q_out <= output3(36 downto 31);
						read2_data_out <= "00000000000000000000000000000000";
					else
						if(read2_addr=output4(41 downto 37)) then
							read2_q_out <= output4(36 downto 31);
							read2_data_out <= "00000000000000000000000000000000";
						else
							if(read2_addr=output5(41 downto 37)) then
								read2_q_out <= output5(36 downto 31);
								read2_data_out <= "00000000000000000000000000000000";
							else
								if(read2_addr=output6(41 downto 37)) then
									read2_q_out <= output6(36 downto 31);
									read2_data_out <= "00000000000000000000000000000000";
								else
									read2_q_out <= "00000";
									read2_data_out <= read1_data;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end if;
	end process;
	
	process(output0,rst) 
	begin
		if(rst='1') then
			commit <='0';
			sig <='0';
		else
			if(output0(42) = '1') then
				commit <= '1';
				sig <= '1';
			else 
				commit <= '0';
				sig <= '0';
			end if;
		end if;
	end process;
	
	process(output0,output1,output2,output3,output4,output5,output6,rst,tag_in,rd,issue,sig,cdb_q)
	begin
		if(rst = '1') then
			we_sig <= "0000000";
			rst_sig <="1111111";
			input0<="0000000000000000000000000000000000000000000";
			input1<="0000000000000000000000000000000000000000000";
			input2<="0000000000000000000000000000000000000000000";
			input3<="0000000000000000000000000000000000000000000";
			input4<="0000000000000000000000000000000000000000000";
			input5<="0000000000000000000000000000000000000000000";
			input6<="0000000000000000000000000000000000000000000";
		else 
			if(issue = '1' and sig='0' and accepted = '1') then
				rst_sig <="0000000";
				if(output0 = "0000000000000000000000000000000000000000000") then
					input0 <= '0' & rd & tag_in & "00000000000000000000000000000000";
					we_sig <= "0000001";
				else
					if(output1 = "0000000000000000000000000000000000000000000") then
						input1 <= '0' & rd & tag_in & "00000000000000000000000000000000";
						we_sig <= "0000010";
					else
						if(output2 = "0000000000000000000000000000000000000000000") then
							input2 <= '0' & rd & tag_in & "00000000000000000000000000000000";
							we_sig <= "0000100";
						else
							if(output3 = "0000000000000000000000000000000000000000000") then
								input3 <= '0' & rd & tag_in & "00000000000000000000000000000000";
								we_sig <= "0001000";
							else
								if(output4 = "0000000000000000000000000000000000000000000") then
									input4 <= '0' & rd & tag_in & "00000000000000000000000000000000";
									we_sig <= "0010000";
								else
									if(output5 = "0000000000000000000000000000000000000000000") then
										input5 <= '0' & rd & tag_in & "00000000000000000000000000000000";
										we_sig <= "0100000";
									else
										if(output6 = "0000000000000000000000000000000000000000000") then
											input6 <= '0' & rd & tag_in & "00000000000000000000000000000000";
											we_sig <= "1000000";
										else
											we_sig <= "0000000";
											
										end if;
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
			elsif(issue = '1' and sig='1' and accepted ='1') then
				rst_sig <="0000000";
				if(output1 = "0000000000000000000000000000000000000000000") then
					input0<= '0' & rd & tag_in & "00000000000000000000000000000000";
					we_sig <= "0000001";
				else
					if(output2 = "0000000000000000000000000000000000000000000") then
						input1<= '0' & rd & tag_in & "00000000000000000000000000000000";
						input0<= output1;
						we_sig <= "0000011";
					else
						if(output3 = "0000000000000000000000000000000000000000000") then
							input2<= '0' & rd & tag_in & "00000000000000000000000000000000";
							input1<= output2;
							input0<= output1;
							we_sig <= "0000111";
						else
							if(output4 = "0000000000000000000000000000000000000000000") then
								input3<= '0' & rd & tag_in & "00000000000000000000000000000000";
								input2<= output3;
								input1<= output2;
								input0<= output1;
								we_sig <= "0001111";
							else
								if(output5 = "0000000000000000000000000000000000000000000") then
									input4<= '0' & rd & tag_in & "00000000000000000000000000000000";
									input3<= output4;
									input2<= output3;
									input1<= output2;
									input0<= output1;
									we_sig <= "0011111";
								else
									if(output6 = "0000000000000000000000000000000000000000000") then
										input5<= '0' & rd & tag_in & "00000000000000000000000000000000";
										input4<= output5;
										input3<= output4;
										input2<= output3;
										input1<= output2;
										input0<= output1;
										we_sig <= "0111111";
									else
										we_sig <= "1111111";
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
			elsif((issue = '0' and sig='1') or (issue ='1' and sig ='1' and accepted ='0')) then
				if(output1 = "0000000000000000000000000000000000000000000") then
					we_sig <="0000001";
					input0<= "0000000000000000000000000000000000000000000";
				else
					if(output2 = "0000000000000000000000000000000000000000000") then
						input0<= output1;
						input1<= "0000000000000000000000000000000000000000000";
						we_sig <= "0000011";
					else
						if(output3 = "0000000000000000000000000000000000000000000") then
							input2<= "0000000000000000000000000000000000000000000";
							input1<= output2;
							input0<= output1;
							we_sig <= "0000111";
						else
							if(output4 = "0000000000000000000000000000000000000000000") then
								input3<= "0000000000000000000000000000000000000000000";
								input2<= output3;
								input1<= output2;
								input0<= output1;
								we_sig <= "0001111";
							else
								if(output5 = "0000000000000000000000000000000000000000000") then
									input4<= "0000000000000000000000000000000000000000000";
									input3<= output4;
									input2<= output3;
									input1<= output2;
									input0<= output1;
									we_sig <= "0011111";
								else
									if(output6 = "0000000000000000000000000000000000000000000") then
										input5<= "0000000000000000000000000000000000000000000";
										input4<= output5;
										input3<= output4;
										input2<= output3;
										input1<= output2;
										input0<= output1;
										we_sig <= "0111111";
									else
										input6<= "0000000000000000000000000000000000000000000";
										we_sig <= "1111111";
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
			else
				rst_sig <="0000000";
				we_sig <= "0000000";
			end if;
		end if;
	end process;
	awr <= output0(41 downto 37) when sig='1' else
			"00000";
	rb_full <='0' when output6 = "0000000000000000000000000000000000000000000" else
				 '1';
	data_out <= output0(31 downto 0) when sig='1' else
					"00000000000000000000000000000000";
end Behavioral;

