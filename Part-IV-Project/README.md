# Part-IV Project

**Title**: Can HLS Effectively Target Several Small Devices (FPGAs) for Use in Satellites?

This project explores the viability of High-Level Synthesis (HLS) to target and optimize multiple small FPGA devices, particularly for satellite applications. The aim is to deploy and test computationally intensive algorithms on an FPGA using Quartus Prime and OpenCL.

---

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [Quartus Prime and OpenCL SDK](#quartus-prime-and-opencl-sdk)
  - [DE1-SoC Board Setup](#de1-soc-board-setup)
  - [Cloning the Repository](#cloning-the-repository)
- [Desktop Implementation](#desktop-implementation)
- [DE1-SoC Implementation](#de1-soc-implementation)
- [Communication between Desktop and FPGA](#communication-between-desktop-and-fpga)

---

## Introduction

This project investigates the feasibility of using High-Level Synthesis (HLS) to effectively target multiple small FPGA devices for satellite use. The focus is on implementing and optimizing algorithms such as FFT (Fast Fourier Transform) using OpenCL and deploying the solution to the Terasic DE1-SoC FPGA board. Both a desktop and FPGA implementation are presented.

---

## Prerequisites

- **Operating System**: Kubuntu 22.04.4 LTS (x86_64)
- **Hardware**: DE1-SoC FPGA board from Terasic
- **Software**: 
  - Quartus Prime Standard Edition 18.1 (with OpenCL SDK and Intel SoC EDS)
  - CMake
  - FFTW3 library (Fast Fourier Transform)

Ensure you have these installed and correctly configured before proceeding.

---

## Setup

### Quartus Prime and OpenCL SDK

1. Install [Quartus Prime Standard Edition 18.1](https://www.intel.com/content/www/us/en/software-kit/665986/intel-quartus-prime-standard-edition-design-software-version-18-1-for-linux.html) for Linux.
   - During installation, ensure the following components are selected:
     - OpenCL SDK
     - Intel SoC EDS

### DE1-SoC Board Setup
1. Download the following from [Terasic DE1-SoC Page](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=165&No=836&PartNo=4#contents):
   - DE1-SoC OpenCL BSP
   - DE1-SoC OpenCL User Manual
   - Linux Ubuntu Desktop image for Quartus 18.1
2. Follow the setup instructions from the DE1-SoC OpenCL User Manual. 
   - When prompted to program an image onto the FPGA, use the Linux Ubuntu Desktop image instead of the default.
   
### Cloning the Repository

```bash
git clone <repository_url>
cd Part-IV-Project
```

## Desktop Implementation
### 1. Install Required Libraries

Make sure cmake and other required libraries are installed. Use apt to install any missing packages:

```bash
sudo apt install cmake build-essential
```

### 2. Compile FFTW3 Library

Manually compile the FFTW3 library using CMake:

```bash
wget http://www.fftw.org/fftw-3.3.10.tar.gz
tar -xzf fftw-3.3.10.tar.gz
cd fftw-3.3.10

mkdir build
cd build
cmake .. -DENABLE_THREADS=OFF -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=/usr/local
make
sudo make install
```

### 3. Build Range Doppler Application

Navigate to the `range_doppler_cmake` directory:

```bash
cd ./range_doppler_cmake
```
Create a build directory and compile the code:

```bash
mkdir build
cd build
cmake ..
make
```

## DE1-SoC Implementation
### 1. Cross-Compile FFTW3 Library

Cross-compile the FFTW3 library using the ARM compiler:

```bash
wget http://www.fftw.org/fftw-3.3.10.tar.gz
tar -xzvf fftw-3.3.10.tar.gz
cd fftw-3.3.10

/home/user/intelFPGA/18.1/embedded/embedded_command_shell.sh
./configure --host=arm-linux-gnueabihf --prefix=/opt/arm/fftw
make
make install
```

### 2. Build the Program
Navigate to the `range_doppler` directory:

```bash
cd ./range_doppler/
```

Run the build script to compile the program for the DE1-SoC FPGA. Use the necessary flags to compile the wanted implementation:

#### Arm Sequential
```bash
./build.sh
```

#### N-Dimensional Range kernel
```bash
./build.sh NDR
```

#### Single Work-Item kernel
```bash
./build.sh SWI
``` 

### 3. Building OpenCL kernel for DE1-SoC

Use the provided command to build the kernel. *Note: this may take a while*: 

```bash
./build_kernel.sh <kernel_name>
```

### 3. Transmit the Program to the FPGA

Use the provided transmit.sh script to send the compiled program to the FPGA board:

```bash
./transmit.sh <kernel_name>
```

### 4. SSH into the FPGA

Once the program is transmitted, SSH into the FPGA:

```bash
ssh <fpga_ip_address>
```

### 5. Initialize OpenCL

Source the OpenCL initialization script on the FPGA:

```bash
source ./init_opencl_17_1.sh
```

### 6. Run the Program

Change to the range_doppler directory and execute the program:

```bash
cd range_doppler
aocl program range_doppler_kernel.aocx
./host
```

## Communication between Desktop and FPGA

To enable communication between the desktop and FPGA, ensure you have set up a LAN connection between them. You can use SSH to communicate securely with the FPGA, transmit data, and manage the program remotely.
