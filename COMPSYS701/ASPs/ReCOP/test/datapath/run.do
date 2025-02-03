quit -sim;
onerror {quit -f};
onbreak {quit -f};
vsim work.datapath_tb;
run -all;