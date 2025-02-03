quit -sim;
onerror {quit -f};
onbreak {quit -f};
vsim work.AvgAsp_tb;
run -all;