
from typing import List
import sys 
sys.tracebacklimit = 0

MAX_DMEM = 4096
MAX_PMEM = 4096

INSTRUCTION_SIZE = 32
DATA_SIZE = 16

MAX_REGISTER = 16

AM_INHERENT = 0
AM_IMMEDIATE = 1
AM_DIRECT = 2
AM_REGISTER = 3

Opcodes = {
    "NOOP":     (0b000000, 1 << AM_INHERENT),
    "LDR":      (0b000010, 1 << AM_IMMEDIATE | 1 << AM_REGISTER | 1 << AM_DIRECT),
    "STR":      (0b000011, 1 << AM_IMMEDIATE | 1 << AM_REGISTER | 1 << AM_DIRECT),
    "JMP":      (0b000100, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "JAL":      (0b000101, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "BEQ":      (0b000110, 1 << AM_IMMEDIATE),
    "BNE":      (0b000111, 1 << AM_IMMEDIATE),
    "ADD":      (0b010000, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "SUB":      (0b010001, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "AND":      (0b010010, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "OR":       (0b010011, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "XOR":      (0b010100, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "MAX":      (0b010101, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "SLL":      (0b010110, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "SRL":      (0b010111, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "DCALL":    (0b100000, 1 << AM_IMMEDIATE | 1 << AM_REGISTER),
    "POP":      (0b100001, 1 << AM_INHERENT),
}

Labels: dict[str, int] = {
    "HEX0":       0x8000,
    "HEX1":       0x8002,
    "HEX2":       0x8004,
    "HEX3":       0x8006,
    "HEX4":       0x8008,
    "HEX5":       0x800A,
    "LEDR":       0x800C,
    "SWITCHES":   0x800E,
    "KEY":        0x8010,
    "TO_NOC_U":   0x8012,
    "TO_NOC_L":   0x8014,
    "FROM_NOC_U": 0x8016,
    "FROM_NOC_L": 0x8018,
}

class ASMInstruction:
    def __init__(self, instruction: str, file_line: int) -> None:
        self.instruction = instruction
        self.parsed_instr = instruction
        self.file_line = file_line
        
    def replace_labels(self):
        # Replace the labels with the address
        parts = self.instruction.split()
        if parts[-1][0] == "$" or parts[-1][0] == "#":
            label = parts[-1][1:]
            if label not in Labels:
                try:
                    int(label, 0)
                except ValueError:
                    raise ValueError(f"Error: Invalid label '{label}' on line {self.file_line}")
                self.parsed_instr = self.instruction
            else :
                self.parsed_instr = self.instruction.replace(label, str(Labels[label]))


def parse_file(file : str) -> tuple[List[ASMInstruction], dict[str, int]]:
    # Read the file and return a list of instructions
    # Remove comments and empty lines
    instructions: List[ASMInstruction] = [
        ASMInstruction(f"LDR R14 #{2*MAX_DMEM}", 0), # Initalize stack pointer
        ASMInstruction("JMP #MAIN", 1) # Jump to main
        ]
    pmem_addr = 4 * len(instructions)

    with open(file, "r") as f:
        for line_num, line in enumerate(f.readlines()):
            line = line.split(';')[0].strip().upper()
            if line:
                
                if line.__contains__(":"):
                    label, inst = line.split(":")
                    if ' ' in label:
                        raise ValueError(f"Error: Invalid label '{label}' on line {line_num+1}")
                    label = label.strip()
                    inst = inst.strip()
                    Labels[label] = pmem_addr
                    if inst:
                        instructions.append(ASMInstruction(inst, line_num+1))
                        pmem_addr += INSTRUCTION_SIZE//8 
                else:
                    instructions.append(ASMInstruction(line, line_num+1))
                    pmem_addr += INSTRUCTION_SIZE//8   
    if "MAIN" not in Labels:
        raise ValueError("Error: No MAIN label found")
    
    for instr in instructions:
        instr.replace_labels()


    return (instructions)


def generate_mif(output_file, hex_instructions):
    # Generate the MIF file from 32bit hex array 
    with open(output_file, "w") as f:
        f.write(f"DEPTH = {MAX_PMEM};\n")
        f.write(f"WIDTH = {INSTRUCTION_SIZE};\n\n")
        f.write("ADDRESS_RADIX = HEX;\n")
        f.write("DATA_RADIX = HEX;\n\n")
        f.write("CONTENT\n")
        f.write("BEGIN\n")
        for i, instr in enumerate(hex_instructions):
            for label, address in Labels.items():
                if i == address//4:
                    f.write(f"-- {label}:\n")
            f.write(f"{i:02X} : {instr[0]:08X}; -- {instr[1]}\n")
        f.write("END;\n")


def get_register(register : str, line_num: int) -> int:
    # Lookup the register number from the register name
    register_map = {'R0': 0, 'RZ': 0, 'R1': 1, 'V0': 1, 'R2': 2, 'A0': 2, 'R3': 3, 'A1': 3,
                    'R4': 4, 'A2': 4, 'R5': 5, 'A3': 5, 'R6': 6, 'T0': 6, 'R7': 7, 'T1': 7,
                    'R8': 8, 'T2': 8, 'R9': 9, 'T3': 9, 'R10': 10, 'S0': 10, 'R11': 11, 'S1': 11,
                    'R12': 12, 'S2': 12, 'R13': 13, 'S3': 13, 'R14': 14, 'SP': 14, 'R15': 15, 'RA': 15}
    if register in register_map:
        return register_map[register]
    else:
        raise ValueError(f"Error: Invalid register '{register}' on line {line_num}")


def compile(instructions : List[ASMInstruction]) -> List[tuple[int, str]]:
    # Parses the assembly compiling it to byte code
    hex_instructions : List[tuple[int, str]] = []
    for instr in instructions:
        line = instr.file_line
        parts = instr.parsed_instr.split()

        am = AM_INHERENT
        opcode = 0
        rz = 0
        rx = 0
        ry = 0
        operand = 0

        # Determine addressing mode and operands and rx
        parts_len = len(parts)
        if parts_len > 1:
            match parts[parts_len-1][0]:
                case "$":
                    am = AM_DIRECT
                    try:
                        operand = int(parts[parts_len - 1][1:], 0)
                    except ValueError:
                        raise ValueError(f"Error: Invalid operand '{parts[parts_len - 1]}' on line {line}")
                    if parts[0] == "LDR": # Direct load instructions set RZ 
                        rz = get_register(parts[1], line)
                    elif parts[0] == "STR": # Direct store instructions set RX
                        rx = get_register(parts[1], line)

                case "#":
                    am = AM_IMMEDIATE
                    try:
                        operand = int(parts[parts_len - 1][1:], 0)
                    except ValueError:
                        raise ValueError(f"Error: Invalid operand '{parts[parts_len - 1]}' on line {line}")
                    match parts_len:
                        case 4:
                            rz = get_register(parts[1], line)
                            rx = get_register(parts[2], line)
                        case 3:
                            rz = get_register(parts[1], line)
                    
                case _:
                    am = AM_REGISTER
                    match parts_len:
                        case 4:
                            ry = get_register(parts[1], line)
                            rx = get_register(parts[2], line)
                            rz = get_register(parts[3], line)
                        case 3:
                            rz = get_register(parts[1], line)
                            rx = get_register(parts[2], line)
                            if parts[0] == "STR":
                                rz, rx = rx, rz
                        case 2: 
                            rz = get_register(parts[1], line)
                            rx = get_register(parts[1], line)  

        # Determine opcode
        if parts[0] in Opcodes:
            opcode = Opcodes[parts[0]][0]
            if (Opcodes[parts[0]][1] & (1 << am)) == 0:
                raise ValueError(f"Error: Invalid addressing mode for instruction '{parts[0]}' on line {line}")
        else:
            raise ValueError(f"Error: Invalid opcode '{parts[0]}' on line {line}")
        if not (ry == 0) and not (operand == 0):
            raise ValueError(f"Error: Invalid operands for instruction '{parts[0]}' on line {line}")
        
        hex_instrucion = (am << 30) | (opcode << 24) | (rz << 20) | (rx << 16) | (ry << 12) | operand
        hex_instructions.append((hex_instrucion, instr.instruction))
    return hex_instructions
    



if __name__ == "__main__":
    input_file = "./program.asm"
    output_file = "./output.mif"

    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    if len(sys.argv) > 2:
        output_file = sys.argv[2]
    
    instructions = parse_file(input_file)
    hex_instructions = compile(instructions)
    generate_mif(output_file, hex_instructions)

    
    print(f"MIF file '{output_file}' generated successfully.")
