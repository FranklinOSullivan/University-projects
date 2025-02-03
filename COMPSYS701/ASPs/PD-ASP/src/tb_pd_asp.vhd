library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.TdmaMinTypes.all;

entity tb_pd_asp is
end entity tb_pd_asp;

architecture sim of tb_pd_asp is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal send_signal: tdma_min_port := (others => (others => '0'));
    signal recv_signal : tdma_min_port := (others => (others => '0'));

begin

    -- Clock generation process
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period ;
            clk <= '1';
            wait for clk_period ;
        end loop;
    end process;

    -- DUT instantiation
    DUT : entity work.pd_asp
        port map (
            clock => clk,
            reset => rst,
            recv  => recv_signal,
            send  => send_signal
        );

    -- Testbench process
    tb_process : process
    begin
        -- Initial reset
        rst <= '1';
        wait for clk_period * 1;
        rst <= '0';

        -- Applying test 
	wait for clk_period;

        recv_signal.data(31 downto 0) <= "11000000000000000000000000000001"; -- start signal low 
	recv_signal.data(16) <= '0';
        recv_signal.addr(7 downto 0) <= "00000000";

        wait for clk_period;

	

        recv_signal.data(31 downto 0) <= "11000000000000000000000000000110"; -- increase signal value
	recv_signal.data(16) <= '0';
        recv_signal.addr(7 downto 0) <= "00000000";

        wait for clk_period;

	
    
        recv_signal.data(31 downto 0) <= "11000000000000000000000000000010"; -- decrease value showing peak
	recv_signal.data(16) <= '0';
        recv_signal.addr(7 downto 0) <= "00000000";

	wait for clk_period;
	wait for clk_period;
	wait for clk_period;
	
	-- trough check 
	-- bit 16 = '1' for invert 
	-- type for PD-ASP = "1100"
	
	wait for clk_period;

        recv_signal.data(31 downto 0) <= "11000000000000010000000000000111"; -- start with a high value
		  recv_signal.data(16) <= '1';
        recv_signal.addr(7 downto 0) <= "00000000";

        wait for clk_period;

	

        recv_signal.data(31 downto 0) <= "11000000000000010000000000000010"; -- decrease value 
	recv_signal.data(16) <= '1';
        recv_signal.addr(7 downto 0) <= "00000000";

        wait for clk_period;

	
    
        recv_signal.data(31 downto 0) <= "11000000000000010000000000000011"; -- increase value again, trough should be detected here
		  recv_signal.data(16) <= '1';
        recv_signal.addr(7 downto 0) <= "00000000";
		  
		  wait for clk_period;


    
        recv_signal.data(31 downto 0) <= "11000000000000010000000000000111"; -- increase value 
		  recv_signal.data(16) <= '1';
        recv_signal.addr(7 downto 0) <= "00000000";
	

	
	wait for clk_period;
	wait for clk_period;
	wait for clk_period;


	
	wait for clk_period*10;
	

	

        wait for clk_period * 100;

        -- Final reset
        rst <= '1';
        wait;
    end process;

end architecture sim;

