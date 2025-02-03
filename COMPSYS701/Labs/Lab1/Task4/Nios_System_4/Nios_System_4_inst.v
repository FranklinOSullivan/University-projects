	Nios_System_4 u0 (
		.button_pio_external_connection_export  (<connected-to-button_pio_external_connection_export>),  //  button_pio_external_connection.export
		.clocks_ref_clk_clk                     (<connected-to-clocks_ref_clk_clk>),                     //                  clocks_ref_clk.clk
		.clocks_ref_reset_reset                 (<connected-to-clocks_ref_reset_reset>),                 //                clocks_ref_reset.reset
		.clocks_sdram_clk_clk                   (<connected-to-clocks_sdram_clk_clk>),                   //                clocks_sdram_clk.clk
		.led_pio_external_connection_export     (<connected-to-led_pio_external_connection_export>),     //     led_pio_external_connection.export
		.sdram_wire_addr                        (<connected-to-sdram_wire_addr>),                        //                      sdram_wire.addr
		.sdram_wire_ba                          (<connected-to-sdram_wire_ba>),                          //                                .ba
		.sdram_wire_cas_n                       (<connected-to-sdram_wire_cas_n>),                       //                                .cas_n
		.sdram_wire_cke                         (<connected-to-sdram_wire_cke>),                         //                                .cke
		.sdram_wire_cs_n                        (<connected-to-sdram_wire_cs_n>),                        //                                .cs_n
		.sdram_wire_dq                          (<connected-to-sdram_wire_dq>),                          //                                .dq
		.sdram_wire_dqm                         (<connected-to-sdram_wire_dqm>),                         //                                .dqm
		.sdram_wire_ras_n                       (<connected-to-sdram_wire_ras_n>),                       //                                .ras_n
		.sdram_wire_we_n                        (<connected-to-sdram_wire_we_n>),                        //                                .we_n
		.seven_seg_0_external_connection_export (<connected-to-seven_seg_0_external_connection_export>), // seven_seg_0_external_connection.export
		.seven_seg_1_external_connection_export (<connected-to-seven_seg_1_external_connection_export>), // seven_seg_1_external_connection.export
		.seven_seg_2_external_connection_export (<connected-to-seven_seg_2_external_connection_export>), // seven_seg_2_external_connection.export
		.seven_seg_3_external_connection_export (<connected-to-seven_seg_3_external_connection_export>), // seven_seg_3_external_connection.export
		.switch_pio_external_connection_export  (<connected-to-switch_pio_external_connection_export>),  //  switch_pio_external_connection.export
		.noc_output_external_connection_export  (<connected-to-noc_output_external_connection_export>),  //  noc_output_external_connection.export
		.noc_input_external_connection_export   (<connected-to-noc_input_external_connection_export>)    //   noc_input_external_connection.export
	);

