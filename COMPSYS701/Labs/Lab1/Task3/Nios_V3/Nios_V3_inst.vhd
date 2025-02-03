	component Nios_V3 is
		port (
			button_pio_external_connection_export  : in  std_logic_vector(1 downto 0) := (others => 'X'); -- export
			clk_clk                                : in  std_logic                    := 'X';             -- clk
			led_pio_external_connection_export     : out std_logic_vector(7 downto 0);                    -- export
			reset_reset_n                          : in  std_logic                    := 'X';             -- reset_n
			seven_seg_0_external_connection_export : out std_logic_vector(6 downto 0);                    -- export
			seven_seg_1_external_connection_export : out std_logic_vector(6 downto 0);                    -- export
			seven_seg_2_external_connection_export : out std_logic_vector(6 downto 0);                    -- export
			seven_seg_3_external_connection_export : out std_logic_vector(6 downto 0);                    -- export
			switch_pio_external_connection_export  : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component Nios_V3;

	u0 : component Nios_V3
		port map (
			button_pio_external_connection_export  => CONNECTED_TO_button_pio_external_connection_export,  --  button_pio_external_connection.export
			clk_clk                                => CONNECTED_TO_clk_clk,                                --                             clk.clk
			led_pio_external_connection_export     => CONNECTED_TO_led_pio_external_connection_export,     --     led_pio_external_connection.export
			reset_reset_n                          => CONNECTED_TO_reset_reset_n,                          --                           reset.reset_n
			seven_seg_0_external_connection_export => CONNECTED_TO_seven_seg_0_external_connection_export, -- seven_seg_0_external_connection.export
			seven_seg_1_external_connection_export => CONNECTED_TO_seven_seg_1_external_connection_export, -- seven_seg_1_external_connection.export
			seven_seg_2_external_connection_export => CONNECTED_TO_seven_seg_2_external_connection_export, -- seven_seg_2_external_connection.export
			seven_seg_3_external_connection_export => CONNECTED_TO_seven_seg_3_external_connection_export, -- seven_seg_3_external_connection.export
			switch_pio_external_connection_export  => CONNECTED_TO_switch_pio_external_connection_export   --  switch_pio_external_connection.export
		);

