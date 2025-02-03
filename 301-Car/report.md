

## Table of Contents:
- [Table of Contents:](#table-of-contents)
- [Project Brief:](#project-brief)
- [Objectives:](#objectives)
- [Circuit Design:](#circuit-design)
  - [Overview:](#overview)
  - [1. Photodiodes \& Light Sensing](#1-photodiodes--light-sensing)
    - [a. Designs:](#a-designs)
    - [b. Measurements \& Numerical Analysis:](#b-measurements--numerical-analysis)
    - [c. Considerations:](#c-considerations)
    - [d. Verification:](#d-verification)
  - [2. Filtering](#2-filtering)
    - [a. Designs:](#a-designs-1)
    - [b. Measurements \& Numerical Analysis:](#b-measurements--numerical-analysis-1)
    - [c. Considerations:](#c-considerations-1)
    - [d. Verification:](#d-verification-1)
  - [3. Amplification \& Offsets](#3-amplification--offsets)
    - [a. Designs:](#a-designs-2)
    - [b. Measurements \& Numerical Analysis:](#b-measurements--numerical-analysis-2)
    - [c. Considerations:](#c-considerations-2)
    - [d. Verification:](#d-verification-2)
  - [4. Schmitt Trigger](#4-schmitt-trigger)
    - [a. Designs:](#a-designs-3)
    - [b. Measurements \& Numerical Analysis:](#b-measurements--numerical-analysis-3)
    - [c. Considerations:](#c-considerations-3)
    - [d. Verification:](#d-verification-3)
  - [5. Final Circuit Design:](#5-final-circuit-design)
    - [a. Measurements \& Numerical Analysis:](#a-measurements--numerical-analysis)
    - [b. Verification:](#b-verification)
    - [c. Changes:](#c-changes)
- [PCB:](#pcb)
    - [a. Design:](#a-design)
    - [b. Challanges:](#b-challanges)
    - [c. Value Changes:](#c-value-changes)
- [Firmware:](#firmware)
  - [Overview:](#overview-1)
  - [1. Setup](#1-setup)
  - [2. Input Handling](#2-input-handling)
  - [3. Motor Control System](#3-motor-control-system)
- [Software:](#software)
  - [Overview:](#overview-2)
  - [1. Pathfinding Algorithm](#1-pathfinding-algorithm)
  - [2. PID Controller](#2-pid-controller)
  - [3. State Machine \& State Management](#3-state-machine--state-management)
- [Task Atribution Table:](#task-atribution-table)
- [Appendices:](#appendices)



## Project Brief:
The project you will engage in will require you to work with a custom two-wheeled robot to navigate a maze. The path of the maze is projected as a line from a ceiling mounted projector. The walls of the maze are not projected. The robot comes with electronics to drive the motors and provides an interface to a Cypress PSoC 5 development kit - the Kit 059. The motors include a gearbox and rotation sensors.During the course of this project, you will design and build a sensor PCB to locate and position your robot on the projected line. With this information, you will program the PSoC, in C, to complete one of several objectives.

  ## Objectives: 
**Hardware Design**

  1. Design and configure hardware subsystems for use with a microcontroller
  1. Test subsystems, integrate them by physically installing and wiring them as well as writing
    some code
  1. You will write code for a microcontroller to execute low level APIs that can be used by higher
    level programs.
  1. You will write code for PC’s (Matlab or equivalent) to analyse or understand the performance
    of your subsystems 
    
**Software Design**

  1. Design a software solution to solve path planning requirement.
  1. Select a suitable algorithm to solve the problem(s). Create suitable data structures to suit.
  1. Test your software

## Circuit Design:
### Overview: 

### 1. Photodiodes & Light Sensing 
#### a. Designs:
#### b. Measurements & Numerical Analysis:
#### c. Considerations:
#### d. Verification: 

### 2. Filtering  
#### a. Designs:
#### b. Measurements & Numerical Analysis:
#### c. Considerations:
#### d. Verification: 

### 3. Amplification & Offsets 
#### a. Designs:
#### b. Measurements & Numerical Analysis:
#### c. Considerations:
#### d. Verification: 

### 4. Schmitt Trigger 
#### a. Designs:
#### b. Measurements & Numerical Analysis:
#### c. Considerations:
#### d. Verification: 

### 5. Final Circuit Design:
#### a. Measurements & Numerical Analysis:
#### b. Verification: 
#### c. Changes: 

## PCB:
#### a. Design:
#### b. Challanges:
#### c. Value Changes:

## Firmware:
### Overview: 
### 1. Setup 
### 2. Input Handling
### 3. Motor Control System

## Software:
### Overview: 
### 1. Pathfinding Algorithm 
### 2. PID Controller
### 3. State Machine & State Management 


## Task Atribution Table:
| Task |                 Description                 |           Assigned To            |   Status |
| :--- | :-----------------------------------------: | :------------------------------: | -------: |
| 1    |    Photodiode & Phototransistor Testing     | Bailey,Dylan,Franklin & Marianne | Finished |
| 2    |                Filter Design                |          Bailey & Dylan          | Finished |
| 3    | MatLab Filter Response Plots & Calculations |              Bailey              | Finished |
| 4    |            Analog Circuit Design            |          Bailey & Dylan          | Finished |
| 5    |           LT Spice Circuit Design           |          Bailey & Dylan          | Finished |
| 6    |      USB Communication & Motor Control      |        Bailey & Franklin         | Finished |
| 7    | Upgrading USB Communication & Motor Control |              Dylan               | Finished |
| 8    |            Breadboarding Filters            |              Bailey              | Finished |
| 9    |       Breadboarding OPAMPS & Offsets        |          Bailey & Dylan          | Finished |
| 10   |        Breadboarding Schmitt Trigger        |     Bailey, Dylan & Franklin     | Finished |
| 11   |         Breadboarding Error Fixing          |     Bailey, Dylan & Franklin     | Finished |
| 12   |            Pathfinding Algorithm            |              Dylan               | Finished |
| 13   |               PCB Schematics                |             Franklin             | Finished |
| 14   |             PCB Layout & Design             |        Bailey & Franklin         | Finished |
| 15   |               Finalising PCB                |         Dylan & Franklin         | Finished |
| 16   |             Soldering Board #1              |        Bailey & Marianne         | Finished |
| 17   |                Fixing PCB #1                |     Bailey, Dylan & Franklin     | Finished |
| 18   |              Soldering PCB #2               |     Bailey, Dylan & Franklin     | Finished |
| 19   |         Car Turning & Motor Control         |              Dylan               | Finished |
| 20   |            Reading Sensor Inputs            |             Franklin             | Finished |
| 21   |                State Machine                |             Franklin             | Finished |
| 22   |                State Control                |         Dylan & Franklin         | Finished |
| 23   |               PID Controller                |              Dylan               | Finished |
| 24   | Error Fixing and Verification for Benchmark |     Bailey,Dylan & Franklin      | Finished |
| 25   |                   Report                    |              Bailey              | Finished |


## Appendices:
