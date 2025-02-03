library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.TdmaMinTypes.all;

entity TopLevel is
	generic (
		ports : positive := 5
	);
	port (
		CLOCK_50      : in    std_logic;
		CLOCK2_50     : in    std_logic;
		CLOCK3_50     : in    std_logic;

		FPGA_I2C_SCLK : out   std_logic;
		FPGA_I2C_SDAT : inout std_logic;
		AUD_ADCDAT    : in    std_logic;
		AUD_ADCLRCK   : inout std_logic;
		AUD_BCLK      : inout std_logic;
		AUD_DACDAT    : out   std_logic;
		AUD_DACLRCK   : inout std_logic;
		AUD_XCK       : out   std_logic;

		KEY           : in    std_logic_vector(3 downto 0);
		SW            : in    std_logic_vector(9 downto 0);
		LEDR          : out   std_logic_vector(9 downto 0);
		HEX0          : out   std_logic_vector(6 downto 0);
		HEX1          : out   std_logic_vector(6 downto 0);
		HEX2          : out   std_logic_vector(6 downto 0);
		HEX3          : out   std_logic_vector(6 downto 0);
		HEX4          : out   std_logic_vector(6 downto 0);
		HEX5          : out   std_logic_vector(6 downto 0);
		
		button_pio_external_connection_export  : in    std_logic_vector(1 downto 0)  := (others => '0'); --  button_pio_external_connection.export
		clocks_ref_clk_clk                     : in    std_logic                     := '0';             --                  clocks_ref_clk.clk
		clocks_ref_reset_reset                 : in    std_logic                     := '0';             --                clocks_ref_reset.reset
		clocks_sdram_clk_clk                   : out   std_logic;                                        --                clocks_sdram_clk.clk
		led_pio_external_connection_export     : out   std_logic_vector(7 downto 0);                     --     led_pio_external_connection.export
		noc_input_external_connection_export   : in    std_logic_vector(31 downto 0) := (others => '0'); --   noc_input_external_connection.export
		noc_output_external_connection_export  : out   std_logic_vector(31 downto 0);                    --  noc_output_external_connection.export
		sdram_wire_addr                        : out   std_logic_vector(12 downto 0);                    --                      sdram_wire.addr
		sdram_wire_ba                          : out   std_logic_vector(1 downto 0);                     --                                .ba
		sdram_wire_cas_n                       : out   std_logic;                                        --                                .cas_n
		sdram_wire_cke                         : out   std_logic;                                        --                                .cke
		sdram_wire_cs_n                        : out   std_logic;                                        --                                .cs_n
		sdram_wire_dq                          : inout std_logic_vector(15 downto 0) := (others => '0'); --                                .dq
		sdram_wire_dqm                         : out   std_logic_vector(1 downto 0);                     --                                .dqm
		sdram_wire_ras_n                       : out   std_logic;                                        --                                .ras_n
		sdram_wire_we_n                        : out   std_logic;                                        --                                .we_n
		seven_seg_0_external_connection_export : out   std_logic_vector(6 downto 0);                     -- seven_seg_0_external_connection.export
		seven_seg_1_external_connection_export : out   std_logic_vector(6 downto 0);                     -- seven_seg_1_external_connection.export
		seven_seg_2_external_connection_export : out   std_logic_vector(6 downto 0);                     -- seven_seg_2_external_connection.export
		seven_seg_3_external_connection_export : out   std_logic_vector(6 downto 0);                     -- seven_seg_3_external_connection.export
		switch_pio_external_connection_export  : in    std_logic_vector(7 downto 0)  := (others => '0')  --  switch_pio_external_connection.export
		
	);
end entity;

architecture rtl of TopLevel is

	signal clock : std_logic;
	signal sdclk : std_logic;

	signal adc_empty : std_logic;
	signal adc_get   : std_logic;
	signal adc_data  : std_logic_vector(16 downto 0);
	signal dac_full  : std_logic;
	signal dac_put   : std_logic;
	signal dac_data  : std_logic_vector(16 downto 0);

	signal send_port : tdma_min_ports(0 to ports-1);
	signal recv_port : tdma_min_ports(0 to ports-1);

