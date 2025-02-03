	component Nios_System_4 is
		port (
			clocks_ref_clk_clk                             : in  std_logic                     := 'X';             -- clk
			clocks_ref_reset_reset                         : in  std_logic                     := 'X';             -- reset
			clocks_sdram_clk_clk                           : out std_logic;                                        -- clk
			noc_input_external_connection_export           : in  std_logic_vector(31 downto 0) := (others => 'X'); -- export
			noc_output_external_connection_export          : out std_logic_vector(31 downto 0);                    -- export
			noc_input_interrupt_external_connection_export : in  std_logic                     := 'X';             -- export
			noc_output_addr_external_connection_export     : out std_logic_vector(7 downto 0)                      -- export
		);
	end component Nios_System_4;

	u0 : component Nios_System_4
		port map (
			clocks_ref_clk_clk                             => CONNECTED_TO_clocks_ref_clk_clk,                             --                          clocks_ref_clk.clk
			clocks_ref_reset_reset                         => CONNECTED_TO_clocks_ref_reset_reset,                         --                        clocks_ref_reset.reset
			clocks_sdram_clk_clk                           => CONNECTED_TO_clocks_sdram_clk_clk,                           --                        clocks_sdram_clk.clk
			noc_input_external_connection_export           => CONNECTED_TO_noc_input_external_connection_export,           --           noc_input_external_connection.export
			noc_output_external_connection_export          => CONNECTED_TO_noc_output_external_connection_export,          --          noc_output_external_connection.export
			noc_input_interrupt_external_connection_export => CONNECTED_TO_noc_input_interrupt_external_connection_export, -- noc_input_interrupt_external_connection.export
			noc_output_addr_external_connection_export     => CONNECTED_TO_noc_output_addr_external_connection_export      --     noc_output_addr_external_connection.export
		);

