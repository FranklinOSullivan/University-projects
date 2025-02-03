<h1>ADC-ASP Testing Instructions </h1>
1. Open "ModelSim - Intel FPGA Started Edition 10.5 b"<br>
2. Click "File" and select "Change Directory ..."<br>
3. Select the parent folder "ADC-ASP"<br>
4. Click "Compile", "Compile ..." and compile each of these files in order:<br>

1. "TdmaMin/TdmaMinTypes.vhd"
2. "constants.vhd"
3. "adcasp.vhd"
4. "test_adcasp.vhd" <br>

If prompted to create a library "work" click "Yes"<br>
5. Click "Simulate", "Start Simulation ..." <br>
6. Expand "work" and select "testadc", leaving resolution as "default", then click "Ok"<br>
7. Add any waves desired and simulate the wave for a period of 100 ms.