begin

	clock <= CLOCK_50;
	sdclk <= CLOCK_50;

	adc_dac : entity work.Audio
	generic map (
		enable_adc => false
	)
	port map (
		ref_clock     => CLOCK3_50,
		fpga_i2c_sclk => FPGA_I2C_SCLK,
		fpga_i2c_sdat => FPGA_I2C_SDAT,
		aud_adcdat    => AUD_ADCDAT,
		aud_adclrck   => AUD_ADCLRCK,
		aud_bclk      => AUD_BCLK,
		aud_dacdat    => AUD_DACDAT,
		aud_daclrck   => AUD_DACLRCK,
		aud_xck       => AUD_XCK,

		clock         => clock,
		adc_empty     => adc_empty,
		adc_get       => adc_get,
		adc_data      => adc_data,
		dac_full      => dac_full,
		dac_put       => dac_put,
		dac_data      => dac_data
	);

	tdma_min : entity work.TdmaMin
	generic map (
		ports => ports
	)
	port map (
		clock => clock,
		sends => send_port,
		recvs => recv_port
	);

	asp_adc : entity work.AspAdc
	port map (
		clock => clock,
		empty => adc_empty,
		get   => adc_get,
		data  => adc_data,

		send  => send_port(0),
		recv  => recv_port(0)
	);

	asp_dac : entity work.AspDac
	port map (
		clock => clock,
		full  => dac_full,
		put   => dac_put,
		data  => dac_data,

		send  => send_port(1),
		recv  => recv_port(1)
	);
	
	-- asp_example : entity work.AspExample
	-- port map (
	-- 	clock => clock,
	-- 	key   => KEY,
	-- 	sw    => SW,
	-- 	ledr  => LEDR,
	-- 	hex0  => HEX0,
	-- 	hex1  => HEX1,
	-- 	hex2  => HEX2,
	-- 	hex3  => HEX3,
	-- 	hex4  => HEX4,
	-- 	hex5  => HEX5,

	-- 	send  => send_port(2),
	-- 	recv  => recv_port(2)
	-- );

	asp_e : entity work.dpasp
	port map (
		clock => clock,

		send  => send_port(3),
		recv  => recv_port(3)
	);
	
	nios_ii : entity work.Nios_System_4
	port map (		
		button_pio_external_connection_export => button_pio_external_connection_export, --  button_pio_external_connection.export
		clocks_ref_clk_clk => clock,             --                  clocks_ref_clk.clk
		clocks_ref_reset_reset => '0',             --                clocks_ref_reset.reset
		clocks_sdram_clk_clk => sdclk,                                        --                clocks_sdram_clk.clk
		led_pio_external_connection_export => led_pio_external_connection_export,                     --     led_pio_external_connection.export
		noc_input_external_connection_export => noc_input_external_connection_export, --   noc_input_external_connection.export
		noc_output_external_connection_export => noc_output_external_connection_export,                    --  noc_output_external_connection.export
		sdram_wire_addr => sdram_wire_addr,                    --                      sdram_wire.addr
		sdram_wire_ba => sdram_wire_ba,                     --                                .ba
		sdram_wire_cas_n => sdram_wire_cas_n,                                        --                                .cas_n
		sdram_wire_cke => sdram_wire_cke,                                        --                                .cke
		sdram_wire_cs_n => sdram_wire_cs_n,                                        --                                .cs_n
		sdram_wire_dq => sdram_wire_dq, --                                .dq
		sdram_wire_dqm => sdram_wire_dqm,                     --                                .dqm
		sdram_wire_ras_n => sdram_wire_ras_n,                                        --                                .ras_n
		sdram_wire_we_n => sdram_wire_we_n,                                        --                                .we_n
		seven_seg_0_external_connection_export => seven_seg_0_external_connection_export,                     -- seven_seg_0_external_connection.export
		seven_seg_1_external_connection_export => seven_seg_1_external_connection_export,                     -- seven_seg_1_external_connection.export
		seven_seg_2_external_connection_export => seven_seg_2_external_connection_export,                     -- seven_seg_2_external_connection.export
		seven_seg_3_external_connection_export => seven_seg_3_external_connection_export,                     -- seven_seg_3_external_connection.export
		switch_pio_external_connection_export => switch_pio_external_connection_export,  --  switch_pio_external_connection.export
		
		send  => send_port(2),
		recv  => recv_port(2)
	);


end architecture;
