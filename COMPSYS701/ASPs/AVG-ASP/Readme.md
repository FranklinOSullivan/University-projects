# AVG-ASP
A Linear Filter Application Specific Processor by **Dylan Chamberlain**

## How to Use

This document provides instructions for simulating the AVG-ASP processor on both Linux and Windows environments.

### Simulation Instructions

#### For Linux Users
1. **Assertion Test Bench**
   - Execute `./run_tb.sh` in the terminal to run the assertion test bench, verifying that the AVG-ASP functions as intended.
2. **Graphical Test Bench**
   - Run `./run_tb.sh --gui` to launch `AvgAspWave_tb` in ModelSim with pre-configured waveforms for analysis of linear filtering effects.

#### For Windows Users
1. **Assertion Test Bench**
   - Run `./run_tb.bat` in the command line to execute the assertion test bench, verifying that the AVG-ASP functions as intended.
2. **Graphical Test Bench**
   - Run `./run_tb.bat --gui` to launch `AvgAspWave_tb` in ModelSim with pre-configured waveforms for analysis of linear filtering effects.

### Compilation and Further Simulation

1. Compile all files located in the `./src` directory. This can be done either through the Quartus project or by manually adding all the files to a ModelSim work library.
2. Add the test benches to the work library and compile them.
   - Use `AvgAsp_tb` to run the assertion test benches.
   - Simulate `AvgAspWave_tb` and execute `do wave.do` in the ModelSim command line to view the waveforms.
