library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReservationStation2 is
		port(
			 RST    : in  std_logic;
			 CLK    : in  std_logic;
			 ex	  : in std_logic;
			 
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
end ReservationStation2;

architecture Behavioral of ReservationStation2 is

	signal busy_sig,ready_sig :std_logic_vector(1 downto 0);
	signal rs0_Vj,rs1_Vj : std_logic_vector(31 downto 0);
	signal rs0_op,rs1_op : std_logic_vector(1 downto 0);
	signal rs0_Vk,rs1_Vk : std_logic_vector(31 downto 0);
	signal rs0_Qj,rs1_Qj : std_logic_vector(4 downto 0);
	signal rs0_Qk,rs1_Qk : std_logic_vector(4 downto 0);
	
	signal c0,c1,c2,t0,t1,t2,t3,t4,t5,t6,t7,t8,rs0_update_sig,rs1_update_sig,rs2_update_sig,reset_rs0,reset_rs1,reset_rs2: std_logic;
	signal rs0_update_data,rs1_update_data,rs2_update_data: std_logic_vector(73 downto 0);
	
	component Register76bit is
		port (
			WE   : in  std_logic;
			RST  : in  std_logic;
			CLK  : in  std_logic;
			Data : in  std_logic_vector(75 downto 0);
			Update: in std_logic;
			update_data: in std_logic_vector(73 downto 0);
			Dout : out std_logic_vector(75 downto 0) );
	end Component;

begin
	Reg0: Register76bit
	port map 
	(
		WE => WE(0), 
		RST => reset_rs0, 
		CLK => CLK, 
		Data(75 downto 74) => Op_in,
		Data(73 downto 69) => Qj_in,
		Data(68 downto 37) => Vj_in,
		Data(36 downto 32) => Qk_in,
		Data(31 downto  0) => Vk_in,
		Update=>rs0_update_sig,
		update_data=>rs0_update_data,
		Dout(75 downto 74) => rs0_op,
		Dout(73 downto 69) => rs0_Qj,
		Dout(68 downto 37) => rs0_Vj,
		Dout(36 downto 32) => rs0_Qk,
		Dout(31 downto  0) => rs0_Vk
	);
	
	Reg1: Register76bit
	port map 
	(
		WE => WE(1), 
		RST => Reset_rs1, 
		CLK => CLK, 
		Data(75 downto 74) => Op_in,
		Data(73 downto 69) => Qj_in,
		Data(68 downto 37) => Vj_in,
		Data(36 downto 32) => Qk_in,
		Data(31 downto  0) => Vk_in,
		Update=>rs1_update_sig,
		update_data=>rs1_update_data,
		Dout(75 downto 74) => rs1_op,
		Dout(73 downto 69) => rs1_Qj,
		Dout(68 downto 37) => rs1_Vj,
		Dout(36 downto 32) => rs1_Qk,
		Dout(31 downto  0) => rs1_Vk
	);
	
	
	
	process (CDB_Q,Qj_in,Qk_in,WE,ex,rst,rg_sel)
	begin
	 if (rst = '1') then
		 Op_out <= "11";
		 Vj_out <= "00000000000000000000000000000000";
		 Vk_out <= "00000000000000000000000000000000";
	 else
		 if (Rg_Sel = "01" and busy_sig(0) ='1'  and ready_sig(0)='1') then
			Op_out <= rs0_op;
			Vj_out <= rs0_Vj;
			Vk_out <= rs0_Vk;
			tag_out<= "00" & "001";
		 elsif (Rg_Sel = "10" and busy_sig(1) ='1' and ready_sig(1)='1') then
			Op_out <= rs1_op;
			Vj_out <= rs1_Vj;
			Vk_out <= rs1_Vk; 
			tag_out<= "00" & "010";
		 end if;
	 end if;
	end process;
	
	
	process(CDB_Q,Qj_in,Qk_in,WE,rst)
	begin
	  if (rst = '1') then
		 rs0_update_sig <='0';
		 rs1_update_sig <='0';
	  	else
			if(CDB_Q = rs0_Qj and CDB_Q = rs0_Qk) then 
				rs0_update_sig <= '1';
				rs0_update_data <= "00000" & CDB_V & "00000" & CDB_V;
			elsif(CDB_Q /= rs0_Qj and CDB_Q = rs0_Qk) then 
				rs0_update_sig <= '1';
				rs0_update_data <= rs0_Qj & rs0_Vj & "00000" & CDB_V;
			elsif(CDB_Q = rs0_Qj and CDB_Q /= rs0_Qk) then
				rs0_update_sig <= '1';
				rs0_update_data <= "00000" & CDB_V & rs0_Qk & rs0_Vk;
			else 
				rs0_update_sig <= '0';
			end if;
		
			if(CDB_Q = rs1_Qj and CDB_Q = rs1_Qk) then 
				rs1_update_sig <= '1';
				rs1_update_data <= "00000" & CDB_V & "00000" & CDB_V;
			elsif(CDB_Q /= rs1_Qj and CDB_Q = rs1_Qk) then 
				rs1_update_sig <= '1';
				rs1_update_data <= rs1_Qj & rs1_Vj & "00000" & CDB_V;
			elsif(CDB_Q = rs1_Qj and CDB_Q /= rs1_Qk) then
				rs1_update_sig <= '1';
				rs1_update_data <= "00000" & CDB_V & rs1_Qk & rs1_Vk;
			else 
				rs1_update_sig <= '0';
			end if;
		end if;
  end process;
  
  process(ex,WE,rs0_Qj,rs1_Qj,rs0_Qk,rs1_Qk)
	begin
	t0<=((not(Rg_Sel(1))) and Rg_Sel(0));
	t1<=(not(Rg_Sel(0))) and Rg_Sel(1);
	t3<=not(rs0_Qj(0)) and not(rs0_Qj(1)) and not(rs0_Qj(2)) and not(rs0_Qj(3)) and not(rs0_Qj(4)) and not(rs0_Qk(0)) and not(rs0_Qk(1)) and not(rs0_Qk(2)) and not(rs0_Qk(3)) and not(rs0_Qk(4)) ; 
	t4<=not(rs1_Qj(0)) and not(rs1_Qj(1)) and not(rs1_Qj(2)) and not(rs1_Qj(3)) and not(rs1_Qj(4)) and not(rs1_Qk(0)) and not(rs1_Qk(1)) and not(rs1_Qk(2)) and not(rs1_Qk(3)) and not(rs1_Qk(4)) ; 
	t6 <= (not(WE(1))) and (WE(0));
	t7 <= (WE(1)) and not(WE(0));
  end process;
	c0 <= ex and t0;
	c1 <= ex and t1;
	
	reset_rs0 <= '1' when CDB_Q = "00001" else
					 '1' when rst ='1' else 
					 '0';
	
	reset_rs1 <= '1' when CDB_Q = "00010" else
					 '1' when rst ='1' else 
					 '0';
	
	busy_sig(0) <= '1' when t6='1' else
						'0' when reset_rs0='1' else
						busy_sig(0);
						
	busy_sig(1)<= '1' when t7='1' else
					  '0' when reset_rs1='1' else
					  busy_sig(1);
						
						
	ready_sig(0)<= '1' when t3='1' else
						'0' when reset_rs0='1' else
						ready_sig(0);
						
	ready_sig(1)<= '1' when t4='1' else
						'0' when reset_rs1='1' else
						ready_sig(1);
						

	busy<= busy_sig;
	ready<= ready_sig;
end Behavioral;

