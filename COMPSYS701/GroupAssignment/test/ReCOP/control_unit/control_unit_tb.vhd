library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.recop_types.all;
use work.test_utils.all;

use std.textio.all;
use std.env.finish;

entity control_unit_tb is
end control_unit_tb;

architecture sim of control_unit_tb is

    constant clk_hz     : integer := 50e6;
    constant clk_period : time    := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

    -- Inputs
    signal instruction   : bit_32 := (others => '0');
    signal is_equal      : bit_1  := '0';             -- For branching
    signal id_ex_rz_addr : bit_4  := (others => '0'); -- Forwarding
    signal id_ex_rx_addr : bit_4  := (others => '0'); -- Forwarding
    signal id_ex_r_dst   : bit_4  := (others => '0'); -- Hazard detection
    signal ex_mem_r_dst  : bit_4  := (others => '0'); -- Forwarding
    signal mem_wb_r_dst  : bit_4  := (others => '0'); -- Forwarding

    -- Outputs
    signal pc_src       : bit_2;
    signal pc_write     : bit_1;
    signal if_flush     : bit_1;
    signal if_id_write  : bit_1;
    signal id_fwd_src_a : bit_1;
    signal id_fwd_src_b : bit_1;
    signal alu_op       : alu_op_t;
    signal ex_fwd_src_a : bit_2;
    signal ex_fwd_src_b : bit_2;
    signal alu_src      : bit_2;
    signal reg_dst      : bit_1;
    signal mem_addr_src : bit_2;
    signal reg_write    : bit_1;
    signal mem_to_reg   : bit_1;
    signal mem_write    : bit_1;
    signal datacall     : bit_1;
    signal pop          : bit_1;
begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.control_unit
        port map(
            clk           => clk,
            reset         => rst,
            pc_src        => pc_src,
            pc_write      => pc_write,
            if_flush      => if_flush,
            if_id_write   => if_id_write,
            instruction   => instruction,
            is_equal      => is_equal,
            id_fwd_src_a  => id_fwd_src_a,
            id_fwd_src_b  => id_fwd_src_b,
            alu_op        => alu_op,
            ex_fwd_src_a  => ex_fwd_src_a,
            ex_fwd_src_b  => ex_fwd_src_b,
            alu_src       => alu_src,
            reg_dst       => reg_dst,
            mem_addr_src  => mem_addr_src,
            id_ex_rz_addr => id_ex_rz_addr,
            id_ex_rx_addr => id_ex_rx_addr,
            id_ex_r_dst   => id_ex_r_dst,
            ex_mem_r_dst  => ex_mem_r_dst,
            reg_write     => reg_write,
            mem_to_reg    => mem_to_reg,
            mem_wb_r_dst  => mem_wb_r_dst,
            mem_write     => mem_write,
            datacall      => datacall,
            pop           => pop
        );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        rst <= '0';

        wait for clk_period;

        print("----------------------------------------------");
        print("Control Unit Test");
        print("----------------------------------------------");
        ----------------------------------------------
        --! Test LDR Immediate instruction
        instruction <= x"42100005"; -- LDR R1 5
        wait for clk_period/2;

        test(pc_src = "00", "PC source is not correct", "LDR Immediate");
        test(if_flush = '0', "Instruction flush is not correct", "LDR Immediate");

        wait for clk_period; -- Execution stage

        test(alu_src = "01", "ALU source is not correct", "LDR Immediate");
        test(reg_dst = '0', "Register destination is not correct", "LDR Immediate");
        test(alu_op = ALU_B, "ALU operation is not correct", "LDR Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "LDR Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "LDR Immediate");
        test(mem_to_reg = '0', "Memory to register is not correct", "LDR Immediate");

        instruction <= x"00000000";
        print("LDR Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test LDR Register instruction
        instruction <= x"C2120000"; -- LDR R1 R2
        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "LDR Register");
        test(if_flush = '0', "Instruction flush is not correct", "LDR Register");

        wait for clk_period; -- Execution stage

        test(reg_dst = '0', "Register destination is not correct", "LDR Register");
        test(mem_addr_src = "01", "Address source is not correct", "LDR Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "LDR Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "LDR Register");
        test(mem_to_reg = '1', "Memory to register is not correct", "LDR Register");

        instruction <= x"00000000";
        print("LDR Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test LDR Direct instruction
        instruction <= x"82100004"; -- LDR R1 R2

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "LDR Register");
        test(if_flush = '0', "Instruction flush is not correct", "LDR Direct");

        wait for clk_period; -- Execution stage

        test(reg_dst = '0', "Register destination is not correct", "LDR Direct");
        test(mem_addr_src = "10", "Address source is not correct", "LDR Direct");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "LDR Direct");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "LDR Direct");
        test(mem_to_reg = '1', "Memory to register is not correct", "LDR Direct");

        instruction <= x"00000000";
        print("LDR Direct passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test STR Immediate instruction
        instruction <= x"43100005"; -- STR R1 #5
        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "STR Immediate");
        test(if_flush = '0', "Instruction flush is not correct", "STR Immediate");

        wait for clk_period; -- Execution stage

        test(alu_src = "01", "ALU source is not correct", "STR Immediate");
        test(alu_op = ALU_B, "ALU operation is not correct", "STR Immediate");
        test(mem_addr_src = "00", "Address source is not correct", "STR Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '1', "Memory write is not correct", "STR Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "STR Immediate");

        instruction <= x"00000000";
        print("STR Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test STR Register instruction
        instruction <= x"C3120000"; -- STR R1 R2
        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "STR Register");
        test(if_flush = '0', "Instruction flush is not correct", "STR Register");

        wait for clk_period; -- Execution stage

        test(alu_op = ALU_A, "ALU operation is not correct", "STR Register");
        test(mem_addr_src = "00", "Address source is not correct", "STR Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '1', "Memory write is not correct", "STR Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "STR Register");

        instruction <= x"00000000";
        print("STR Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test STR Direct instruction
        instruction <= x"83010004"; -- STR R1 $4
        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "STR Direct");

        test(if_flush = '0', "Instruction flush is not correct", "STR Direct");

        wait for clk_period; -- Execution stage

        test(alu_op = ALU_A, "ALU operation is not correct", "STR Direct");
        test(mem_addr_src = "10", "Address source is not correct", "STR Direct");

        wait for clk_period; -- Memory stage

        test(mem_write = '1', "Memory write is not correct", "STR Direct");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "STR Direct");

        instruction <= x"00000000";
        print("STR Direct passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test ADD Register instruction
        instruction <= x"D0321000"; -- ADD R1 R2 R3

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "ADD Register");
        test(if_flush = '0', "Instruction flush is not correct", "ADD Register");

        wait for clk_period; -- Execution stage

        test(alu_src = "00", "ALU source is not correct", "ADD Register");
        test(alu_op = ALU_ADD, "ALU operation is not correct", "ADD Register");
        test(reg_dst = '1', "Register destination is not correct", "ADD Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "ADD Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "ADD Register");
        test(mem_to_reg = '0', "Memory to register is not correct", "ADD Register");

        instruction <= x"00000000";
        print("ADD Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test ADD Immediate instruction
        instruction <= x"50120005"; -- ADD R1 R2 #5

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "ADD Immediate");
        test(if_flush = '0', "Instruction flush is not correct", "ADD Immediate");

        wait for clk_period; -- Execution stage

        test(alu_src = "01", "ALU source is not correct", "ADD Immediate");
        test(alu_op = ALU_ADD, "ALU operation is not correct", "ADD Immediate");
        test(reg_dst = '0', "Register destination is not correct", "ADD Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "ADD Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "ADD Immediate");
        test(mem_to_reg = '0', "Memory to register is not correct", "ADD Immediate");

        instruction <= x"00000000";
        print("ADD Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test SUB Register instruction
        instruction <= x"D1321000"; -- SUB R1 R2 R3

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "SUB Register");
        test(if_flush = '0', "Instruction flush is not correct", "SUB Register");

        wait for clk_period; -- Execution stage

        test(alu_src = "00", "ALU source is not correct", "SUB Register");
        test(alu_op = ALU_SUB, "ALU operation is not correct", "SUB Register");
        test(reg_dst = '1', "Register destination is not correct", "SUB Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "SUB Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "SUB Register");
        test(mem_to_reg = '0', "Memory to register is not correct", "SUB Register");

        instruction <= x"00000000";
        print("SUB Register passed");

        wait for clk_period * 5.5; -- Fetch stage
        ----------------------------------------------
        --! Test SUB Immediate instruction
        instruction <= x"51120005"; -- SUB R1 R2 #5

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "SUB Immediate");
        test(if_flush = '0', "Instruction flush is not correct", "SUB Immediate");

        wait for clk_period; -- Execution stage

        test(alu_src = "01", "ALU source is not correct", "SUB Immediate");
        test(alu_op = ALU_SUB, "ALU operation is not correct", "SUB Immediate");
        test(reg_dst = '0', "Register destination is not correct", "SUB Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "SUB Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "SUB Immediate");
        test(mem_to_reg = '0', "Memory to register is not correct", "SUB Immediate");

        instruction <= x"00000000";
        print("SUB Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test OR Register instruction
        instruction <= x"D3321000"; -- OR R1 R2 R3

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "OR Register");
        test(if_flush = '0', "Instruction flush is not correct", "OR Register");

        wait for clk_period; -- Execution stage

        test(alu_src = "00", "ALU source is not correct", "OR Register");
        test(alu_op = ALU_OR, "ALU operation is not correct", "OR Register");
        test(reg_dst = '1', "Register destination is not correct", "OR Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "OR Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "OR Register");
        test(mem_to_reg = '0', "Memory to register is not correct", "OR Register");

        instruction <= x"00000000";
        print("OR Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test OR Immediate instruction
        instruction <= x"53120005"; -- OR R1 R2 #5

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "OR Immediate");
        test(if_flush = '0', "Instruction flush is not correct", "OR Immediate");

        wait for clk_period; -- Execution stage

        test(alu_src = "01", "ALU source is not correct", "OR Immediate");
        test(alu_op = ALU_OR, "ALU operation is not correct", "OR Immediate");
        test(reg_dst = '0', "Register destination is not correct", "OR Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "OR Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "OR Immediate");
        test(mem_to_reg = '0', "Memory to register is not correct", "OR Immediate");

        instruction <= x"00000000";
        print("OR Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test JMP Immediate instruction
        instruction <= x"44000004"; -- JMP #4

        wait for 0.5 * clk_period;

        test(pc_src = "10", "PC source is not correct", "JMP Immediate");
        test(if_flush = '1', "Instruction flush is not correct", "JMP Immediate");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "JMP Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "JMP Immediate");

        instruction <= x"00000000";
        print("JMP Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test JMP Register instruction
        instruction <= x"C4110000"; -- JMP #4

        wait for 0.5 * clk_period;

        test(pc_src = "01", "PC source is not correct", "JMP Register");

        test(if_flush = '1', "Instruction flush is not correct", "JMP Register");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "JMP Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "JMP Register");

        instruction <= x"00000000";
        print("JMP Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test JAL Immediate instruction
        instruction <= x"45F00004"; -- JAL R15 #4

        wait for 0.5 * clk_period;

        test(pc_src = "10", "PC source is not correct", "JAL Immediate");
        test(if_flush = '1', "Instruction flush is not correct", "JAL Immediate");

        wait for clk_period; -- Execution stage

        test(alu_op = ALU_B, "Alu op is not correct", "JAL Immediate");
        test(alu_src = "10", "Alu src is not correct", "JAL Immediate");
        test(reg_dst = '0', "Alu dst is not correct", "JAL Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "JAL Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "JAL Immediate");

        instruction <= x"00000000";
        print("JAL Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test JAL Register instruction
        instruction <= x"C5F10000"; -- JAL R15 R1

        wait for 0.5 * clk_period;

        test(pc_src = "01", "PC source is not correct", "JAL Register");

        test(if_flush = '1', "Instruction flush is not correct", "JAL Register");

        wait for clk_period; -- Execution stage

        test(alu_op = ALU_B, "Alu op is not correct", "JAL Register");
        test(alu_src = "10", "Alu src is not correct", "JAL Register");
        test(reg_dst = '0', "Alu dst is not correct", "JAL Register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "JAL Register");

        wait for clk_period; -- Write back stage

        test(reg_write = '1', "Register write is not correct", "JAL Register");

        instruction <= x"00000000";
        print("JAL Register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test BEQ Equal instruction
        instruction <= x"46100004"; -- BEQ R1 R0 #4
        is_equal    <= '1';

        wait for 0.5 * clk_period;

        test(pc_src = "10", "PC source is not correct", "BEQ Equal");
        test(if_flush = '1', "Instruction flush is not correct", "BEQ Equal");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "BEQ Equal");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "BEQ Equal");

        instruction <= x"00000000";
        print("BEQ Equal passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test BEQ Not Equal instruction
        instruction <= x"46100004"; -- BEQ R1 R0 #4
        is_equal    <= '0';

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "BEQ Not Equal");
        test(if_flush = '0', "Instruction flush is not correct", "BEQ Not Equal");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "BEQ Not Equal");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "BEQ Not Equal");

        instruction <= x"00000000";
        print("BEQ Not Equal passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test BNE Not Equal instruction
        instruction <= x"47100004"; -- BNE R1 R0 #4
        is_equal    <= '0';

        wait for 0.5 * clk_period;

        test(pc_src = "10", "PC source is not correct", "BNE Not Equal");
        test(if_flush = '1', "Instruction flush is not correct", "BNE Not Equal");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "BNE Not Equal");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "BNE Not Equal");

        instruction <= x"00000000";
        print("BNE Not Equal passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test BNE Equal instruction
        instruction <= x"47100004"; -- BNE R1 R0 #4
        is_equal    <= '1';

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "BNE Equal");
        test(if_flush = '0', "Instruction flush is not correct", "BNE Equal");

        wait for clk_period; -- Execution stage
        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "BNE Equal");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "BNE Equal");

        instruction <= x"00000000";
        print("BNE Equal passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test DCALL immediate instruction
        instruction <= x"60100004"; -- DCALL R1 #4
        is_equal    <= '0';

        wait for 0.5 * clk_period;

        wait for clk_period; -- Execution stage

        test(alu_src = "00", "ALU source is not correct", "DCALL Immediate");
        test(alu_op = ALU_B, "ALU operation is not correct", "DCALL Immediate");
        test(mem_addr_src = "10", "Address source is not correct", "DCALL Immediate");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "DCALL Immediatel");
        test(datacall = '1', "Memory write is not correct", "DCALL Immediate");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "DCALL Immediate");

        instruction <= x"00000000";
        print("DCALL Immediate passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test DCALL register instruction
        instruction <= x"E0120000"; -- DCALL R1 #4
        is_equal    <= '0';

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "DCALL register");
        test(if_flush = '0', "Instruction flush is not correct", "DCALL register");

        wait for clk_period; -- Execution stage

        test(alu_src = "00", "ALU source is not correct", "DCALL register");
        test(alu_op = ALU_B, "ALU operation is not correct", "DCALL register");
        test(mem_addr_src = "01", "Address source is not correct", "DCALL register");

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "DCALL register");
        test(datacall = '1', "Memory write is not correct", "DCALL register");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "DCALL register");

        instruction <= x"00000000";
        print("DCALL register passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test POP nstruction
        instruction <= x"21000000"; -- DCALL R1 #4
        is_equal    <= '0';

        wait for 0.5 * clk_period;

        test(pc_src = "00", "PC source is not correct", "POP");
        test(if_flush = '0', "Instruction flush is not correct", "POP");

        wait for clk_period; -- Execution stage

        wait for clk_period; -- Memory stage

        test(mem_write = '0', "Memory write is not correct", "POP");
        test(pop = '1', "Memory write is not correct", "POP");

        wait for clk_period; -- Write back stage

        test(reg_write = '0', "Register write is not correct", "POP");

        instruction <= x"00000000";
        print("POP passed");

        wait for clk_period * 5.5; -- Fetch stage

        ----------------------------------------------
        --! Test Forwarding Unit Mem instruction

        instruction <= x"D0321000"; -- ADD R1 R2 #1

        wait for clk_period; -- Instruction Decode stage

        instruction <= x"50410001"; -- ADD R4 R1 #1

        wait for clk_period; -- Execution stage

        id_ex_rx_addr <= x"1";
        ex_mem_r_dst  <= x"1";

        wait for clk_period * 0.5;

        test(ex_fwd_src_a = "01", "Forwarding source A is not correct", "Forwarding Unit Mem");

        wait for clk_period;

        id_ex_rx_addr <= x"0";
        ex_mem_r_dst  <= x"0";
        instruction   <= x"00000000";
        print("Forwarding Unit Mem passed");

        wait for clk_period * 5.5;

        ----------------------------------------------
        --! Test Forwarding Unit WB instruction

        instruction <= x"D0321000"; -- ADD R1 R2 #1

        wait for clk_period; -- Instruction Fetch stage

        instruction <= x"00000000"; -- NOOP

        wait for clk_period; -- Instruction Decode stage

        instruction <= x"50410001"; -- ADD R4 R1 #1

        wait for clk_period; -- Execution stage

        id_ex_rx_addr <= x"1";
        mem_wb_r_dst  <= x"1";

        wait for clk_period * 0.5;

        test(ex_fwd_src_a = "10", "Forwarding source A is not correct", "Forwarding Unit WB");

        wait for clk_period;

        id_ex_rx_addr <= x"0";
        ex_mem_r_dst  <= x"0";
        instruction   <= x"00000000";
        print("Forwarding Unit WB passed");

        wait for clk_period * 5.5;

        ----------------------------------------------
        --! Test Hazard Detection Unit LDR instruction

        instruction <= x"82100004"; -- LDR R1 $4

        wait for clk_period; -- Instruction Decode stage

        instruction <= x"50210001"; -- ADD R2 R1 #1
        id_ex_r_dst <= x"1";

        wait for clk_period * 0.5; -- Instruction Decode stage

        test(if_id_write = '0', "IF/ID write is not correct", "Hazard Detection Unit LDR");
        test(pc_write = '0', "PC write is not correct", "Hazard Detection Unit LDR");

        wait for clk_period; -- Execution stage

        instruction <= x"00000000";
        id_ex_r_dst <= x"0";
        print("Hazard Detection Unit LDR passed");

        wait for clk_period * 5.5;

        ----------------------------------------------
        --! Test Hazard Detection Unit BEQ instruction

        instruction <= x"50110001"; -- ADD R1 R1 #1

        wait for clk_period; -- Instruction Decode stage

        instruction  <= x"46100000"; -- BEQ R1 R0 #0
        id_ex_r_dst  <= x"1";
        ex_mem_r_dst <= x"1";

        wait for clk_period * 0.5; -- Instruction Decode stage

        test(if_id_write = '0', "IF/ID write is not correct", "Hazard Detection Unit BEQ");
        test(pc_write = '0', "PC write is not correct", "Hazard Detection Unit BEQ");

        wait for clk_period; -- Execution stage

        instruction  <= x"00000000";
        id_ex_r_dst  <= x"0";
        ex_mem_r_dst <= x"0";
        print("Hazard Detection Unit BEQ passed");

        wait for clk_period * 5.5;

        ----------------------------------------------
        --! Test Hazard Detection Unit LDR BEQ instruction

        instruction <= x"82100004"; -- LDR R1 $4

        wait for clk_period; -- Instruction Decode stage

        instruction <= x"46100000"; -- BEQ R1 R0 #0
        id_ex_r_dst <= x"1";

        wait for clk_period * 0.5; -- Instruction Decode stage

        test(if_id_write = '0', "IF/ID write 1 is not correct", "Hazard Detection Unit LDR BEQ");
        test(pc_write = '0', "PC write 1 is not correct", "Hazard Detection Unit LDR BEQ");

        wait for clk_period * 0.5; -- Execution stage

        id_ex_r_dst  <= x"0";
        ex_mem_r_dst <= x"1";

        wait for clk_period * 0.5;

        test(if_id_write = '0', "IF/ID write 2 is not correct", "Hazard Detection Unit LDR BEQ");
        test(pc_write = '0', "PC write 2 is not correct", "Hazard Detection Unit LDR BEQ");

        wait for clk_period; -- Execution stage

        instruction  <= x"00000000";
        id_ex_r_dst  <= x"0";
        ex_mem_r_dst <= x"0";
        print("Hazard Detection Unit LDR BEQ passed");

        wait for clk_period * 5.5;

        print("----------------------------------------------");
        finish;
    end process;

end architecture;