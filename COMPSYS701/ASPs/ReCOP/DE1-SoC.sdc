create_clock -period 20.000ns [get_ports CLOCK_50]

derive_pll_clocks
derive_clock_uncertainty
