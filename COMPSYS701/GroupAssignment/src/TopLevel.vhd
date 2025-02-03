library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.TdmaMinTypes.all;

entity TopLevel is
	generic (
		ports : positive := 8
	);
	port (
		CLOCK_50  : in std_logic;
		CLOCK2_50 : in std_logic;
		KEY       : in std_logic_vector(3 downto 0);
		SW        : in std_logic_vector(9 downto 0);
		LEDR      : out std_logic_vector(9 downto 0);
		HEX0      : out std_logic_vector(6 downto 0);
		HEX1      : out std_logic_vector(6 downto 0);
		HEX2      : out std_logic_vector(6 downto 0);
		HEX3      : out std_logic_vector(6 downto 0);
		HEX4      : out std_logic_vector(6 downto 0);
		HEX5      : out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of TopLevel is

	signal clock    : std_logic;
	signal clockTwo : std_logic;

	signal reset : std_logic;

	signal send_port : tdma_min_ports(0 to ports - 1);
	signal recv_port : tdma_min_ports(0 to ports - 1);

	signal nios_input_data  : std_logic_vector(31 downto 0);
	signal nios_input_valid : std_logic;

	signal nios_output_data : std_logic_vector(31 downto 0);

	signal last_data_vld : std_logic := '0';
begin
	clock    <= CLOCK_50;
	clockTwo <= CLOCK2_50;
	reset    <= not KEY(0);

	tdma_min : entity work.TdmaMin
		generic map(
			ports => ports
		)
		port map(
			clock => clock,
			sends => send_port,
			recvs => recv_port
		);

	nios_inst : entity work.Nios_System_4
		port map(

			clocks_ref_clk_clk     => clock,
			clocks_ref_reset_reset => reset,
			clocks_sdram_clk_clk   => clockTwo,

			noc_input_external_connection_export           => nios_input_data,
			noc_input_interrupt_external_connection_export => nios_input_valid,
			noc_output_external_connection_export          => nios_output_data,
			noc_output_addr_external_connection_export     => send_port(0).addr
		);

	nios_input : process (clock)
	begin
		if rising_edge(clock) then
			if (recv_port(0).data(31) = '1') then
				nios_input_data <= recv_port(0).data;
			end if;
			nios_input_valid <= recv_port(0).data(31);
		end if;
	end process;

	nios_output : process (clock)
	begin
		if rising_edge(clock) then
			if (nios_output_data(31) = '1' and last_data_vld = '0') then -- Data message
				send_port(0).data <= nios_output_data;
				last_data_vld     <= '1';
			elsif nios_output_data(31) = '0' then
				last_data_vld     <= '0';
				send_port(0).data <= (others => '0');
			else
				send_port(0).data <= (others => '0');
			end if;
		end if;
	end process;

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
			MAX_ADDRESS_WIDTH => 6
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
			INITAL_SEND_ADDR => x"0"
		)
		port map(
			clk   => clock,
			reset => reset,
			send  => send_port(5),
			recv  => recv_port(5)
		);
end architecture;