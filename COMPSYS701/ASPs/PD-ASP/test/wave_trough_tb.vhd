library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.TdmaMinTypes.all;


entity wave_trough_tb is
end entity wave_trough_tb;

architecture sims of wave_trough_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal send_signal: tdma_min_port := (others => (others => '0'));
    signal recv_signal : tdma_min_port := (others => (others => '0'));
    signal wave_address: INTEGER RANGE 0 TO 6399 := 0;
	signal output : unsigned(15 downto 0) := (others => '0');
	signal input : unsigned(15 downto 0) := (others => '0');

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

	recv_signal.data   <= "1100000000000001" & std_logic_vector(input);
	output <= unsigned(send_signal.data(15 downto 0));

    -- DUT instantiation
    DUT : entity work.pd_asp
        port map (
            clock => clk,
            reset => rst,
            recv  => recv_signal,
            send  => send_signal
        );

    wave_inst : entity work.wave
            port map(
                clk => clk,
                address => wave_address,
                data_out => input
            );
	

    address : process
    begin
        wave_address <= (wave_address + 1) mod 1599;
        wait for clk_period;
    end process;

	

    -- Testbench process
    tb_process : process

	
    begin
	 
        -- Initial reset
        rst <= '1';
        wait for clk_period * 1;
        rst <= '0';
        wait for clk_period * 100000;
        -- Final reset
        rst <= '1';
        wait;
    end process;

end architecture sims;
