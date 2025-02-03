library ieee;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
library work;
use work.TdmaMinTypes.all;

entity PdAsp is
    generic (
        INITAL_SEND_ADDR : std_logic_vector(3 downto 0) := (others => '0')
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        recv  : in tdma_min_port;
        send  : out tdma_min_port := (others => (others => '0'))
    );
end entity;

architecture peak_detection of PdAsp is

    constant DATA_CORRELATION : std_logic_vector(3 downto 0) := "1000";
    constant PD_ASP           : std_logic_vector(3 downto 0) := "1100";

    signal current_correlation      : std_logic_vector(15 downto 0) := (others => '0');
    signal previous_correlation     : std_logic_vector(15 downto 0) := (others => '0');
    signal count                    : std_logic_vector(15 downto 0) := (others => '0');
    signal correlation_count_signal : std_logic_vector(15 downto 0) := (others => '0');
    signal send_flag                : std_logic                     := '0';
    signal invert_signal            : std_logic                     := '0';
    type edge_type is (positive_edge, negative_edge);
    signal edge : edge_type := positive_edge;

begin
    state_transition : process (clk)
    begin
        if rising_edge(clk) then

            previous_correlation <= current_correlation;
            send_flag            <= '0';
            invert_signal        <= '0';

            if recv.data(31 downto 28) = DATA_CORRELATION then
                current_correlation <= recv.data(15 downto 0);
                count               <= count + 1;
            elsif (recv.data(31 downto 28) = PD_ASP) then
                if recv.data(16) = '1' then
                    invert_signal <= recv.data(0);
                end if;
            end if;

            if reset = '1' then
                previous_correlation     <= (others => '0');
                count                    <= (others => '0');
                edge                     <= positive_edge;
                correlation_count_signal <= (others => '0');
            end if;

            if invert_signal = '0' then
                if edge = positive_edge then                        -- CURRENT STATE == POSITIVE EDGE 
                    if current_correlation >= previous_correlation then -- SELF LOOP CONDITION 
                        edge <= positive_edge;
                    elsif current_correlation < previous_correlation then -- STATE TRANSITION CONDITION 
                        send_flag                <= '1';
                        correlation_count_signal <= count;
                        count                    <= (others => '0');
                        edge                     <= negative_edge;
                    end if;
                elsif edge = negative_edge then                     -- CURRENT STATE == NEGATIVE EDGE 
                    if current_correlation <= previous_correlation then -- SELF LOOP CONDITION 
                        edge                   <= negative_edge;
                    elsif current_correlation > previous_correlation then -- STATE TRANSITION CONDITION 
                        edge <= positive_edge;
                    end if;
                end if;

            elsif invert_signal = '1' then
                if edge = positive_edge then                        -- CURRENT STATE == POSITIVE EDGE 
                    if current_correlation >= previous_correlation then -- SELF LOOP CONDITION 
                        edge <= positive_edge;
                    elsif current_correlation < previous_correlation then -- STATE TRANSITION CONDITION 
                        edge <= negative_edge;
                    end if;

                elsif edge = negative_edge then                     -- CURRENT STATE == NEGATIVE EDGE 
                    if current_correlation <= previous_correlation then -- SELF LOOP CONDITION 
                        edge                   <= negative_edge;

                    elsif current_correlation > previous_correlation then -- STATE TRANSITION CONDITION 
                        correlation_count_signal <= count;
                        count                    <= (others => '0');
                        edge                     <= positive_edge;
                    end if;
                end if;
            end if;
        end if;
    end process;

    send_out : process (clk, current_correlation, send_flag)
    begin
        if rising_edge(clk) then

            if send_flag = '1' then
                send.data(31 downto 28) <= DATA_CORRELATION;
                send.data(27 downto 16) <= (others => '0');
                send.data(15 downto 0)  <= correlation_count_signal;
                send.addr               <= x"0" & INITAL_SEND_ADDR;

            else
                send.data <= (others => '0');
                send.addr <= (others => '0');
            end if;
        end if;
    end process;

end architecture;