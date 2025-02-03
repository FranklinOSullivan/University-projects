COMPSYS701: Individual Project - Peak Detection ASP 
Author: Bailey Clague bcla154 

Operating Instructions: 

1. Open pd_asp.qsf and compile in Quartus Prime 18.1
2. If testing open ModelSim by navigating to > tools >run simulation tools > RTL Simulation 
3. Compile all files in the src and test folder 
4. All test benched end in _tb
5. To perform a basic test run tb_pd_asp.vhd
6. Simulate this file and add waves to the wave viewer, run for 10 us.
7. Correlation Count signal will give you the correct correlation count for the inputted correlations. 
8. Edge will provide information on the current state, ie if current state is negative or positive edge 
9. Send and Recv packets can be displayed but will need to be decoded or compared to test bench inputs, however testing thus far has shown a match.
10. Send Flag should line up with the Peaks or Troughs depending on which mode you are in which is shown by the invert flag. 0 = peak 1 = trough.
11. Run the other two test benches to see responses to waves.
12. "Input" will need to be changed to unsigned and analog to see the wave as seen in the report.
13. Brief commenting is provided in test benching code 
Report should be found in .zip

Time spent on project 15 hours 






