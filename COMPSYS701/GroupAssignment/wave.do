onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testtoplevel/clock
add wave -noupdate /testtoplevel/send_port
add wave -noupdate /testtoplevel/recv_port
add wave -noupdate -divider I/O
add wave -noupdate -radix hexadecimal /testtoplevel/recop/mem_io/switches
add wave -noupdate -radix hexadecimal /testtoplevel/recop/mem_io/ledr
add wave -noupdate /testtoplevel/recop/mem_io/hex0_reg
add wave -noupdate /testtoplevel/recop/mem_io/hex1_reg
add wave -noupdate /testtoplevel/recop/mem_io/hex2_reg
add wave -noupdate /testtoplevel/recop/mem_io/hex3_reg
add wave -noupdate /testtoplevel/recop/mem_io/hex4_reg
add wave -noupdate /testtoplevel/recop/mem_io/hex5_reg
add wave -noupdate -divider Waves
add wave -noupdate -format Analog-Step -height 84 -max 3952.0 -radix unsigned /testtoplevel/adc_data
add wave -noupdate -format Analog-Step -height 84 -max 3858.0 -radix unsigned /testtoplevel/avg_data
add wave -noupdate -format Analog-Step -height 72 -max 29013.000000000004 -radix unsigned /testtoplevel/cor_data
add wave -noupdate /testtoplevel/asp_pd/edge
add wave -noupdate -divider ADC-ASP
add wave -noupdate /testtoplevel/asp_adc/currentData
add wave -noupdate -expand /testtoplevel/asp_adc/send
add wave -noupdate /testtoplevel/asp_adc/recv
add wave -noupdate -divider AVG-ASP
add wave -noupdate /testtoplevel/asp_avg/buf
add wave -noupdate /testtoplevel/asp_avg/send
add wave -noupdate -expand /testtoplevel/asp_avg/recv
add wave -noupdate -divider COR-ASP
add wave -noupdate -expand /testtoplevel/asp_cor/send
add wave -noupdate -childformat {{/testtoplevel/asp_cor/recv.data -radix hexadecimal}} -expand -subitemconfig {/testtoplevel/asp_cor/recv.data {-height 16 -radix hexadecimal}} /testtoplevel/asp_cor/recv
add wave -noupdate -divider PD-ASP
add wave -noupdate /testtoplevel/asp_pd/invert_signal
add wave -noupdate /testtoplevel/asp_pd/edge
add wave -noupdate /testtoplevel/asp_pd/correlation_count_signal
add wave -noupdate /testtoplevel/asp_pd/send
add wave -noupdate /testtoplevel/asp_pd/recv
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4990573293 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 253
configure wave -valuecolwidth 231
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {11483098022 ps}
