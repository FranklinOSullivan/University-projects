library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.TdmaMinTypes.all;
use work.test_utils.all;

use std.textio.all;
use std.env.finish;

entity AvgAsp_tb is
end AvgAsp_tb;

architecture sim of AvgAsp_tb is

    constant clk_hz     : integer := 100e6;
    constant clk_period : time    := 1 sec / clk_hz;

    signal clk  : std_logic     := '1';
    signal rst  : std_logic     := '1';
    signal send : tdma_min_port := (others => (others => '0'));
    signal recv : tdma_min_port := (others => (others => '0'));

    procedure sendToASP(
        signal clk    : in std_logic;
        signal recv   : out tdma_min_port;
        constant data : in std_logic_vector(15 downto 0)
    ) is
        variable temp : std_logic_vector(31 downto 0) := (others => '0');
    begin
        temp(31)          := '1';
        temp(15 downto 0) := data;

        recv.data <= temp;
        wait until rising_edge(clk);
        recv.data <= (others => '0');
    end procedure;
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

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        rst <= '0';

        print("----------------------------------");
        print("Testing AvgAsp");
        print("----------------------------------");

        wait for clk_period;

        -- CONFIG MSG
        recv.data(31 downto 28) <= "1010";
        recv.data(16)           <= '1';  -- Set buffer write buffer to 1
        recv.data(3 downto 0)   <= x"4"; -- Set buffer address with to 2

        wait for clk_period;
        recv.data <= (others => '0');
        wait for clk_period;

        -- ! Average Test 8

        sendToASP(clk, recv, x"0002");
        sendToASP(clk, recv, x"0004");
        sendToASP(clk, recv, x"0006");
        sendToASP(clk, recv, x"0008");
        sendToASP(clk, recv, x"000A");
        sendToASP(clk, recv, x"000C");
        sendToASP(clk, recv, x"000E");
        sendToASP(clk, recv, x"0010");
        sendToASP(clk, recv, x"0012");
        sendToASP(clk, recv, x"0014");
        sendToASP(clk, recv, x"0016");
        sendToASP(clk, recv, x"0018");
        sendToASP(clk, recv, x"001A");
        sendToASP(clk, recv, x"001C");
        sendToASP(clk, recv, x"001E");

        test(send.data = x"00000000", "Average should not be valid", "Average Test 16");

        sendToASP(clk, recv, x"0020");

        wait for clk_period * 0.5;
        test(send.data = x"80000011", "Average 1 is not correct", "Average Test 16");

        sendToASP(clk, recv, x"0022");

        wait for clk_period * 0.5;
        test(send.data = x"80000013", "Average 2 is not correct", "Average Test 16");

        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");

        wait for clk_period * 0.5;
        test(send.data = x"80000000", "Average 3 is not correct", "Average Test 16");
        print("Average Test 16 Passed");

        -- CONFIG MSG
        recv.data(31 downto 28) <= "1010";
        recv.data(16)           <= '1';  -- Set buffer write buffer to 1
        recv.data(3 downto 0)   <= x"3"; -- Set buffer address with to 2

        wait for clk_period;
        recv.data <= (others => '0');
        wait for clk_period;

        -- ! Average Test 8

        sendToASP(clk, recv, x"0002");
        sendToASP(clk, recv, x"0004");
        sendToASP(clk, recv, x"0006");
        sendToASP(clk, recv, x"0008");
        sendToASP(clk, recv, x"000A");
        sendToASP(clk, recv, x"000C");
        sendToASP(clk, recv, x"000E");

        test(send.data = x"00000000", "Average should not be valid", "Average Test 8");

        sendToASP(clk, recv, x"0010");

        wait for clk_period * 0.5;
        test(send.data = x"80000009", "Average 1 is not correct", "Average Test 8");

        sendToASP(clk, recv, x"0012");

        wait for clk_period * 0.5;
        test(send.data = x"8000000B", "Average 2 is not correct", "Average Test 8");

        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");

        wait for clk_period * 0.5;
        test(send.data = x"80000000", "Average 3 is not correct", "Average Test 8");
        print("Average Test 8 Passed");

        -- CONFIG MSG
        recv.data(31 downto 28) <= "1010";
        recv.data(16)           <= '1';  -- Set buffer write buffer to 1
        recv.data(3 downto 0)   <= x"2"; -- Set buffer address with to 2

        wait for clk_period;
        recv.data <= (others => '0');
        wait for clk_period;

        -- ! Average Test 4

        sendToASP(clk, recv, x"0002");
        sendToASP(clk, recv, x"0004");
        sendToASP(clk, recv, x"0006");

        test(send.data = x"00000000", "Average should not be valid", "Average Test 4");

        sendToASP(clk, recv, x"0008");

        wait for clk_period * 0.5;
        test(send.data = x"80000005", "Average 1 is not correct", "Average Test 4");
        sendToASP(clk, recv, x"000A");

        wait for clk_period * 0.5;
        test(send.data = x"80000007", "Average 2 is not correct", "Average Test 4");

        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");

        wait for clk_period * 0.5;

        test(send.data = x"80000000", "Average 3 is not correct", "Average Test 4");

        print("Average Test 4 Passed");
        -- CONFIG MSG
        recv.data(31 downto 28) <= "1010";
        recv.data(16)           <= '1';  -- Set buffer write buffer to 1
        recv.data(3 downto 0)   <= x"3"; -- Set buffer address with to 2

        wait for clk_period;
        recv.data <= (others => '0');
        wait for clk_period;

        -- ! Average Test Random Data Rate

        sendToASP(clk, recv, x"0002");
        sendToASP(clk, recv, x"0004");
        sendToASP(clk, recv, x"0006");
        sendToASP(clk, recv, x"0008");

        wait for clk_period * 20;

        test(send.data = x"00000000", "Average should not be valid 1", "Average Test Random Data Rate");

        sendToASP(clk, recv, x"000A");
        sendToASP(clk, recv, x"000C");

        wait for clk_period * 3;

        test(send.data = x"00000000", "Average should not be valid 2", "Average Test Random Data Rate");

        sendToASP(clk, recv, x"000E");

        wait for clk_period * 1;

        test(send.data = x"00000000", "Average should not be valid 2", "Average Test Random Data Rate");

        sendToASP(clk, recv, x"0010");

        wait for clk_period * 0.5;
        test(send.data = x"80000009", "Average 1 is not correct", "Average Test Random Data Rate");

        sendToASP(clk, recv, x"0012");

        wait for clk_period * 0.5;
        test(send.data = x"8000000B", "Average 2 is not correct", "Average Test Random Data Rate");

        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");
        sendToASP(clk, recv, x"0000");

        wait for clk_period * 0.5;
        test(send.data = x"80000000", "Average 3 is not correct", "Average Test Random Data Rate");
        print("Average Test Random Data Rate");

        --! Test Reset

        rst <= '1';

        wait for clk_period * 1.5;
        test(send.data = x"00000000", "Average should not be valid", "Reset Test");

        rst <= '0';

        print("Reset Test Passed");

        wait for clk_period * 0.5;

        print("----------------------------------");
        print("All tests passed");
        print("----------------------------------");
        finish;
    end process;

end architecture;