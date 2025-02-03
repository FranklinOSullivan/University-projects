-- Author: Franklin O'Sullivan
-- Date: 20/06/24

-- ADC-ASP
-- This ASP is used to take ADC readings at regular intervals and store them into memory. 
-- The memory and top address are shared between multiple ASPs
-- Assuming a memory width of 16 bits and an address width of 14 bits

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

LIBRARY work;
USE work.constants_pkg.ALL;
USE work.TdmaMinTypes.ALL;

LIBRARY altera_mf;
USE altera_mf.ALL;

-- const configHeader : STD_LOGIC_VECTOR(3 downto 0) := "1001";
-- const nextaddr : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";
ENTITY adcasp IS
    PORT (
        clk   : IN STD_LOGIC;
        reset : IN STD_LOGIC;

        recv : IN tdma_min_port;
        send : OUT tdma_min_port
    );
END ENTITY;
ARCHITECTURE behav OF adcasp IS
    COMPONENT altsyncram
        GENERIC (
            clock_enable_input_a   : STRING;
            clock_enable_output_a  : STRING;
            init_file              : STRING;
            intended_device_family : STRING;
            lpm_hint               : STRING;
            lpm_type               : STRING;
            numwords_a             : NATURAL;
            operation_mode         : STRING;
            outdata_aclr_a         : STRING;
            outdata_reg_a          : STRING;
            widthad_a              : NATURAL;
            width_a                : NATURAL;
            width_byteena_a        : NATURAL
        );
        PORT (
            clock0    : IN STD_LOGIC;
            address_a : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            q_a       : OUT STD_LOGIC_VECTOR((DATAWIDTH - 1) DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL romAddr     : STD_LOGIC_VECTOR(11 DOWNTO 0)              := (OTHERS => '0');
    SIGNAL currentData : STD_LOGIC_VECTOR((DATAWIDTH - 1) DOWNTO 0) := (OTHERS => '0');

    SIGNAL clk_n : STD_LOGIC := '1';

    SIGNAL samplingRateCounter : INTEGER := 0;

    SIGNAL dataOuputWidth : INTEGER := 8;

    SIGNAL adc_data : STD_LOGIC_VECTOR((DATAWIDTH - 1) DOWNTO 0) := (OTHERS => '0');
BEGIN
    config : PROCESS (recv.data)
    BEGIN
        IF recv.data(31 DOWNTO 28) = "1001" THEN
            -- Handle input data
            -- Set Send Address
            IF recv.data(19) = '1' THEN
                send.addr <= "0000" & recv.data(23 DOWNTO 20);
                -- Data width
            ELSIF recv.data(16) = '1' THEN
                IF recv.data(15 DOWNTO 0) = conv_std_logic_vector(8, 16) THEN
                    -- 8 bits
                    dataOuputWidth <= 8;
                ELSIF recv.data(15 DOWNTO 0) = conv_std_logic_vector(10, 16) THEN
                    -- 10 bits
                    dataOuputWidth <= 10;
                ELSIF recv.data(15 DOWNTO 0) = conv_std_logic_vector(12, 16) THEN
                    -- 12 bits
                    dataOuputWidth <= 12;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    clk_n <= NOT clk;
    altsyncram_component : altsyncram
    GENERIC MAP(
        clock_enable_input_a   => "BYPASS",
        clock_enable_output_a  => "BYPASS",
        init_file              => "power_signals/power_signal_12bit_5cycles.mif",
        intended_device_family => "Cyclone V",
        lpm_hint               => "ENABLE_RUNTIME_MOD=NO",
        lpm_type               => "altsyncram",
        numwords_a             => 1600,
        operation_mode         => "ROM",
        outdata_aclr_a         => "NONE",
        outdata_reg_a          => "UNREGISTERED",
        widthad_a              => ADDRWIDTH,
        width_a                => DATAWIDTH,
        width_byteena_a        => 1
    )
    PORT MAP(
        clock0    => clk_n,
        address_a => romAddr,
        q_a       => currentData
    );
    datahandle : PROCESS (clk)
    BEGIN
        IF (rising_edge(clk)) THEN
            IF (reset = '1') THEN
                -- Reset
            ELSE
                samplingRateCounter <= samplingRateCounter + 1;
                IF (samplingRateCounter = SAMPLINGFREQ) THEN
                    samplingRateCounter <= 0;
                    -- Update address only reading one byte at a time
                    romAddr <= romAddr + conv_std_logic_vector(1, 12);
                    IF (romAddr = conv_std_logic_vector(1600, 12)) THEN
                        romAddr <= conv_std_logic_vector(0, 12);
                    END IF;
                END IF;
            END IF;
            CASE dataOuputWidth IS
                WHEN 12 =>
                    adc_data <= currentData;
                WHEN 10 =>
                    adc_data <= currentData((DATAWIDTH - 1) DOWNTO 2) & "00";
                WHEN 8 =>
                    adc_data <= currentData((DATAWIDTH - 1) DOWNTO 4) & "0000";
                WHEN OTHERS         =>
                    adc_data <= (OTHERS => '0');
            END CASE;
        END IF;
    END PROCESS;
    send.data <= "1000" & "0010" & "0011" & "0000" & "000" & adc_data; -- Data message, 2, 3, no extra
END ARCHITECTURE;