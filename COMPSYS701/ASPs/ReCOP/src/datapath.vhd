------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.recop_types.all;

entity datapath is
    port (
        clk   : in bit_1;
        reset : in bit_1;
        -- Control Unit
        -- Instruction Fetch
        pc_src      : in bit_2;
        pc_write    : in bit_1;
        if_flush    : in bit_1;
        if_id_write : in bit_1;
        -- Instruction Decode
        instruction  : out bit_32;
        id_fwd_src_a : in bit_1;
        id_fwd_src_b : in bit_1;
        is_equal     : out bit_1;
        -- Execute
        alu_op       : in alu_op_t;
        ex_fwd_src_a : in bit_2;
        ex_fwd_src_b : in bit_2;
        alu_src      : in bit_2;
        reg_dst      : in bit_1;
        mem_addr_src : in bit_2;

        id_ex_rz_addr : out bit_4;
        id_ex_rx_addr : out bit_4;
        id_ex_r_dst   : out bit_4;

        -- Memory
        ex_mem_r_dst : out bit_4;

        -- Writeback
        reg_write    : in bit_1;
        mem_to_reg   : in bit_1;
        mem_wb_r_dst : out bit_4;

        -- Program Memory
        pmem_addr : out bit_16;
        pmem_data : in bit_32;

        -- Data Memory
        dmem_addr    : out bit_16;
        dmem_wr_data : out bit_16;
        dmem_data    : in bit_16
    );
end datapath;

architecture behaviour of datapath is
    -- Instruction Fetch
    signal pc              : bit_16 := (others => '0');
    signal next_pc         : bit_16 := (others => '0');
    signal instruction_reg : bit_32 := (others => '0');
    signal next_pc_reg     : bit_16 := (others => '0');

    -- Instruction Decode
    signal r_addr_z : bit_4  := (others => '0'); -- destination register
    signal r_addr_x : bit_4  := (others => '0'); -- source register
    signal r_addr_y : bit_4  := (others => '0'); -- source register
    signal operand  : bit_16 := (others => '0'); -- immediate value
    signal reg_x    : bit_16 := (others => '0');
    signal reg_z    : bit_16 := (others => '0');

    signal id_ex_reg_x    : bit_16 := (others => '0');
    signal id_ex_reg_z    : bit_16 := (others => '0');
    signal id_ex_operand  : bit_16 := (others => '0');
    signal id_ex_r_addr_z : bit_4  := (others => '0');
    signal id_ex_r_addr_x : bit_4  := (others => '0');
    signal id_ex_r_addr_y : bit_4  := (others => '0');
    signal id_ex_next_pc  : bit_16 := (others => '0');

    signal eq_op_a : bit_16 := (others => '0');
    signal eq_op_b : bit_16 := (others => '0');

    -- Execution
    signal operand_a      : bit_16 := (others => '0');
    signal operand_b      : bit_16 := (others => '0');
    signal operand_b_temp : bit_16 := (others => '0');
    signal operand_a_temp : bit_16 := (others => '0');
    signal alu_result     : bit_16 := (others => '0');
    signal dst_reg        : bit_4  := (others => '0');
    signal wr_data_addr   : bit_16 := (others => '0');

    signal ex_mem_alu_result   : bit_16 := (others => '0');
    signal ex_mem_wr_data_addr : bit_16 := (others => '0');
    signal ex_mem_dst_reg      : bit_4  := (others => '0');

    -- Memory
    signal mem_wb_dst_reg    : bit_4  := (others => '0');
    signal mem_wb_alu_result : bit_16 := (others => '0');
    signal mem_wb_rd_data    : bit_16 := (others => '0');

    -- Writeback
    signal reg_wr_data : bit_16 := (others => '0');
