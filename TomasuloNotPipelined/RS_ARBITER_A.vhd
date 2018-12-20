
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RS_ARBITER_A is
	Port ( 
		RST    : in  std_logic;
		CLK    : in  std_logic;	
		Fu_Busy : in std_logic;
		FU     : in  std_logic_vector(1 downto 0);
		Busy     : in  std_logic_vector(2 downto 0);
		Ready 	: in std_logic_vector(2 downto 0);
		rg_sel : out std_logic_vector(1 downto 0);
		ex : out std_logic;
		WE     : out std_logic_vector(2 downto 0)
	);
end RS_ARBITER_A;

architecture Behavioral of RS_ARBITER_A is
	signal sig_WE : std_logic_vector(2 downto 0);
	signal rg_sel_sig : std_logic_vector(1 downto 0);
	signal ex_sig,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10 : std_logic;	
begin


	process
	begin
		wait until clk'event and clk = '1';
		if(rst = '1') then
			sig_WE <= "000";
		else
			if(fu = "01") then
				if(busy(0) = '0') then 
					sig_WE <= "001";
				elsif (busy(1)='0' and busy(0)='1') then
					sig_WE <= "010";
				elsif (busy(2)='0' and busy(1)='1' and busy(0)='1') then
					sig_WE <= "100";
				end if;
			 else
				sig_we <= "000";
			 end if;
		end if;
	end process;
	
	process
	begin
		wait until clk'event and clk ='1';
		if(RST = '1') then
			ex_sig <='0';
		else
				if (Fu_Busy = '0' and Busy(0)='1' and ready(0) = '1') then
					ex_sig <= '1';
				elsif (Fu_Busy = '0' and (Busy(1)='1' and ready(1) = '1')) then
					ex_sig <= '1';
				elsif (Fu_Busy = '0' and (Busy(2)='1' and ready(2) = '1')) then
					ex_sig <= '1';	
				else
					ex_sig <= '0';	
				end if;
		 end if;
	end process;

	t1 <= (not(Fu_Busy) and Busy(0) and ready(0));
   t2 <= (not(Fu_Busy) and Busy(1) and ready(1));
	t3 <= (not(Fu_Busy) and Busy(2) and ready(2));
	
	t4 <= t1 and t2 and t3;
	t5 <= t1 and t2 and not(t3);
	t6 <= t1 and not(t2) and t3;
	t7 <= not(t1) and t2 and t3;
	t8 <= t1 and not(t2) and not(t3);
	t9 <= not(t1) and not(t2) and t3;
	t10 <= not(t1) and t2 and not(t3);
	
	
	we <= sig_we;
	
	rg_sel <= 	"01" when t4='1' else
					"01" when t5='1' else
					"01" when t6='1' else
					"01" when t8='1' else
					"10" when t7='1' else
					"10" when t10='1' else
					"11" when t9='1' else
					"00" when rst ='1' else
					"00";
	ex <= ex_sig;			
end Behavioral;

