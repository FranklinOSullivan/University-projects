------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.recop_types.all;

entity memory_arbiter is
    port (
        clk         : in bit_1   := '1';
        reset       : in bit_1   := '0';
        addr_bit    : in bit_1   := '0';
        wren        : in bit_1   := '0';
        mem_wren    : out bit_1  := '0';
        mem_io_wren : out bit_1  := '0';
        mem_data    : in bit_16  := (others => '0');
        mem_io_data : in bit_16  := (others => '0');
        data_out    : out bit_16 := x"FFFF"
    );
end entity;

architecture behav of memory_arbiter is
begin
    mem_wren    <= (not addr_bit) and wren;
    mem_io_wren <= addr_bit and wren;
    data_out    <= mem_data when addr_bit = '0' else
        mem_io_data when addr_bit = '1' else
        (others => '0');
end architecture;