library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.recop_types.all;

entity recop_tb is
end recop_tb;

architecture sim of recop_tb is

    constant clk_hz     : integer := 50e6;
    constant clk_period : time    := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

    signal sw   : std_logic_vector(9 downto 0)  := (others => '0');
    signal ledr : std_logic_vector(9 downto 0)  := (others => '0');
    signal hex0 : std_logic_vector(6 downto 0)  := (others => '0');
    signal hex1 : std_logic_vector(6 downto 0)  := (others => '0');
    signal hex2 : std_logic_vector(6 downto 0)  := (others => '0');
    signal hex3 : std_logic_vector(6 downto 0)  := (others => '0');
    signal hex4 : std_logic_vector(6 downto 0)  := (others => '0');
    signal hex5 : std_logic_vector(6 downto 0)  := (others => '0');
    signal send : std_logic_vector(31 downto 0) := (others => '0');
    signal recv : std_logic_vector(31 downto 0) := (others => '0');
begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.recop
        generic map(
            pmem_init_file => "./code/bin/noc.mif"
        )
        port map(
            clock => clk,
            reset => rst,
            sw    => sw,
            ledr  => ledr,
            hex0  => hex0,
            hex1  => hex1,
            hex2  => hex2,
            hex3  => hex3,
            hex4  => hex4,
            hex5  => hex5,
            send  => send,
            recv  => recv
        );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 1;

        rst <= '0';
        sw  <= "0000110010";

        wait for clk_period * 10;

        recv <= x"FFFF1234";
        wait for clk_period / 2;
        recv <= (others => '0');
        wait for clk_period / 2;
        recv <= x"F1234567";
        wait for clk_period / 2;
        recv <= (others => '0');
        wait for clk_period / 2;
        recv <= x"F0000001";
        wait for clk_period / 2;
        recv <= (others => '0');
    end process;

end architecture;