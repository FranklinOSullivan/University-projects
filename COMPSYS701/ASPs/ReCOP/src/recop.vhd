------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.recop_types.all;

entity recop is
    generic (
        pmem_init_file : string := "./code/output.mif"
    );
    port (
        clock : in std_logic;
        reset : in std_logic;
        sw    : in std_logic_vector(9 downto 0);
        ledr  : out std_logic_vector(9 downto 0);
        hex0  : out std_logic_vector(6 downto 0);
        hex1  : out std_logic_vector(6 downto 0);
        hex2  : out std_logic_vector(6 downto 0);
        hex3  : out std_logic_vector(6 downto 0);
        hex4  : out std_logic_vector(6 downto 0);
        hex5  : out std_logic_vector(6 downto 0);
        send  : out std_logic_vector(31 downto 0);
        recv  : in std_logic_vector(31 downto 0)
    );
end recop;

architecture synthesis of recop is
    signal clk   : bit_1 := '0';
    signal clk_n : bit_1 := '0';

    signal pc_src        : bit_2    := (others => '0');
    signal pc_write      : bit_1    := '0';
    signal if_flush      : bit_1    := '0';
    signal if_id_write   : bit_1    := '0';
    signal instruction   : bit_32   := (others => '0');
    signal id_fwd_src_a  : bit_1    := '0';
    signal id_fwd_src_b  : bit_1    := '0';
    signal is_equal      : bit_1    := '0';
    signal alu_op        : alu_op_t := ALU_ADD;
    signal ex_fwd_src_a  : bit_2    := (others => '0');
    signal ex_fwd_src_b  : bit_2    := (others => '0');
    signal alu_src       : bit_2    := (others => '0');
    signal reg_dst       : bit_1    := '0';
    signal mem_addr_src  : bit_2    := (others => '0');
    signal id_ex_rz_addr : bit_4    := (others => '0');
    signal id_ex_rx_addr : bit_4    := (others => '0');
    signal id_ex_r_dst   : bit_4    := (others => '0');
    signal ex_mem_r_dst  : bit_4    := (others => '0');
    signal reg_write     : bit_1    := '0';
    signal mem_to_reg    : bit_1    := '0';
    signal mem_wb_r_dst  : bit_4    := (others => '0');

    signal pmem_addr : bit_16 := (others => '0');
    signal pmem_data : bit_32 := (others => '0');

    signal dmem_addr    : bit_16 := (others => '0');
    signal dmem_wr_data : bit_16 := (others => '0');
    signal dmem_data    : bit_16 := (others => '0');

    signal mem_write : bit_1 := '0';
    signal datacall  : bit_1 := '0';
    signal pop       : bit_1 := '0';

    signal mem_wren    : bit_1 := '0';
    signal mem_io_wren : bit_1 := '0';

    signal data_mem_data : bit_16 := (others => '0');
    signal mem_io_data   : bit_16 := (others => '0');
begin
    datapath_inst : entity work.datapath
        port map(
            clk   => clk,
            reset => reset,
            -- Instruction Fetch
            pc_src      => pc_src,
            pc_write    => pc_write,
            if_flush    => if_flush,
            if_id_write => if_id_write,
            -- Instruction Decode
            instruction  => instruction,
            id_fwd_src_a => id_fwd_src_a,
            id_fwd_src_b => id_fwd_src_b,
            is_equal     => is_equal,
            -- Execute
            alu_op       => alu_op,
            ex_fwd_src_a => ex_fwd_src_a,
            ex_fwd_src_b => ex_fwd_src_b,
            alu_src      => alu_src,
            reg_dst      => reg_dst,
            mem_addr_src => mem_addr_src,

            id_ex_rz_addr => id_ex_rz_addr,
            id_ex_rx_addr => id_ex_rx_addr,
            id_ex_r_dst   => id_ex_r_dst,

            -- Memory
            ex_mem_r_dst => ex_mem_r_dst,

            -- Writeback
            reg_write    => reg_write,
            mem_to_reg   => mem_to_reg,
            mem_wb_r_dst => mem_wb_r_dst,

            -- Program Memory
            pmem_addr => pmem_addr,
            pmem_data => pmem_data,

            -- Data Memory
            dmem_addr    => dmem_addr,
            dmem_wr_data => dmem_wr_data,
            dmem_data    => dmem_data
        );

    control_unit_inst : entity work.control_unit
        port map(
            clk   => clk,
            reset => reset,
            -- Instruction Fetch
            pc_src      => pc_src,
            pc_write    => pc_write,
            if_flush    => if_flush,
            if_id_write => if_id_write,
            -- Instruction Decode
            instruction  => instruction,
            id_fwd_src_a => id_fwd_src_a,
            id_fwd_src_b => id_fwd_src_b,
            is_equal     => is_equal,
            -- Execute
            alu_op       => alu_op,
            ex_fwd_src_a => ex_fwd_src_a,
            ex_fwd_src_b => ex_fwd_src_b,
            alu_src      => alu_src,
            reg_dst      => reg_dst,
            mem_addr_src => mem_addr_src,

            id_ex_rz_addr => id_ex_rz_addr,
            id_ex_rx_addr => id_ex_rx_addr,
            id_ex_r_dst   => id_ex_r_dst,

            -- Memory
            ex_mem_r_dst => ex_mem_r_dst,
            -- Writeback
            reg_write    => reg_write,
            mem_to_reg   => mem_to_reg,
            mem_wb_r_dst => mem_wb_r_dst,
            -- Data Memory
            mem_write => mem_write,
            datacall  => datacall,
            pop       => pop
        );

    clk_n <= not clk;

    prog_mem : entity work.prog_mem
        generic map(
            init_file => pmem_init_file
        )
        port map(
            address => pmem_addr(15 downto 2),
            clock   => clk_n,
            q       => pmem_data
        );

    data_mem : entity work.data_mem
        port map(
            address => dmem_addr(14 downto 1),
            clock   => clk_n,
            data    => dmem_wr_data,
            wren    => mem_wren,
            q       => data_mem_data
        );

    mem_io : entity work.mem_io
        port map(
            clk      => clk,
            reset    => reset,
            wren     => mem_io_wren,
            datacall => datacall,
            pop      => pop,
            addr     => dmem_addr,
            data_in  => dmem_wr_data,
            data_out => mem_io_data,
            switches => sw,
            ledr     => ledr,
            hex0     => hex0,
            hex1     => hex1,
            hex2     => hex2,
            hex3     => hex3,
            hex4     => hex4,
            hex5     => hex5,
            to_noc   => send,
            from_noc => recv
        );

    memory_arbiter : entity work.memory_arbiter
        port map(
            clk         => clk,
            reset       => reset,
            addr_bit    => dmem_addr(15),
            wren        => mem_write,
            mem_wren    => mem_wren,
            mem_io_wren => mem_io_wren,
            mem_data    => data_mem_data,
            mem_io_data => mem_io_data,
            data_out    => dmem_data
        );
    -- If bit 15 in the dmem_addr = 1
    -- Use memory mapped I/O instead of mem
    -- Make new 'reg_file' with addresses for (NOC, 7seg, buttons)
    -- Then we can read and write to specific addresses (read the buttons or switches)
    -- This will require an arbiter, if the bit 15 is 1, set to write to one place, else the other (only one write enable can be high at once) 
    -- I/O

    recop_pll_inst : entity work.recop_pll
        port map(
            inclk0 => clock,
            c0     => clk
        );

end architecture synthesis;