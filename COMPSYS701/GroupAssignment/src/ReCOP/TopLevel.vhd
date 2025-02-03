------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity TopLevel is
	port (
		CLOCK_50 : in std_logic;

		KEY  : in std_logic_vector(3 downto 0);
		SW   : in std_logic_vector(9 downto 0);
		LEDR : out std_logic_vector(9 downto 0);
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0);
		HEX2 : out std_logic_vector(6 downto 0);
		HEX3 : out std_logic_vector(6 downto 0);
		HEX4 : out std_logic_vector(6 downto 0);
		HEX5 : out std_logic_vector(6 downto 0)
	);
end entity;

architecture behaviour of TopLevel is
	signal reset : std_logic := '0';
begin
	recop : entity work.recop
		generic map(
			pmem_init_file => "./code/bin/multiply.mif"
		)
		port map(
			clock => CLOCK_50,
			reset => reset,
			sw    => sw,
			ledr  => ledr,
			hex0  => hex0,
			hex1  => hex1,
			hex2  => hex2,
			hex3  => hex3,
			hex4  => hex4,
			hex5  => hex5,
			send  => open,
			recv => (others => '0')
		);

	reset <= not KEY(0);
end architecture;