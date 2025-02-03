# ReCOP
A 5 stage piplined Reactive Co-Processor by **Dylan Chamberlain** and **Franklin O'Sullivan**

## How to use

### Simulation
#### Linux
- Run `./run_tb.sh` to run our assertion test benches in the commandline. This checks the control signals at every stage of the pipeline for all instructions and all hazard detection and forwarding scenarios.
- Run `./run_tb.sh --gui` to open the `recop_tb` in modelsim with waves already setup. This loads the program in the generic port of the recop component in `recop_tb.vhdl`.

#### Windows
1) Compile every file under `./src` either through the quartus project or manually adding all the files to a modelsim work library.
2) Add the test benches to the work library and compile them
- Simulate `control_unit_tb` and `datapath_tb` to run our assertions test benches.
- Simulate `recop_tb` and run `do wave.do` in the modelsim command line to open our `recop_tb` with waves.

### On DE1-SoC
1) Open `./recop.qpf` in quartus.
2) Start compilation
3) If only changing the code in the mif, update the mif file under processing and rerun only the assembler
4) Click program and select DE1-SoC.
5) Auto detect and select the second option
6) In the second devices upload `./output_files/TopLevel.sof` and tick Program/Configure
7) Press Start

### multiply.asm
- The Default program is `multiply.asm`
- This program displays:
- The product on hex4 and hex5
- The sum on hex2 and hex3
- The two 4 bit numbers on hex0 and hex1
- The inputs for num0 is sw(0 to 3)
- The inputs for num1 is Sw(4 to 7)
- The values are displayed in HEX 

### Assembler
1) Navigate to the project directory in terminal or command prompt
2) Run `python assembler.py` to compile `./program.asm` into `./output.mif`
3) Run `python assembler.py <inputfile.asm> <outputfile.asm`> to compile specific files
- The assembly program must have a `main` label as that is where it will jump to too start.
- Labels are not case sensitive
- Labels can be used instead of numbers as immediate values
- Comments are started with `;`
- The compatable instructions and register usage convetions are below.

## Instruction Set:

### Immediate / Direct
| AM | Opcode | Rz | Rz | Operand|
|-|-|-|-|-|
|31 - 30|29 - 24|23 - 20| 19 - 16| 15 - 0|

### Register
| AM | Opcode | Rz | Rz | Ry |
|-|-|-|-|-|
|31 - 30|29 - 24|23 - 20| 19 - 16| 15 - 12|

### Instructions
| Instruction | Addressing Mode | Register Transfer 
|-------------|----------------|-------------------|
|**NOOP**||**OP: 0b000000**|
| `NOOP`        | Inherent | `No Operation` |
|**LDR**|Load|**OP: 0b000010**|
| `LDR Rz #Operand` | Immediate | `Rz <- Operand` |
| `LDR Rz Rx` | Register | `Rz <- DMEM[Rx]` |
| `LDR Rz $Operand` | Direct | `Rz <- DMEM[Operand]` |
|**STR**|Store|**OP: 0b000011**|
| `STR Rz #Operand` | Immediate | `DMEM[Rz] <- Operand` |
| `STR Rx Rz` | Register | `DMEM[Rz] <- Rx` |
| `STR Rx $Operand` | Direct | `DMEM[Operand] <- Rx` |
|**JMP**|Jump|**OP: 0b000100**|
| `JMP #Operand` | Immediate | `PC <- Operand` |
| `JMP Rx` | Register | `PC <- Rx` |
|**JAL**|Jump|**OP: 0b000101**|
| `JAL Rz #Operand` | Immediate | `Rz <- PC + 4, PC <- Operand` |
| `JAL Rz Rx` | Register | `Rz <- PC + 4, PC <- Rx` |
|**BEQ**||**OP: 0b000110**|
| `BEQ Rz Rx #Operand` | Immediate | `if Rz = Rx, PC <- Operand` |
|**BNE**||**OP: 0b000111**|
| `BNE Rz Rx #Operand` | Immediate | `if Rz != Rx, PC <- Operand` |
|**ADD**||**OP: 0b010000**|
| `ADD Ry Rx Rz`        | Register | `Ry <- Rx + Rz` |
| `ADD Rz Rx #Operand`  | Immediate |`Rz <- Rx + Operand` |
|**SUB**||**OP: 0b010001**|
| `SUB Ry Rx Rz`       | Register | `Ry <- Rx - Rz` |
| `SUB Rz Rx #Operand` | Immediate | `Rz <- Rx - Operand` |
|**AND**||**OP: 0b010010**|
| `AND Ry Rx Rz`        | Register | `Ry <- Rx AND Rz` |
| `AND Rz Rx #Operand`  | Immediate | `Rz <- Rx AND Operand` |
|**OR**||**OP: 0b010011**|
| `OR Ry Rx Rz`         | Register | `Ry <- Rx OR Rz` |
| `OR Rz Rx #Operand`   | Immediate | `Rz <- Rx OR Operand` |
|**XOR**||**OP: 0b010100**|
| `XOR Ry Rx Rz`         | Register | `Ry <- Rx XOR Rz` |
| `XOR Rz Rx #Operand`   | Immediate | `Rz <- Rx XOR Operand` |
|**MAX**||**OP: 0b010101**|
| `MAX Ry Rx Rz`         | Register | `Ry <- Max(Rx, Rz)` |
| `MAX Rz Rx #Operand`   | Immediate | `Rz <- Max(Rx, Operand)` |
|**SLL**||**OP: 0b010110**|
| `SLL Ry Rx Rz`         | Register | `Ry <- Rx << Rz` |
| `SLL Rz Rx #Operand`   | Immediate | `Rz <- Rx << Operand` |
|**SRL**||**OP: 0b010111**|
| `SRL Ry Rx Rz`         | Register | `Ry <- Rx >> Rz` |
| `SRL Rz Rx #Operand`   | Immediate | `Rz <- Rx >> Operand` |
|**DCALL**| NOC Datacall |**OP: 0b100000**|
|`DCALL Rz Rx`| Register | `DPCR <- Rz & Rx` |
|`DCALL Rz #Operand`| Immediate | `DPCR <- Rz & Operand` |
|**POP**| Pop NOC Input Queue |**OP: 0b100001**|
|`POP`| Inherent | `IDX = IDX-1, DPRR(i) <- DPRR(i+1)` |

### I/0 Mem Labels
| Label | Address |
|-|-|
| HEX0| 0x8000|
| HEX1| 0x8002|
| HEX2| 0x8004|
| HEX3| 0x8006|
| HEX4| 0x8008|
| HEX5| 0x800A|
| LEDR| 0x800C|
| SWITCHES| 0x800E|
|TO_NOC_U| 0x8012|
|TO_NOC_L| 0x8014|
|FROM_NOC_U| 0x8016|
|FROM_NOC_L| 0x8018|
<!-- |KEY| 0x8010| -->

### Registers

|Register Number| Register Name| Register Usage |
|-|-|-|
|`R0`|`RZ`| Constant 0|
|`R1`|`V0`| Result of a function|
|`R2 - R5`|`A0 - A3`| Argument 1 - 4|
|`R6 - R9`|`T0 - T3`| Temporaray Register |
|`R10 - R13`|`S0 - S3`| Saved Temporary |
|`R14`|`SP`| Stack Pointer |
|`R15`|`RA` | Return Address |

Appart from R0 this is just a usage convention. R0 cannot be written to.

