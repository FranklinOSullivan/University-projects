
module Nios_V3 (
	button_pio_external_connection_export,
	clk_clk,
	led_pio_external_connection_export,
	reset_reset_n,
	seven_seg_0_external_connection_export,
	seven_seg_1_external_connection_export,
	seven_seg_2_external_connection_export,
	seven_seg_3_external_connection_export,
	switch_pio_external_connection_export);	

	input	[1:0]	button_pio_external_connection_export;
	input		clk_clk;
	output	[7:0]	led_pio_external_connection_export;
	input		reset_reset_n;
	output	[6:0]	seven_seg_0_external_connection_export;
	output	[6:0]	seven_seg_1_external_connection_export;
	output	[6:0]	seven_seg_2_external_connection_export;
	output	[6:0]	seven_seg_3_external_connection_export;
	input	[7:0]	switch_pio_external_connection_export;
endmodule
