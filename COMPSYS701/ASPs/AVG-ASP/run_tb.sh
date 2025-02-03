#!/bin/bash

# Create a work library
vlib work;

# Compile the source files
vcom -quiet -2008 "src/TdmaMinTypes.vhd" &&
vcom -quiet -2008 "src/AvgAsp.vhd" &&
vcom -quiet -2008 "test/test_utils.vhd" && 
vcom -quiet -2008 "test/power_signal_rom.vhd" && 
vcom -quiet -2008 "test/AvgAspWave_tb.vhd" &&
vcom -quiet -2008 "test/AvgAsp/AvgAsp_tb.vhd" &&

# Simulate the control unit

if [[ "$*" == *"--gui"* ]]; then
    vsim -do 'vsim work.AvgAspWave_tb; do wave.do;'
else
    vsim -c -do test/AvgAsp/run.do
fi
vdel -all -lib work
