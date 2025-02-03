------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.recop_types.all;
use work.opcodes.all;
-- Takes inputs of current data message
-- Outputs control signals

entity control_unit is
    port (
        clk   : in bit_1;
        reset : in bit_1;
        -- Instruction Fetch
        pc_src      : out bit_2;
        pc_write    : out bit_1;
        if_flush    : out bit_1;
        if_id_write : out bit_1;
        -- Instruction Decode
        instruction  : in bit_32;
        is_equal     : in bit_1;
        id_fwd_src_a : out bit_1;
        id_fwd_src_b : out bit_1;
        -- Execute
        alu_op       : out alu_op_t;
        ex_fwd_src_a : out bit_2;
        ex_fwd_src_b : out bit_2;
        alu_src      : out bit_2 := (others => '0');
        reg_dst      : out bit_1;
        mem_addr_src : out bit_2;

        id_ex_rz_addr : in bit_4;
        id_ex_rx_addr : in bit_4;
        id_ex_r_dst   : in bit_4;

        -- Memory
        ex_mem_r_dst : in bit_4;
        -- Writeback
        reg_write    : out bit_1;
        mem_to_reg   : out bit_1;
        mem_wb_r_dst : in bit_4;
        -- Data Memory
        mem_write : out bit_1;
        datacall  : out bit_1;
        pop       : out bit_1
    );

end control_unit;

architecture behaviour of control_unit is
    signal am      : bit_2 := (others => '0');
    signal opcode  : bit_6 := (others => '0');
    signal rz_addr : bit_4 := (others => '0');
    signal rx_addr : bit_4 := (others => '0');

    -- Instruction Decode
    signal jump         : bit_1 := '0';
    signal branch       : bit_1 := '0';
    signal branch_eq    : bit_1 := '0';
    signal branch_ne    : bit_1 := '0';
    signal is_branching : bit_1 := '0';
    signal id_pc_src    : bit_2 := (others => '0');

    signal id_alu_op       : alu_op_t := ALU_ADD;
    signal id_reg_dst      : bit_1    := '0';
    signal id_alu_src      : bit_2    := (others => '0');
    signal id_mem_addr_src : bit_2    := (others => '0');

    signal id_mem_write : bit_1 := '0';
    signal id_datacall  : bit_1 := '0';
    signal id_pop       : bit_1 := '0';

    signal id_mem_to_reg : bit_1 := '0';
    signal id_reg_write  : bit_1 := '0';

    -- Execution
    signal ex_mem_write : bit_1 := '0';
    signal ex_datacall  : bit_1 := '0';
    signal ex_pop       : bit_1 := '0';

    signal ex_mem_to_reg : bit_1 := '0';
    signal ex_reg_write  : bit_1 := '0';
    -- Memory
    signal mem_mem_to_reg : bit_1 := '0';
    signal mem_reg_write  : bit_1 := '0';
    -- Write back
    signal wb_reg_write : bit_1 := '0';
    -- Hazard Detection
    signal id_flush : bit_1 := '0';

    signal id_dmem_read  : bit_1 := '0';
    signal ex_dmem_read  : bit_1 := '0';
    signal mem_dmem_read : bit_1 := '0';

