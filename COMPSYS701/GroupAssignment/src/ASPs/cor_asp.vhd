library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
library work;
use work.TdmaMinTypes.all;

entity CorAsp is
    generic (
        INITAL_SEND_ADDR : std_logic_vector(3 downto 0) := x"0"
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;
        recv  : in tdma_min_port;
        send  : out tdma_min_port := (others => (others => '0'))
    );
end entity;

architecture Behavioral of CorAsp is
    constant COR_ASP_ADDRESS : std_logic_vector(3 downto 0) := "1011";
    constant DATA_TYPE_DATA  : std_logic_vector(3 downto 0) := "1000";
    constant NIOS_II_ADDRESS : std_logic_vector(3 downto 0) := "1101";
    signal send_addr         : std_logic_vector(3 downto 0) := INITAL_SEND_ADDR;
    signal WINDOW_SIZE       : integer                      := 80;
    constant INPUT_SIZE      : integer                      := 16;

    type sample_array is array (0 to 159) of unsigned((INPUT_SIZE - 1) downto 0); -- Maximum window size of 160
    signal sample        : unsigned((INPUT_SIZE - 1) downto 0) := (others => '0');
    signal corr_result   : unsigned((INPUT_SIZE - 1) downto 0) := (others => '0');
    signal samples       : sample_array                        := (others => (others => '0'));
    signal index         : integer                             := 0;
    signal buffer_filled : boolean                             := FALSE;
    signal sum           : unsigned(63 downto 0)               := (others => '0');

    signal op_1_index : integer := 0;
    signal op_2_index : integer := 0;

    signal mul_index  : integer := 0;
    signal mul_done   : boolean := FALSE;
    signal new_sample : boolean := FALSE;
begin

    noc_receive : process (clk)
    begin
        if rising_edge(clk) then
            if recv.data(31 downto 28) = DATA_TYPE_DATA then
                -- Check if the data is valid and not the same as the previous sample
                if sample /= unsigned(recv.data((INPUT_SIZE - 1) downto 0)) and recv.data /= X"00000000" then
                    new_sample <= TRUE;
                    sample     <= unsigned(recv.data((INPUT_SIZE - 1) downto 0));
                end if;
            else
                new_sample <= FALSE;
            end if;
            if recv.addr = COR_ASP_ADDRESS then
                if (recv.data(19) = '1') then
                    send_addr <= recv.data(23 downto 20);
                end if;
                if (recv.data(16) = '1') then
                    WINDOW_SIZE <= to_integer(unsigned(recv.data(15 downto 0)));
                end if;
            end if;
        end if;
    end process;

    calc_corr : process (clk, reset)
    begin
        if reset = '1' then
            -- Reset all signals and variables
            index         <= 0;
            samples       <= (others => (others => '0'));
            buffer_filled <= FALSE;
            sum           <= (others => '0');
            mul_index     <= 0;
            mul_done      <= FALSE;
        elsif rising_edge(clk) then
            if new_sample then
                index <= (index + 1);
                if index >= WINDOW_SIZE - 1 then
                    index <= 0;
                end if;
                samples(index) <= sample((INPUT_SIZE - 1) downto 0); -- Store the incoming sample at the current index
                if index = WINDOW_SIZE - 1 then
                    buffer_filled <= TRUE; -- Set full flag to start processing
                end if;
            end if;
            send <= (others => (others => '0'));

            if buffer_filled then
                if not mul_done then
                    -- Set the indexes for the multiplication
                    if index + mul_index >= WINDOW_SIZE then
                        op_1_index <= (index + mul_index) - WINDOW_SIZE;
                    else
                        op_1_index <= (index + mul_index);
                    end if;
                    if (index - mul_index) < 1 then
                        op_2_index <= (index - mul_index - 1) + WINDOW_SIZE;
                    else
                        op_2_index <= (index - mul_index - 1);
                    end if;

                    -- Perform the multiplication and add to the sum
                    sum <= sum + resize(samples(op_1_index) * samples(op_2_index), 64);

                    -- increment the mul_index
                    if mul_index = (WINDOW_SIZE / 2) - 1 then
                        mul_done  <= TRUE;
                        mul_index <= 0;
                    else
                        mul_index <= mul_index + 1;
                    end if;
                elsif new_sample then
                    corr_result                          <= resize(sum srl 14, 16);
                    send.data(31 downto 28)              <= DATA_TYPE_DATA;
                    send.data(27 downto 16)              <= (others => '0');
                    send.data((INPUT_SIZE - 1) downto 0) <= std_logic_vector(corr_result);
                    send.addr                            <= x"0" & send_addr;
                    -- Reset for next calculation
                    mul_done <= FALSE;
                    sum      <= (others => '0');
                end if;
            end if;
        end if;
    end process;

end Behavioral;