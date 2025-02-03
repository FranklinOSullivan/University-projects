create_clock -period 20.000ns [get_ports CLOCK_50]

derive_pll_clocks

# Constrain the input I/O path
set_input_delay -clock CLOCK_50 -max 3 [all_inputs]
set_input_delay -clock CLOCK_50 -min 2 [all_inputs]

# Constrain the output I/O path
set_output_delay -clock CLOCK_50 -max 2 [all_outputs]
