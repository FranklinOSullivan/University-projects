---------------------------------------------------------------------
-- Average ASP
-- This module calculates the average of a window of samples
-- The max window size is determined by the MAX_ADDRESS_WIDTH generic
-- The window size can be changed by sending a configuration message
-- By Dylan Chamberlain
----------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library work;
use work.TdmaMinTypes.all;

entity AvgAsp is
    generic (
        MAX_ADDRESS_WIDTH : integer := 8 -- The Maximum Window Address Width, WINDOW_SIZE =(2^MAX_ADDRESS_WIDTH)
    );
    port (
        clk  : in std_logic;
        rst  : in std_logic;
        send : out tdma_min_port := (others => (others => '0'));
        recv : in tdma_min_port
    );
end entity;

architecture rtl of AvgAsp is
    constant DATA_TYPE_CONFIG : std_logic_vector(3 downto 0) := "1010";
    constant DATA_TYPE_AUDIO  : std_logic_vector(3 downto 0) := "1000";
    constant WINDOW_SIZE      : integer                      := 2 ** MAX_ADDRESS_WIDTH;

    type buffer_t is array (0 to WINDOW_SIZE) of unsigned(15 downto 0);

    signal buf     : buffer_t                                  := (others => (others => '0'));
    signal index   : unsigned(15 downto 0)                     := (others => '0');
    signal total   : unsigned(15 + MAX_ADDRESS_WIDTH downto 0) := (others => '0');
    signal address : unsigned(3 downto 0)                      := "0001";

    signal address_width : unsigned(3 downto 0)                 := to_unsigned(MAX_ADDRESS_WIDTH, 4);
    signal buffer_size   : unsigned(MAX_ADDRESS_WIDTH downto 0) := to_unsigned(WINDOW_SIZE, MAX_ADDRESS_WIDTH + 1);
    signal buffer_rst    : std_logic                            := '0';

    signal valid : std_logic := '0';
begin

    config : process (clk)
        variable new_address_width : unsigned(3 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then
            if recv.data(31 downto 28) = DATA_TYPE_CONFIG then
                if (recv.data(19) = '1') then
                    address <= unsigned(recv.data(23 downto 20));
                end if;

                if (recv.data(16) = '1') then -- New Buffer Size Message
                    new_address_width := unsigned(recv.data(3 downto 0));

                    if (new_address_width <= MAX_ADDRESS_WIDTH and new_address_width > 0) then

                        address_width <= new_address_width;
                        buffer_size   <= unsigned(to_unsigned(1, MAX_ADDRESS_WIDTH + 1) sll to_integer(new_address_width));
                        buffer_rst    <= '1';
                    else
                        buffer_rst <= '0';
                    end if;
                else
                    buffer_rst <= '0';
                end if;
            else
                buffer_rst <= '0';
            end if;
        end if;
    end process;

    averager : process (clk)
        variable new_total  : unsigned(15 + MAX_ADDRESS_WIDTH downto 0);
        variable filtered   : unsigned(15 + MAX_ADDRESS_WIDTH downto 0);
        variable temp_valid : std_logic := '0';
    begin
        if rising_edge(clk) then
            if rst = '1' or buffer_rst = '1' then
                buf   <= (others => (others => '0'));
                index <= (others => '0');
                total <= (others => '0');
                valid <= '0';

                send.data(31 downto 0) <= (others => '0');
                send.addr              <= (others => '0');

            elsif recv.data(31 downto 28) = DATA_TYPE_AUDIO then

                -- Calculate the new total
                new_total := total + unsigned(recv.data(15 downto 0)) - buf(to_integer(index));
                -- Update the buffer
                buf(to_integer(index)) <= unsigned(recv.data(15 downto 0));
                -- Update the address
                if index >= (buffer_size - 1) then
                    index <= (others => '0');
                    valid <= '1';
                    temp_valid := '1';
                else
                    temp_valid := '0';
                    index <= index + 1;
                end if;

                -- Update the total
                total <= new_total;
                -- Update the output data
                filtered := new_total srl to_integer(address_width);
                if valid = '1' or temp_valid = '1' then
                    send.data(31 downto 28) <= DATA_TYPE_AUDIO;
                    send.data(27 downto 16) <= (others => '0');

                    send.data(15 downto 0) <= std_logic_vector(filtered(15 downto 0));
                    send.addr              <= x"0" & std_logic_vector(address);
                else
                    send.data(31 downto 0) <= (others => '0');
                    send.addr              <= (others => '0');
                end if;
            else
                send.data(31 downto 0) <= (others => '0');
                send.addr              <= (others => '0');
            end if;
        end if;
    end process;
end architecture;