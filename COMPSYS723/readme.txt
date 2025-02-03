## Low Cost Frequency Relay (LCFR)

### Introduction:

This project is a low-cost frequency relay implemented on DE2-115 with Nios II.

Developed by Dylan Chamberlain, Franklin O’Sullivan, and Bailey Clague.

---

### Instructions:

**Software Requirements:**
- Quartus Prime (Standard or Lite) 18.1
- Eclipse development tools for Quartus Prime

**Hardware Requirements:**
- DE2-SoC Board
- DE2-SoC Power cable and adapter
- USB Blaster cable
- VGA Cable
- VGA to HDMI Adapter
- HDMI Cable
- PS-2 Keyboard
- Monitor with VGA connectivity

1. Connect the DE2-SoC board to your PC using the USB-Blaster cable. Ensure the board is powered on. The LED D1 should illuminate when the power button SW18 is pressed.

2. Download the provided assignment zip file and extract its contents into a suitable folder.

3. Open the Quartus Prime Programmer and select the "freq_relay_controller.sof" file from the "A1" folder. Ensure the programming switch SW19 is set to RUN, then click "Start".

4. If programming is successful, the programmer tool will display a green bar with "Success" in the top right corner.

5. Open Eclipse Development tools for Quartus Prime.

6. Select your desired workspace directory and click "OK".

7. Click on "File" > "Import".

8. In the popup, select "General" > "Existing Projects into Workspace" > "Next".

9. Navigate to the directory where the downloaded project files are located and click "Finish".

10. Right-click on the project BSP, navigate to Nios II, and click "Generate BSP".

11. Once the BSP generation is complete, clean and build the project by navigating to "Project" in the menu bar, then clicking "Clean" followed by "Build".

12. With the build complete, you are ready to run the software on the Nios II hardware. Right-click on the project in the left-hand column, then navigate to "Run As" > "Nios II hardware".

13. Upon successful execution, your DE2-SoC board and VGA should light up.

14. To enable a load at any time, use switches SW0 to SW6.

15. To enter maintenance mode, press push button KEY1.

16. The LCD and VGA should respond to the current state and operating mode.

17. To change the frequency compare value, use the keyboard and type "FXX" where XX is the two-digit frequency compare value (e.g., F07 for a compare value of 7Hz), then press enter.

18. To change the rate of change compare value, type "RXX" where XX is a two-digit number (e.g., R12 for a rate of change compare value of 12 Hz/s), then press enter to confirm the value.
