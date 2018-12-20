
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RS_ARBITER_L is
	Port ( 
		RST    : in  std_logic;
		CLK    : in  std_logic;	
		Fu_Busy : in std_logic;
		FU     : in  std_logic_vector(1 downto 0);
		Busy     : in  std_logic_vector(1 downto 0);
		Ready 	: in std_logic_vector(1 downto 0);
		rg_sel : out std_logic_vector(1 downto 0);
		ex : out std_logic;
		WE     : out std_logic_vector(1 downto 0)
	);
end RS_ARBITER_L;

architecture Behavioral of RS_ARBITER_L is
	signal sig_WE : std_logic_vector(1 downto 0);
	signal rg_sel_sig : std_logic_vector(1 downto 0);
	signal ex_sig,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,v1,v2 : std_logic;	
begin


	process--(rst,fu,busy)
	begin
	wait until clk'event and clk = '1';
		if(rst = '1') then
			sig_WE <= "00";
		else
			if(fu = "00") then
				if(busy(0) = '0') then 
					sig_WE <= "01";
				elsif (busy(1)='0' and busy(0)='1') then
					sig_WE <= "10";
				end if;
			 else
				sig_we <= "00";
			 end if;
		end if;
	end process;
	
	process(rst,rg_sel_sig)
	begin
		if(RST = '1') then
			ex_sig <='0';
		else
			if(fu_busy = '0' and (rg_sel_sig="01" or rg_sel_sig="10")) then 
				ex_sig <='1';
			else
				ex_sig <='0';
			end if;
		end if;
	end process;
	
	
	process(clk,rst)
	begin
		if(rst='1') then
			t1<='0';
			t2<='0';
			t3<='1';
			v1 <='0';
			v2 <='0';
		else
			if(rising_edge(clk))then
				if(ready(0)='1') then
					v1<='1';
				end if;
				if(ready(1)='1')then
					v2<='1';
				end if;
				if(busy(0)='0') then
					v1 <='0';
				end if;
				if(busy(1)='0')then
					v2<='0';
				end if;
				if(Fu_busy='0') then
					if(busy(0)='1' and ready(0)='1' and v1='0')then
						t1<='1';
						t2<='0';
						t3<='0';
					else
						if(busy(1)='1' and ready(1)='1' and v2='0') then
							t2<='1';
							t1<='0';
							t3<='0';
						else
							t1<='0';
							t2<='0';
							t3<='1';
						end if;
					end if;
				else 
					t3 <='1';
					t1 <='0';
					t2 <='0';
				end if;
			end if;
		end if;
--		t1 <= (not(Fu_Busy) and Busy(0) and ready(0)) and (not(not(rg_sel_sig(1)) and rg_sel_sig(0))); ----not 01
--		t2 <= (not(Fu_Busy) and Busy(1) and ready(1)) and (not(t1)) and (not(not(rg_sel_sig(0)) and rg_sel_sig(1)));  --- not 10 
--		t7 <= (t1 and t2) and (not(not(rg_sel_sig(1)) and rg_sel_sig(0)));
	end process;
	--t6 <= (not(t1) and not(t2));
	
	we <= sig_we;
	
	rg_sel_sig <= 	"10" when t2='1' else
						"01" when t1='1' else
						"00" when t3='1' else
						--"01" when t7='1' else
						--"00" when t6='1' else
						"00" when rst ='1' else
						rg_sel_sig;
	
	rg_sel <= rg_sel_sig;
	ex <= ex_sig;
end Behavioral;