begin

    control : process (am, opcode)
    begin
        jump            <= '0';
        branch_eq       <= '0';
        branch_ne       <= '0';
        id_pc_src       <= "00"; -- 00 = next, 01 = rx, 10 = operand 
        id_alu_op       <= ALU_ADD;
        id_reg_dst      <= '0';             -- 0 = Rz, 1 = Ry
        id_alu_src      <= (others => '0'); -- 00 = Rz, 01 = operand, 10 = Next PC
        id_mem_addr_src <= (others => '0'); -- 00 = Rz, 01 = Rx, 10 = operand
        id_mem_write    <= '0';
        id_mem_to_reg   <= '0'; -- 0 = ALU Result, 1 = Read Data
        id_dmem_read    <= '0';
        id_reg_write    <= '0';
        id_datacall     <= '0';
        id_pop          <= '0';

        if opcode(4) = '1' then -- ALU INST
            id_mem_to_reg <= '0';
            id_reg_write  <= '1';

            case am is
                when am_immediate =>
                    id_reg_dst <= '0';
                    id_alu_src <= "01";
                when am_register =>
                    id_reg_dst <= '1';
                    id_alu_src <= "00";
                when others =>
            end case;

            case opcode is
                when addr =>
                    id_alu_op <= ALU_ADD;
                when subr =>
                    id_alu_op <= ALU_SUB;
                when andr =>
                    id_alu_op <= ALU_AND;
                when orr =>
                    id_alu_op <= ALU_OR;
                when xorr =>
                    id_alu_op <= ALU_XOR;
                when max =>
                    id_alu_op <= ALU_MAX;
                when sllr =>
                    id_alu_op <= ALU_SLL;
                when srlr =>
                    id_alu_op <= ALU_SRL;
                when others =>
                    id_alu_op <= ALU_ADD;
            end case;
        else
            case opcode is
                when ldr =>
                    id_reg_dst   <= '0';
                    id_reg_write <= '1';
                    case am is
                        when am_immediate =>
                            id_alu_op     <= ALU_B;
                            id_mem_to_reg <= '0';
                            id_alu_src    <= "01";
                        when am_register =>
                            id_dmem_read    <= '1';
                            id_mem_to_reg   <= '1';
                            id_mem_addr_src <= "01";
                        when am_direct =>
                            id_dmem_read    <= '1';
                            id_mem_to_reg   <= '1';
                            id_mem_addr_src <= "10";
                        when others =>
                    end case;
                when str =>
                    id_mem_write <= '1';
                    case am is
                        when am_immediate =>
                            id_alu_op       <= ALU_B;
                            id_alu_src      <= "01";
                            id_mem_addr_src <= "00";
                        when am_register =>
                            id_alu_op       <= ALU_A;
                            id_mem_addr_src <= "00";
                        when am_direct =>
                            id_alu_op       <= ALU_A;
                            id_mem_addr_src <= "10";
                        when others =>
                    end case;
                when jmp =>
                    jump <= '1';
                    case am is
                        when am_immediate =>
                            id_pc_src <= "10";
                        when am_register =>
                            id_pc_src <= "01";
                        when others =>
                    end case;
                when jal =>
                    jump         <= '1';
                    id_reg_write <= '1';
                    id_reg_dst   <= '0';
                    id_alu_src   <= "10";
                    id_alu_op    <= ALU_B;
                    case am is
                        when am_immediate =>
                            id_pc_src <= "10";
                        when am_register =>
                            id_pc_src <= "01";
                        when others =>
                    end case;
                when beq =>
                    branch_eq <= '1';
                    id_pc_src <= "10";
                when bne =>
                    branch_ne <= '1';
                    id_pc_src <= "10";
                when dcall =>
                    id_alu_op   <= ALU_B;
                    id_alu_src  <= "00";
                    id_datacall <= '1';
                    case am is
                        when am_immediate =>
                            id_mem_addr_src <= "10";
                        when am_register =>
                            id_mem_addr_src <= "01";
                        when others =>
                    end case;
                when popr =>
                    id_pop <= '1';
                when others =>
                    id_alu_op <= ALU_ADD;
            end case;
        end if;
    end process;

    control_pipeline : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                alu_op         <= ALU_ADD;
                reg_dst        <= '0';
                alu_src        <= (others => '0');
                mem_addr_src   <= (others => '0');
                ex_mem_write   <= '0';
                ex_datacall    <= '0';
                ex_pop         <= '0';
                ex_mem_to_reg  <= '0';
                ex_reg_write   <= '0';
                ex_dmem_read   <= '0';
                mem_write      <= '0';
                mem_mem_to_reg <= '0';
                mem_reg_write  <= '0';
                mem_to_reg     <= '0';
                reg_write      <= '0';

            else
                if id_flush = '1' then -- Flush the control reg to stall.
                    alu_op        <= ALU_ADD;
                    reg_dst       <= '0';
                    alu_src       <= (others => '0');
                    mem_addr_src  <= (others => '0');
                    ex_mem_write  <= '0';
                    ex_datacall   <= '0';
                    ex_pop        <= '0';
                    ex_mem_to_reg <= '0';
                    ex_reg_write  <= '0';
                    ex_dmem_read  <= '0';
                else
                    alu_op        <= id_alu_op;
                    reg_dst       <= id_reg_dst;
                    alu_src       <= id_alu_src;
                    mem_addr_src  <= id_mem_addr_src;
                    ex_mem_write  <= id_mem_write;
                    ex_datacall   <= id_datacall;
                    ex_pop        <= id_pop;
                    ex_mem_to_reg <= id_mem_to_reg;
                    ex_reg_write  <= id_reg_write;
                    ex_dmem_read  <= id_dmem_read;
                end if;

                mem_write      <= ex_mem_write;
                datacall       <= ex_datacall;
                pop            <= ex_pop;
                mem_mem_to_reg <= ex_mem_to_reg;
                mem_reg_write  <= ex_reg_write;
                mem_dmem_read  <= ex_dmem_read;

                mem_to_reg   <= mem_mem_to_reg;
                wb_reg_write <= mem_reg_write;
                reg_write    <= mem_reg_write;
            end if;
        end if;
    end process;

    hazard_detection : process (ex_dmem_read, id_ex_r_dst, ex_mem_r_dst, rx_addr, rz_addr, branch, mem_dmem_read, ex_reg_write)
    begin
        if_id_write <= '1';
        pc_write    <= '1';
        id_flush    <= '0';
        -- Pipline Stall if previous instruction is reading from the data memory and you need the data.
        if (ex_dmem_read = '1' and ((id_ex_r_dst = rx_addr) or (id_ex_r_dst = rz_addr))) then
            if_id_write <= '0';
            pc_write    <= '0';
            id_flush    <= '1';
            -- Pipeline Stall when branching and need previous instructions alu result.
        elsif (branch = '1' and ex_reg_write = '1' and ((id_ex_r_dst = rx_addr) or (id_ex_r_dst = rz_addr))) then
            if_id_write <= '0';
            pc_write    <= '0';
            id_flush    <= '1';
            -- Pipeline stall when branching and need 2x previous instructions dmem value.
        elsif (branch = '1' and mem_dmem_read = '1' and ((ex_mem_r_dst = rx_addr) or (ex_mem_r_dst = rz_addr))) then
            if_id_write <= '0';
            pc_write    <= '0';
            id_flush    <= '1';
        end if;
    end process;

    forwarding_unit : process (mem_reg_write, ex_mem_r_dst, wb_reg_write, mem_wb_r_dst, id_ex_rx_addr, id_ex_rz_addr, rx_addr, rz_addr)
    begin
        -- ALU Operand Forwarding
        if (mem_reg_write = '1' and ex_mem_r_dst /= "0000" and ex_mem_r_dst = id_ex_rx_addr) then -- Forward from EX/MEM
            ex_fwd_src_a <= "01";
        elsif (wb_reg_write = '1' and mem_wb_r_dst /= "0000" and mem_wb_r_dst = id_ex_rx_addr) then -- Forward from MEM/WB
            ex_fwd_src_a <= "10";
        else
            ex_fwd_src_a <= "00";
        end if;

        if (mem_reg_write = '1' and ex_mem_r_dst /= "0000" and ex_mem_r_dst = id_ex_rz_addr) then -- Forward from EX/MEM
            ex_fwd_src_b <= "01";
        elsif (wb_reg_write = '1' and mem_wb_r_dst /= "0000" and mem_wb_r_dst = id_ex_rz_addr) then -- Forward from MEM/WB
            ex_fwd_src_b <= "10";
        else
            ex_fwd_src_b <= "00";
        end if;

        -- BEQ Operand Forwarding:
        if (mem_reg_write = '1' and ex_mem_r_dst /= "0000" and ex_mem_r_dst = rx_addr) then -- Forward from EX/MEM
            id_fwd_src_a <= '1';
        else
            id_fwd_src_a <= '0';
        end if;

        if (mem_reg_write = '1' and ex_mem_r_dst /= "0000" and ex_mem_r_dst = rz_addr) then -- Forward from EX/MEM
            id_fwd_src_b <= '1';
        else
            id_fwd_src_b <= '0';
        end if;
    end process;

    -- Branching 
    branch       <= branch_eq or branch_ne;
    is_branching <= (jump or (branch_eq and is_equal) or (branch_ne and not is_equal));
    pc_src       <= id_pc_src when is_branching = '1' else
        (others => '0');
    if_flush <= is_branching;

    am      <= instruction(31 downto 30);
    opcode  <= instruction(29 downto 24);
    rz_addr <= instruction(23 downto 20);
    rx_addr <= instruction(19 downto 16);
end behaviour;