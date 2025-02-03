quit -sim;
onerror {quit -f};
onbreak {quit -f};
vsim work.control_unit_tb;
run -all;