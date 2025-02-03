------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.recop_types.all;
use work.opcodes.all;

entity mem_io is
    generic (
        NOC_BUFFER_SIZE : integer := 16
    );
    port (
        clk      : in bit_1   := '1';
        reset    : in bit_1   := '0';
        wren     : in bit_1   := '0';
        datacall : in bit_1   := '0';
        pop      : in bit_1   := '0';
        addr     : in bit_16  := (others => '0');
        data_in  : in bit_16  := (others => '0');
        data_out : out bit_16 := (others => '0');
        switches : in bit_10  := (others => '0');
        ledr     : out bit_10 := (others => '0');
        hex0     : out bit_7  := (others => '0');
        hex1     : out bit_7  := (others => '0');
        hex2     : out bit_7  := (others => '0');
        hex3     : out bit_7  := (others => '0');
        hex4     : out bit_7  := (others => '0');
        hex5     : out bit_7  := (others => '0');
        to_noc   : out bit_32 := (others => '0');
        from_noc : in bit_32  := (others => '0')
    );
end mem_io;

architecture SYN of mem_io is
    signal switches_reg : bit_16                        := (others => '0');
    signal ledr_reg     : bit_16                        := (others => '0');
    signal hex0_reg     : bit_16                        := (others => '0');
    signal hex1_reg     : bit_16                        := (others => '0');
    signal hex2_reg     : bit_16                        := (others => '0');
    signal hex3_reg     : bit_16                        := (others => '0');
    signal hex4_reg     : bit_16                        := (others => '0');
    signal hex5_reg     : bit_16                        := (others => '0');
    signal to_noc_reg   : bit_32                        := (others => '0');
    signal hex_data     : bit_24                        := (others => '0');
    signal seg          : std_logic_vector(41 downto 0) := (others => '0');

    type noc_data_t is array (0 to (2 * NOC_BUFFER_SIZE - 1)) of bit_16;
    signal from_noc_mem : noc_data_t := (others => (others => '0'));
    signal index        : integer    := 0;
begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                switches_reg <= (others => '0');
                ledr_reg     <= (others => '0');
                hex0_reg     <= (others => '0');
                hex1_reg     <= (others => '0');
                hex2_reg     <= (others => '0');
                hex3_reg     <= (others => '0');
                hex4_reg     <= (others => '0');
                hex5_reg     <= (others => '0');
            else
                switches_reg <= "000000" & switches;
                if (wren = '1') then
                    case (addr) is
                        when LEDR_ADDR =>
                            ledr_reg <= data_in;
                        when HEX0_ADDR =>
                            hex0_reg <= data_in;
                        when HEX1_ADDR =>
                            hex1_reg <= data_in;
                        when HEX2_ADDR =>
                            hex2_reg <= data_in;
                        when HEX3_ADDR =>
                            hex3_reg <= data_in;
                        when HEX4_ADDR =>
                            hex4_reg <= data_in;
                        when HEX5_ADDR =>
                            hex5_reg <= data_in;
                        when others =>
                    end case;
                end if;
            end if;
        end if;
    end process;

    noc_io : process (clk)
    begin
        if (rising_edge(clk)) then
            if reset = '1' then
                to_noc_reg   <= (others => '0');
                from_noc_mem <= (others => (others => '0'));
                index        <= 0;
            else
                if (datacall = '1') then
                    to_noc_reg <= data_in & addr;
                else
                    to_noc_reg <= (others => '0');
                end if;

                -- If pop is high we want to remove the oldest data
                if (pop = '1' and index /= 0) then
                    if (not (from_noc(31) = '1' and index /= 7)) then
                        index <= index - 1;
                    end if;
                    for i in 0 to (NOC_BUFFER_SIZE - 2) loop
                        from_noc_mem(2 * i)     <= from_noc_mem(2 * i + 2);
                        from_noc_mem(2 * i + 1) <= from_noc_mem(2 * i + 3);
                    end loop;
                    from_noc_mem(2 * NOC_BUFFER_SIZE - 1) <= (others => '0');
                    from_noc_mem(2 * NOC_BUFFER_SIZE - 2) <= (others => '0');
                end if;

                -- If the NOC has data for us, we need to store it
                if (from_noc(31) = '1' and index /= (NOC_BUFFER_SIZE - 1)) then
                    if (not (pop = '1' and index /= 0)) then
                        index <= index + 1;

                        from_noc_mem(2 * index)     <= from_noc(31 downto 16);
                        from_noc_mem(2 * index + 1) <= from_noc(15 downto 0);
                    else
                        from_noc_mem(2 * (index - 1))     <= from_noc(31 downto 16);
                        from_noc_mem(2 * (index - 1) + 1) <= from_noc(15 downto 0);
                    end if;
                end if;
            end if;
        end if;

    end process;

    data_out <= switches_reg when addr = SWITCHES_ADDR else
        ledr_reg when addr = LEDR_ADDR else
        hex0_reg when addr = HEX0_ADDR else
        hex1_reg when addr = HEX1_ADDR else
        hex2_reg when addr = HEX2_ADDR else
        hex3_reg when addr = HEX3_ADDR else
        to_noc_reg(31 downto 16) when addr = TO_NOC_ADDR_U else
        to_noc_reg(15 downto 0) when addr = TO_NOC_ADDR_L else
        from_noc_mem(0) when addr = FROM_NOC_ADDR_U else
        from_noc_mem(1) when addr = FROM_NOC_ADDR_L else
        (others => '0');

    hex_data <= hex5_reg(3 downto 0) & hex4_reg(3 downto 0) & hex3_reg(3 downto 0) & hex2_reg(3 downto 0) & hex1_reg(3 downto 0) & hex0_reg(3 downto 0);
    ledr     <= ledr_reg(9 downto 0);
    hex0     <= seg(6 downto 0);
    hex1     <= seg(13 downto 7);
    hex2     <= seg(20 downto 14);
    hex3     <= seg(27 downto 21);
    hex4     <= seg(34 downto 28);
    hex5     <= seg(41 downto 35);

    to_noc <= to_noc_reg;

    num_to_seven_seg : entity work.num_to_seven_seg
        port map(
            num => hex_data,
            seg => seg
        );

end architecture;