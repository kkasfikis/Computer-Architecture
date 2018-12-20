--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:07:57 11/11/2018
-- Design Name:   
-- Module Name:   /home/ise/TOMASULO_PROC/data_test.vhd
-- Project Name:  TOMASULO_PROC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: datapath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY data_test IS
END data_test;
 
ARCHITECTURE behavior OF data_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT datapath
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         issue : IN  std_logic;
         FU_type : IN  std_logic_vector(1 downto 0);
         F_OP : IN  std_logic_vector(1 downto 0);
         Rs : IN  std_logic_vector(4 downto 0);
         Rt : IN  std_logic_vector(4 downto 0);
         Rd : IN  std_logic_vector(4 downto 0);
         accepted : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal issue : std_logic := '0';
   signal FU_type : std_logic_vector(1 downto 0) := (others => '0');
   signal F_OP : std_logic_vector(1 downto 0) := (others => '0');
   signal Rs : std_logic_vector(4 downto 0) := (others => '0');
   signal Rt : std_logic_vector(4 downto 0) := (others => '0');
   signal Rd : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal accepted : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: datapath PORT MAP (
          clk => clk,
          rst => rst,
          issue => issue,
          FU_type => FU_type,
          F_OP => F_OP,
          Rs => Rs,
          Rt => Rt,
          Rd => Rd,
          accepted => accepted
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		rst <= '1';
		issue <= '0';
      wait for clk_period;
      rst <= '0';
      wait for clk_period;
      issue <= '1';
      FU_type <= "00";
      F_OP <= "00";
      Rs <= "00110";
      Rt <= "01010";
      Rd <= "00001";
		wait for clk_period;
		issue <= '1';
		FU_type <= "00";
      F_OP <= "00";
      Rs <= "00101";
      Rt <= "00011";
      Rd <= "00010";
		wait for clk_period;
		issue <= '0';
		FU_type <= "11";
--		wait for clk_period*4;
--		issue <= '1';
--		FU_type <= "01";
--      F_OP <= "00";
--      Rs <= "00001";
--      Rt <= "00011";
--      Rd <= "00011";
--		wait for clk_period;
--      issue <= '1';
--		FU_type <= "01";
--		F_OP <= "01";
--      Rs <= "00001";
--      Rt <= "00111";
--      Rd <= "00100";
--		wait for clk_period;
--      issue <= '0';
--		fU_type <= "11";
      -- insert stimulus here 

      wait;
   end process;

END;
