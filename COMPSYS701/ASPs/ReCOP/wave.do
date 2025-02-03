onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /recop_tb/DUT/datapath_inst/clk
add wave -noupdate /recop_tb/DUT/datapath_inst/reset
add wave -noupdate -divider I/O
add wave -noupdate /recop_tb/sw
add wave -noupdate /recop_tb/ledr
add wave -noupdate /recop_tb/hex0
add wave -noupdate /recop_tb/hex1
add wave -noupdate /recop_tb/hex2
add wave -noupdate /recop_tb/hex3
add wave -noupdate -divider {Instruction Fetch}
add wave -noupdate /recop_tb/DUT/datapath_inst/pc
add wave -noupdate -radix hexadecimal /recop_tb/DUT/pmem_data
add wave -noupdate -divider Branching
add wave -noupdate -radix binary /recop_tb/DUT/datapath_inst/next_pc
add wave -noupdate -radix binary /recop_tb/DUT/datapath_inst/reg_x
add wave -noupdate -radix binary /recop_tb/DUT/datapath_inst/operand
add wave -noupdate /recop_tb/DUT/datapath_inst/pc_src
add wave -noupdate /recop_tb/DUT/datapath_inst/pc_write
add wave -noupdate /recop_tb/DUT/control_unit_inst/jump
add wave -noupdate /recop_tb/DUT/control_unit_inst/branch
add wave -noupdate /recop_tb/DUT/control_unit_inst/is_branching
add wave -noupdate /recop_tb/DUT/datapath_inst/is_equal
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/eq_op_a
add wave -noupdate /recop_tb/DUT/datapath_inst/id_fwd_src_a
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/eq_op_b
add wave -noupdate /recop_tb/DUT/datapath_inst/id_fwd_src_b
add wave -noupdate -divider {Instruction Decode}
add wave -noupdate -radix hexadecimal /recop_tb/DUT/datapath_inst/instruction
add wave -noupdate /recop_tb/DUT/control_unit_inst/am
add wave -noupdate /recop_tb/DUT/control_unit_inst/opcode
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/r_addr_z
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/r_addr_x
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/r_addr_y
add wave -noupdate -radix binary /recop_tb/DUT/datapath_inst/operand
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/registerfile_inst/registers
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/reg_x
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/reg_z
add wave -noupdate -divider Execution
add wave -noupdate /recop_tb/DUT/datapath_inst/alu_op
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/operand_a
add wave -noupdate /recop_tb/DUT/datapath_inst/ex_fwd_src_a
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/operand_b
add wave -noupdate /recop_tb/DUT/datapath_inst/ex_fwd_src_b
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/operand_b_temp
add wave -noupdate /recop_tb/DUT/datapath_inst/alu_src
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/alu_result
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/dst_reg
add wave -noupdate -divider Memory
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/ex_mem_alu_result
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/ex_mem_wr_data_addr
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/ex_mem_dst_reg
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/dmem_data
add wave -noupdate -divider Writeback
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/reg_wr_data
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/mem_wb_alu_result
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/mem_wb_rd_data
add wave -noupdate -radix unsigned /recop_tb/DUT/datapath_inst/mem_wb_dst_reg
add wave -noupdate /recop_tb/DUT/datapath_inst/reg_write
add wave -noupdate -divider Other
add wave -noupdate /recop_tb/DUT/mem_io/datacall
add wave -noupdate /recop_tb/DUT/mem_io/pop
add wave -noupdate -radix hexadecimal /recop_tb/DUT/mem_io/to_noc
add wave -noupdate -radix hexadecimal /recop_tb/DUT/mem_io/from_noc
add wave -noupdate -radix hexadecimal /recop_tb/DUT/mem_io/to_noc_reg
add wave -noupdate -radix hexadecimal /recop_tb/DUT/mem_io/from_noc_mem
add wave -noupdate /recop_tb/DUT/mem_io/index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2020000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 427
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1982116 ps} {2060700 ps}
