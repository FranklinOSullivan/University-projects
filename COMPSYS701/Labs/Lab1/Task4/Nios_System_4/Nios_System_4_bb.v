
module Nios_System_4 (
	button_pio_external_connection_export,
	clocks_ref_clk_clk,
	clocks_ref_reset_reset,
	clocks_sdram_clk_clk,
	led_pio_external_connection_export,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	seven_seg_0_external_connection_export,
	seven_seg_1_external_connection_export,
	seven_seg_2_external_connection_export,
	seven_seg_3_external_connection_export,
	switch_pio_external_connection_export,
	noc_output_external_connection_export,
	noc_input_external_connection_export);	

	input	[1:0]	button_pio_external_connection_export;
	input		clocks_ref_clk_clk;
	input		clocks_ref_reset_reset;
	output		clocks_sdram_clk_clk;
	output	[7:0]	led_pio_external_connection_export;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output	[6:0]	seven_seg_0_external_connection_export;
	output	[6:0]	seven_seg_1_external_connection_export;
	output	[6:0]	seven_seg_2_external_connection_export;
	output	[6:0]	seven_seg_3_external_connection_export;
	input	[7:0]	switch_pio_external_connection_export;
	output	[31:0]	noc_output_external_connection_export;
	input	[31:0]	noc_input_external_connection_export;
endmodule