begin
    -- Instruction Fetch
    instruction_fetch : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc              <= (others => '0');
                instruction_reg <= (others => '0');
            else
                -- Update PC
                if pc_write = '1' then
                    case pc_src is
                        when "00" =>
                            pc <= next_pc;
                        when "01" =>
                            pc <= reg_x;
                        when "10" =>
                            pc <= operand;
                        when others =>
                            pc <= next_pc;
                    end case;
                end if;

                -- Update IF/ID Register
                if if_flush = '1' and if_id_write = '1' then
                    instruction_reg <= (others => '0');
                    next_pc_reg     <= (others => '0');
                elsif if_id_write = '1' then
                    instruction_reg <= pmem_data;
                    next_pc_reg     <= next_pc;
                end if;
            end if;
        end if;
    end process;

    pmem_addr <= pc;
    next_pc   <= std_logic_vector(unsigned(pc) + 4);

    -- Instruction Decode
    registerfile_inst : entity work.registerfile
        port map(
            clk           => clk,
            rst           => reset,
            address_a     => r_addr_x,
            address_b     => r_addr_z,
            write_address => mem_wb_dst_reg,
            write_data    => reg_wr_data,
            wren          => reg_write,
            q_a           => reg_x,
            q_b           => reg_z
        );

    instruction_decode : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                id_ex_reg_x    <= (others => '0');
                id_ex_reg_z    <= (others => '0');
                id_ex_operand  <= (others => '0');
                id_ex_r_addr_z <= (others => '0');
                id_ex_r_addr_x <= (others => '0');
                id_ex_r_addr_y <= (others => '0');
                id_ex_next_pc  <= (others => '0');
            else
                id_ex_reg_x    <= reg_x;
                id_ex_reg_z    <= reg_z;
                id_ex_operand  <= operand;
                id_ex_r_addr_z <= r_addr_z;
                id_ex_r_addr_x <= r_addr_x;
                id_ex_r_addr_y <= r_addr_y;
                id_ex_next_pc  <= next_pc_reg;
            end if;
        end if;
    end process;

    -- Forwarding Operand A MUX
    eq_op_a <= reg_x when id_fwd_src_a = '0' else
        ex_mem_alu_result when id_fwd_src_a = '1' else
        (others => '0');

    -- Forwarding Operand B MUX
    eq_op_b <= reg_z when id_fwd_src_b = '0' else
        ex_mem_alu_result when id_fwd_src_b = '1' else
        (others => '0');

    is_equal <= '1' when (eq_op_a = eq_op_b) else
        '0';

    -- To Control Unit
    instruction <= instruction_reg;
    r_addr_z    <= instruction_reg(23 downto 20);
    r_addr_x    <= instruction_reg(19 downto 16);
    r_addr_y    <= instruction_reg(15 downto 12);
    operand     <= instruction_reg(15 downto 0);

    -- Execute

    alu_inst : entity work.alu
        port map(
            operand_a  => operand_a,
            operand_b  => operand_b,
            alu_op     => alu_op,
            alu_result => alu_result
        );

    execution : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                ex_mem_alu_result <= (others => '0');
            else
                ex_mem_alu_result   <= alu_result;
                ex_mem_wr_data_addr <= wr_data_addr;
                ex_mem_dst_reg      <= dst_reg;
            end if;
        end if;
    end process;

    -- To Control Unit
    id_ex_rx_addr <= id_ex_r_addr_x;
    id_ex_rz_addr <= id_ex_r_addr_z;
    id_ex_r_dst   <= dst_reg;

    -- Forwarding Operand A MUX
    operand_a_temp <= id_ex_reg_x when ex_fwd_src_a = "00" else
        ex_mem_alu_result when ex_fwd_src_a = "01" else
        reg_wr_data when ex_fwd_src_a = "10" else
        (others => '0');

    -- Forwarding Operand B MUX
    operand_b_temp <= id_ex_reg_z when ex_fwd_src_b = "00" else
        ex_mem_alu_result when ex_fwd_src_b = "01" else
        reg_wr_data when ex_fwd_src_b = "10" else
        (others => '0');
    operand_a <= operand_a_temp;

    -- ALUsrc B Mux
    operand_b <= operand_b_temp when alu_src = "00" else
        id_ex_operand when alu_src = "01" else
        id_ex_next_pc when alu_src = "10" else
        (others => '0');

    -- RegDst Mux
    dst_reg <= id_ex_r_addr_z when reg_dst = '0' else
        id_ex_r_addr_y when reg_dst = '1' else
        (others => '0');

    -- WriteAddr Mux
    wr_data_addr <= operand_b_temp when mem_addr_src = "00" else
        operand_a_temp when mem_addr_src = "01" else
        id_ex_operand when mem_addr_src = "10" else
        (others => '0');

    -- Memory Access  
    memory : process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                mem_wb_dst_reg    <= (others => '0');
                mem_wb_alu_result <= (others => '0');
                mem_wb_rd_data    <= (others => '0');
            else
                mem_wb_dst_reg    <= ex_mem_dst_reg;
                mem_wb_alu_result <= ex_mem_alu_result;
                mem_wb_rd_data    <= dmem_data;
            end if;
        end if;
    end process;

    -- To Control Unit
    ex_mem_r_dst <= ex_mem_dst_reg;

    dmem_addr    <= ex_mem_wr_data_addr;
    dmem_wr_data <= ex_mem_alu_result;

    -- Writeback
    -- To Control Unit
    mem_wb_r_dst <= mem_wb_dst_reg;

    reg_wr_data <= mem_wb_alu_result when mem_to_reg = '0' else
        mem_wb_rd_data when mem_to_reg = '1' else
        (others => '0');

end behaviour;