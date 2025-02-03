library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.TdmaMinTypes.all;
use work.test_utils.all;

use std.textio.all;
use std.env.finish;

entity AvgAspWave_tb is
end AvgAspWave_tb;

architecture sim of AvgAspWave_tb is

    constant clk_hz     : integer := 100e6;
    constant clk_period : time    := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

    signal send : tdma_min_port := (others => (others => '0'));
    signal recv : tdma_min_port := (others => (others => '0'));

    signal addr        : integer               := 0;
    signal input_data  : unsigned(15 downto 0) := (others => '0');
    signal output_data : unsigned(15 downto 0) := (others => '0');
begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.AvgAsp
        generic map(
            MAX_ADDRESS_WIDTH => 5
        )
        port map(
            clk  => clk,
            rst  => rst,
            send => send,
            recv => recv
        );

    test_adc : entity work.power_signal_rom
        port map(
            clk      => clk,
            address  => addr,
            data_out => input_data
        );

    recv.data   <= "1000000000000000" & std_logic_vector(input_data);
    output_data <= unsigned(send.data(15 downto 0));

    address : process
    begin
        addr <= (addr + 1) mod 1599;
        wait for clk_period;
    end process;

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 1;
        rst <= '0';
        wait;
    end process;

end architecture;