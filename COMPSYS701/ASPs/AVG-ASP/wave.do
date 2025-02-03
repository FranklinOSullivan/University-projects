onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /avgaspwave_tb/clk
add wave -noupdate /avgaspwave_tb/rst
add wave -noupdate -expand /avgaspwave_tb/send
add wave -noupdate -expand /avgaspwave_tb/recv
add wave -noupdate /avgaspwave_tb/addr
add wave -noupdate -format Analog-Step -height 84 -max 65520.0 -min 624.0 -radix unsigned /avgaspwave_tb/input_data
add wave -noupdate -format Analog-Step -height 84 -max 57741.0 -radix unsigned /avgaspwave_tb/output_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {420000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {164064 ps}
