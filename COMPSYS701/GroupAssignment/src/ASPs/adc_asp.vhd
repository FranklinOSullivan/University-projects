-- Author: Franklin O'Sullivan
-- Date: 20/06/24
-- ADC-ASP
-- This ASP is used to take ADC readings at regular intervals and store them into memory. 
-- The memory and top address are shared between multiple ASPs
-- Assuming a memory width of 16 bits and an address width of 14 bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.TdmaMinTypes.all;

library altera_mf;
use altera_mf.all;

-- const configHeader : STD_LOGIC_VECTOR(3 downto 0) := "1001";
-- const nextaddr : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";

entity AdcAsp is
    generic (
        INITAL_SEND_ADDR : std_logic_vector(3 downto 0) := x"0"
    );
    port (
        clk   : in std_logic;
        reset : in std_logic;

        recv : in tdma_min_port;
        send : out tdma_min_port
    );
end entity;

architecture behav of AdcAsp is
    constant DATAWIDTH    : integer := 13;
    constant ADDRWIDTH    : integer := 12;
    constant SAMPLINGFREQ : integer := 3124;
    constant MAXMEMSIZE   : integer := 1600; -- 5 cycles

    component altsyncram
        generic (
            clock_enable_input_a   : string;
            clock_enable_output_a  : string;
            init_file              : string;
            intended_device_family : string;
            lpm_hint               : string;
            lpm_type               : string;
            numwords_a             : natural;
            operation_mode         : string;
            outdata_aclr_a         : string;
            outdata_reg_a          : string;
            power_up_uninitialized : string;
            ram_block_type         : string;
            widthad_a              : natural;
            width_a                : natural;
            width_byteena_a        : natural
        );
        port (
            clock0    : in std_logic;
            address_a : in std_logic_vector(11 downto 0);
            wren_a    : in std_logic;
            data_a    : in std_logic_vector(DATAWIDTH - 1 downto 0);
            q_a       : out std_logic_vector((DATAWIDTH - 1) downto 0)
        );
    end component;

    signal ramAddr     : std_logic_vector(11 downto 0)              := (others => '0');
    signal currentData : std_logic_vector((DATAWIDTH - 1) downto 0) := (others => '0');

    signal clk_n      : std_logic                                := '1';
    signal ram_wren   : std_logic                                := '0';
    signal ram_w_addr : std_logic_vector(ADDRWIDTH - 1 downto 0) := (others => '0');
    signal ram_data   : std_logic_vector(DATAWIDTH - 1 downto 0) := (others => '0');
    signal ramMaxAddr : std_logic_vector(11 downto 0)            := conv_std_logic_vector(MAXMEMSIZE, 12);

    signal ramAccessAddr : std_logic_vector(ADDRWIDTH - 1 downto 0);

    signal samplingRateCounter : integer := 0;

    signal dataOuputWidth : integer := 8;

    signal adc_data  : std_logic_vector((DATAWIDTH - 1) downto 0) := (others => '0');
    signal send_addr : std_logic_vector(3 downto 0)               := INITAL_SEND_ADDR;

begin
    config : process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                -- Reset
                send_addr <= INITAL_SEND_ADDR;
                ram_wren  <= '0';
            elsif recv.data(31 downto 28) = "1001" then
                ram_wren <= '0';
                -- Handle input data
                -- Set Send Addresss
                if recv.data(19) = '1' then
                    send_addr <= recv.data(23 downto 20);
                    -- Data config
                elsif recv.data(18) = '1' then
                    ramMaxAddr <= recv.data(ADDRWIDTH - 1 downto 0);
                    ram_w_addr <= conv_std_logic_vector(0, ADDRWIDTH);
                    -- Data message
                elsif recv.data(17) = '1' then
                    ram_wren   <= '1';
                    ram_data   <= recv.data(DATAWIDTH - 1 downto 0);
                    ram_w_addr <= ramAddr + conv_std_logic_vector(1, ADDRWIDTH);
                    if ram_w_addr > ramMaxAddr - 1 then
                        ram_w_addr <= conv_std_logic_vector(0, ADDRWIDTH);
                    end if;
                    -- Data width
                elsif recv.data(16) = '1' then
                    if recv.data(15 downto 0) = conv_std_logic_vector(8, 16) then
                        -- 8 bits
                        dataOuputWidth <= 8;
                    elsif recv.data(15 downto 0) = conv_std_logic_vector(10, 16) then
                        -- 10 bits
                        dataOuputWidth <= 10;
                    elsif recv.data(15 downto 0) = conv_std_logic_vector(12, 16) then
                        -- 12 bits
                        dataOuputWidth <= 12;
                    end if;
                end if;
            end if;
        end if;
    end process;

    clk_n <= not clk;
    altsyncram_component : altsyncram
    generic map(
        clock_enable_input_a   => "BYPASS",
        clock_enable_output_a  => "BYPASS",
        init_file              => "./power_signals/power_signal_12bit_5cycles.mif",
        intended_device_family => "Cyclone V",
        lpm_hint               => "ENABLE_RUNTIME_MOD=NO",
        lpm_type               => "altsyncram",
        numwords_a             => MAXMEMSIZE,
        operation_mode         => "SINGLE_PORT",
        outdata_aclr_a         => "NONE",
        outdata_reg_a          => "UNREGISTERED",
        power_up_uninitialized => "FALSE",
        ram_block_type         => "M4K",
        widthad_a              => ADDRWIDTH,
        width_a                => DATAWIDTH,
        width_byteena_a        => 1
    )
    port map(
        clock0    => clk_n,
        address_a => ramAccessAddr,
        wren_a    => ram_wren,
        data_a    => ram_data,
        q_a       => currentData
    );

    datahandle : process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                -- Reset
                samplingRateCounter <= 0;
                send.data           <= (others => '0');
                send.addr           <= (others => '0');
                ramAddr             <= (others => '0');
            else
                samplingRateCounter <= samplingRateCounter + 1;
                if (samplingRateCounter = SAMPLINGFREQ) then
                    samplingRateCounter <= 0;
                    send.data           <= "1000" & "0010" & "0011" & "0000" & "000" & adc_data; -- Data message, 2, 3, no extra
                    send.addr           <= x"0" & send_addr;
                    -- Update address only reading one byte at a time
                    ramAddr <= ramAddr + conv_std_logic_vector(1, 12);
                    if ramAddr >= ramMaxAddr - 1 then
                        ramAddr <= conv_std_logic_vector(0, 12);
                    end if;
                else
                    send.data <= (others => '0');
                    send.addr <= (others => '0');
                end if;
            end if;
        end if;
    end process;

    adc_data <= currentData when dataOuputWidth = 12 else
        currentData((DATAWIDTH - 1) downto 2) & "00" when dataOuputWidth = 10 else
        currentData((DATAWIDTH - 1) downto 4) & "0000" when dataOuputWidth = 8 else
        (others => '0');

    ramAccessAddr <= ram_w_addr when ram_wren = '1' else
        ramAddr;
end architecture;