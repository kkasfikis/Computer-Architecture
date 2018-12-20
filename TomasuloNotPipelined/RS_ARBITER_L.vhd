
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
	signal ex_sig,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10 : std_logic;	
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
	
	process--(FU_busy,ready,busy,rst)
	begin
		wait until clk'event and clk ='1';
		if(RST = '1') then
			ex_sig <='0';
		else
				if (Fu_Busy = '0' and Busy(0)='1' and ready(0) = '1') then
					ex_sig <= '1';
				elsif (Fu_Busy = '0' and (Busy(1)='1' and ready(1) = '1')) then
					ex_sig <= '1';
				else
					ex_sig <= '0';	
				
				end if;
		 end if;
	end process;

	t1 <= (not(Fu_Busy) and Busy(0) and ready(0));
   t2 <= (not(Fu_Busy) and Busy(1) and ready(1));
	
	t4 <= t1 and t2 ;
	t6 <= t1 and not(t2);
	t7 <= not(t1) and t2;
	
	
	we <= sig_we;
	
	rg_sel <= 	"01" when t4='1' else
					"01" when t6='1' else
					"10" when t7='1' else
					"00" when rst ='1' else
					"00";
	ex <= ex_sig;


			
end Behavioral;

