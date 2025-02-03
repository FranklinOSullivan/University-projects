@echo off

REM Create a work library
vlib work
if %ERRORLEVEL% neq 0 (
    echo Failed to create library.
    exit /b %ERRORLEVEL%
)

REM Compile the source files
vcom -quiet -2008 "src/TdmaMinTypes.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "src/AvgAsp.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test/test_utils.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test/power_signal_rom.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL% 
vcom -quiet -2008 "test/AvgAspWave_tb.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
vcom -quiet -2008 "test/AvgAsp/AvgAsp_tb.vhd"
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

REM Simulate the control unit

set "ARGS=%*"

if "%ARGS%"=="--gui" (
    vsim -do "vsim work.AvgAsp_tb; do wave.do;"
) else (
    vsim -c -do test/AvgAsp/run.do
)
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%

vdel -all -lib work