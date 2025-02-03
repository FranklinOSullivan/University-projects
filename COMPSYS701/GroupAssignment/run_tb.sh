#!/bin/bash

# Create the IP library
vlib ip;

# Compile the IP source files
vcom -work ip -quiet -2008 "src/ip/TdmaMinFifo/TdmaMinFifo.vhd" &&

# Create a work library
vlib work;

# Compile the source files
# Tdma Min
vcom -quiet -2008 "src/TdmaMin/TdmaMinTypes.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMinSwitch.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMinStage.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMinFabric.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMinSlots.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMinInterface.vhd" &&
vcom -quiet -2008 "src/TdmaMin/TdmaMin.vhd" &&

# ASPs
vcom -quiet -2008 "src/ASPs/adc_asp.vhd" &&
vcom -quiet -2008 "src/ASPs/avg_asp.vhd" &&
vcom -quiet -2008 "src/ASPs/cor_asp.vhd" &&
vcom -quiet -2008 "src/ASPs/pd_asp.vhd" &&

# Recop
vcom -quiet -2008 "src/ReCOP/recop_types.vhd" &&
vcom -quiet -2008 "src/ReCOP/opcodes.vhd" &&
vcom -quiet -2008 "src/ReCOP/registerfile.vhd" &&
vcom -quiet -2008 "src/ReCOP/num_to_seven_seg.vhd" &&
vcom -quiet -2008 "src/ReCOP/ALU.vhd" &&
vcom -quiet -2008 "src/ReCOP/mem_io.vhd" &&
vcom -quiet -2008 "src/ReCOP/memory_arbiter.vhd" &&
vcom -quiet -2008 "src/ReCOP/data_mem.vhd" &&
vcom -quiet -2008 "src/ReCOP/prog_mem.vhd" &&
vcom -quiet -2008 "src/ReCOP/datapath.vhd" && 
vcom -quiet -2008 "src/ReCOP/control_unit.vhd" &&
vcom -quiet -2008 "src/ReCOP/recop_pll.vhd" &&
vcom -quiet -2008 "src/ReCOP/recop.vhd" &&

# TdmaMin

# Testbenches
vcom -quiet -2008 "test/test_utils.vhd" && 
vcom -quiet -2008 "test/TdmaMin/TestTdmaMin.vhd" &&
vcom -quiet -2008 "test/TdmaMin/TestTdmaMinInterface.vhd" &&
vcom -quiet -2008 "test/ReCOP/recop_tb.vhd" &&
vcom -quiet -2008 "test/ReCOP/control_unit/control_unit_tb.vhd" &&
vcom -quiet -2008 "test/ReCOP/datapath/datapath_tb.vhd" &&
vcom -quiet -2008 "test/TestTopLevel.vhd" &&

# Simulate
vsim -do 'vsim work.TestTopLevel; do wave.do;'

vdel -all -lib work
vdel -all -lib ip
