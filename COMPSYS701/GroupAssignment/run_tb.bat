@echo off

rem Create the IP library
vlib ip
if %ERRORLEVEL% neq 0 (
    echo Failed to create library.
    exit /b %ERRORLEVEL%
)

rem Compile the IP source files
vcom -work ip -quiet -2008 "src\ip\TdmaMinFifo\TdmaMinFifo.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem Create a work library
vlib work
if %ERRORLEVEL% neq 0 (
    echo Failed to create library.
    exit /b %ERRORLEVEL%
)

rem Compile the source files
rem Tdma Min
vcom -quiet -2008 "src\TdmaMin\TdmaMinTypes.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMinSwitch.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMinStage.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMinFabric.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMinSlots.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMinInterface.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\TdmaMin\TdmaMin.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem ASPs
vcom -quiet -2008 "src\ASPs\adc_asp.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ASPs\avg_asp.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ASPs\cor_asp.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ASPs\pd_asp.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem Recop
vcom -quiet -2008 "src\ReCOP\recop_types.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\opcodes.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\registerfile.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\num_to_seven_seg.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\ALU.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\mem_io.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\memory_arbiter.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\data_mem.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\prog_mem.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\datapath.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL% 
vcom -quiet -2008 "src\ReCOP\control_unit.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\recop_pll.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src\ReCOP\recop.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem Testbenches
vcom -quiet -2008 "test\test_utils.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL% 
vcom -quiet -2008 "test\TdmaMin\TestTdmaMin.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test\TdmaMin\TestTdmaMinInterface.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test\ReCOP\recop_tb.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test\ReCOP\control_unit\control_unit_tb.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test\ReCOP\datapath\datapath_tb.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test\TestTopLevel.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

rem Simulate
vsim -do "vsim work.TestTopLevel; do wave.do;"

vdel -all -lib work
vdel -all -lib ip
