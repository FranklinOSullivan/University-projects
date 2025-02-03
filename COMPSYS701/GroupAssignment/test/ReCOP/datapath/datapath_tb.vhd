library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.recop_types.all;
use work.test_utils.all;

use std.textio.all;
use std.env.finish;

entity datapath_tb is
end datapath_tb;

architecture sim of datapath_tb is

    constant clk_hz     : integer := 50e6;
    constant clk_period : time    := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

    -- Outputs
    signal instruction   : bit_32;
    signal is_equal      : bit_1; -- For branching
    signal id_ex_rz_addr : bit_4; -- Forwarding
    signal id_ex_rx_addr : bit_4; -- Forwarding
    signal id_ex_r_dst   : bit_4; -- Hazard detection
    signal ex_mem_r_dst  : bit_4; -- Hazard detection
    signal mem_wb_r_dst  : bit_4; -- Hazard detection

    signal pmem_addr    : bit_16;
    signal dmem_addr    : bit_16;
    signal dmem_wr_data : bit_16;
    -- Inputs
    signal pc_src       : bit_2    := (others => '0');
    signal pc_write     : bit_1    := '0';
    signal if_flush     : bit_1    := '0';
    signal if_id_write  : bit_1    := '0';
    signal id_fwd_src_a : bit_1    := '0';
    signal id_fwd_src_b : bit_1    := '0';
    signal alu_op       : alu_op_t := ALU_ADD;
    signal ex_fwd_src_a : bit_2    := (others => '0');
    signal ex_fwd_src_b : bit_2    := (others => '0');
    signal alu_src      : bit_2    := (others => '0');
    signal reg_dst      : bit_1    := '0';
    signal mem_addr_src : bit_2    := (others => '0');
    signal reg_write    : bit_1    := '0';
    signal mem_to_reg   : bit_1    := '0';

    signal pmem_data : bit_32;
    signal dmem_data : bit_16;
begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.datapath
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
            pmem_addr     => pmem_addr,
            pmem_data     => pmem_data,
            dmem_addr     => dmem_addr,
            dmem_wr_data  => dmem_wr_data,
            dmem_data     => dmem_data
        );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        rst      <= '0';
        pc_write <= '1';

        wait for clk_period;

        print("----------------------------------------------");
        print("Datapath Test");
        print("----------------------------------------------");

        ----------------------------------------------
        --! Test PC
        test(pmem_addr = x"0000", "PC incorrect", "PC (initial)");
        wait for clk_period;
        test(pmem_addr = x"0004", "PC incorrect", "PC (after 1 cycle)");
        wait for clk_period;
        test(pmem_addr = x"0008", "PC incorrect", "PC (after 2 cycles)");
        wait for clk_period;
        test(pmem_addr = x"000C", "PC incorrect", "PC (after 3 cycles)");

        print("PC count incrementing correctly");

        print("----------------------------------------------");
        finish;
    end process SEQUENCER_PROC;

end sim;