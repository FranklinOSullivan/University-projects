library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.TdmaMinTypes.all;

entity TestTopLevel is
	generic (
		ports : positive := 8
	);
end entity;

architecture sim of TestTopLevel is

	signal clock     : std_logic := '1';
	signal reset     : std_logic := '1';
	signal send_port : tdma_min_ports(0 to ports - 1);
	signal recv_port : tdma_min_ports(0 to ports - 1);

	signal adc_data : unsigned(15 downto 0) := (others => '0');
	signal avg_data : unsigned(15 downto 0) := (others => '0');
	signal cor_data : unsigned(15 downto 0) := (others => '0');

	signal hex0 : std_logic_vector(6 downto 0);
	signal hex1 : std_logic_vector(6 downto 0);
	signal hex2 : std_logic_vector(6 downto 0);
	signal hex3 : std_logic_vector(6 downto 0);
	signal hex4 : std_logic_vector(6 downto 0);
	signal hex5 : std_logic_vector(6 downto 0);

	signal sw   : std_logic_vector(9 downto 0) := (others => '0');
	signal ledr : std_logic_vector(9 downto 0);

begin

	clock <= not clock after 10 ns;

	tdma_min : entity work.TdmaMin
		generic map(
			ports => ports
		)
		port map(
			clock => clock,
			sends => send_port,
			recvs => recv_port
		);

	recop : entity work.recop
		generic map(
			pmem_init_file => "./code/bin/noc.mif"
		)
		port map(
			clock => clock,
			reset => reset,
			sw    => sw,
			ledr  => ledr,
			hex0  => hex0,
			hex1  => hex1,
			hex2  => hex2,
			hex3  => hex3,
			hex4  => hex4,
			hex5  => hex5,
			send  => send_port(1).data,
			recv  => recv_port(1).data
		);
	send_port(1).addr <= x"0" & send_port(1).data(27 downto 24);

	asp_adc : entity work.AdcAsp
		generic map(
			INITAL_SEND_ADDR => x"3"
		)
		port map(
			clk   => clock,
			reset => reset,
			send  => send_port(2),
			recv  => recv_port(2)
		);

	asp_avg : entity work.AvgAsp
		generic map(
			INITAL_SEND_ADDR  => x"4",
			MAX_ADDRESS_WIDTH => 5
		)
		port map(
			clk   => clock,
			reset => reset,
			send  => send_port(3),
			recv  => recv_port(3)
		);

	asp_cor : entity work.CorAsp
		generic map(
			INITAL_SEND_ADDR => x"5"
		)
		port map(
			clk   => clock,
			reset => reset,
			send  => send_port(4),
			recv  => recv_port(4)
		);

	asp_pd : entity work.PdAsp
		generic map(
			INITAL_SEND_ADDR => x"1"
		)
		port map(
			clk   => clock,
			reset => reset,
			send  => send_port(5),
			recv  => recv_port(5)
		);

	waves : process (clock)
	begin
		if rising_edge(clock) then

			if send_port(2).data(31) = '1' then
				adc_data <= unsigned(send_port(2).data(15 downto 0));
			end if;

			if send_port(3).data(31) = '1' then
				avg_data <= unsigned(send_port(3).data(15 downto 0));
			end if;

			if send_port(4).data(31) = '1' then
				cor_data <= unsigned(send_port(4).data(15 downto 0));
			end if;
		end if;

	end process;

	SEQUENCER_PROC : process
	begin
		wait for 20 ns;

		reset <= '0';

	end process;

end architecture;