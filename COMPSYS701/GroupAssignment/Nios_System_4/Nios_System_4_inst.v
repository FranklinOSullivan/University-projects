	Nios_System_4 u0 (
		.clocks_ref_clk_clk                             (<connected-to-clocks_ref_clk_clk>),                             //                          clocks_ref_clk.clk
		.clocks_ref_reset_reset                         (<connected-to-clocks_ref_reset_reset>),                         //                        clocks_ref_reset.reset
		.clocks_sdram_clk_clk                           (<connected-to-clocks_sdram_clk_clk>),                           //                        clocks_sdram_clk.clk
		.noc_input_external_connection_export           (<connected-to-noc_input_external_connection_export>),           //           noc_input_external_connection.export
		.noc_output_external_connection_export          (<connected-to-noc_output_external_connection_export>),          //          noc_output_external_connection.export
		.noc_input_interrupt_external_connection_export (<connected-to-noc_input_interrupt_external_connection_export>), // noc_input_interrupt_external_connection.export
		.noc_output_addr_external_connection_export     (<connected-to-noc_output_addr_external_connection_export>)      //     noc_output_addr_external_connection.export
	);

