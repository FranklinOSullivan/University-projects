#!/bin/bash

# Create a work library
vlib work;

# Compile the source files
vcom -quiet "src/recop_types.vhd" &&
vcom -quiet "src/opcodes.vhd" &&
vcom -quiet "src/registerfile.vhd" &&
vcom -quiet "src/num_to_seven_seg.vhd" &&
vcom -quiet "src/ALU.vhd" &&
vcom -quiet "src/mem_io.vhd" &&
vcom -quiet "src/memory_arbiter.vhd" &&
vcom -quiet "src/data_mem.vhd" &&
vcom -quiet "src/prog_mem.vhd" &&
vcom -quiet "src/datapath.vhd" && 
vcom -quiet "src/control_unit.vhd" &&
vcom -quiet "src/recop_pll.vhd" &&
vcom -quiet "src/recop.vhd" &&
vcom -quiet -2008 "test/test_utils.vhd" && 
vcom -quiet -2008 "test/recop_tb.vhd" &&
vcom -quiet -2008 "test/control_unit/control_unit_tb.vhd" &&
vcom -quiet -2008 "test/datapath/datapath_tb.vhd" &&

# Simulate the control unit

if [[ "$*" == *"--gui"* ]]; then
    vsim -do 'vsim work.recop_tb; do wave.do;'
else
    echo "Control Unit Testbench" 
    vsim -c -do test/control_unit/run.do

    echo "Datapath Testbench" 
    vsim -c -do test/datapath/run.do
fi
vdel -all -lib work
