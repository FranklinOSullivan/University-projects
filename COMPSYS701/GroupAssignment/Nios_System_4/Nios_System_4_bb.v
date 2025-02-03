
module Nios_System_4 (
	clocks_ref_clk_clk,
	clocks_ref_reset_reset,
	clocks_sdram_clk_clk,
	noc_input_external_connection_export,
	noc_output_external_connection_export,
	noc_input_interrupt_external_connection_export,
	noc_output_addr_external_connection_export);	

	input		clocks_ref_clk_clk;
	input		clocks_ref_reset_reset;
	output		clocks_sdram_clk_clk;
	input	[31:0]	noc_input_external_connection_export;
	output	[31:0]	noc_output_external_connection_export;
	input		noc_input_interrupt_external_connection_export;
	output	[7:0]	noc_output_addr_external_connection_export;
endmodule
