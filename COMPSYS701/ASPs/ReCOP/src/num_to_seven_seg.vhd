------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity num_to_seven_seg is
    generic (
        NUM_DIGITS : integer := 6 -- number of 7-segment displays
    );
    port (
        num : in std_logic_vector((4 * NUM_DIGITS) - 1 downto 0); -- 16-bit input number
        seg : out std_logic_vector((7 * NUM_DIGITS) - 1 downto 0) -- 4 sets of 7-segment display output
    );
end entity num_to_seven_seg;

architecture Behavioral of num_to_seven_seg is
    -- 7-segment display lookup table
    type seg_t is array(0 to 15) of std_logic_vector(6 downto 0);
    constant seg_lookup : seg_t :=
    ("1000000", -- 0
    "1111001",  -- 1
    "0100100",  -- 2
    "0110000",  -- 3
    "0011001",  -- 4
    "0010010",  -- 5
    "0000010",  -- 6
    "1111000",  -- 7
    "0000000",  -- 8
    "0010000",  -- 9
    "0001000",  -- A (10)
    "0000011",  -- B (11)
    "1000110",  -- C (12)
    "0100001",  -- D (13)
    "0000110",  -- E (14)
    "0001110"   -- F (15)
    );

begin
    seg_gen : for i in 0 to (NUM_DIGITS - 1) generate
        seg(7 * i + 6 downto 7 * i) <= seg_lookup(to_integer(unsigned(num(4 * i + 3 downto 4 * i))));
    end generate seg_gen;
end architecture Behavioral;