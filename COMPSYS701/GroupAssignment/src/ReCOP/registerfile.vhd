------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.recop_types.all;

entity registerfile is
	port (
		clk           : in bit_1 := '1';
		rst           : in bit_1 := '0';
		address_a     : in bit_4;
		address_b     : in bit_4;
		write_address : in bit_4;
		write_data    : in bit_16;
		wren          : in bit_1 := '0';
		q_a           : out bit_16;
		q_b           : out bit_16
	);

end registerfile;
architecture rtl of registerfile is
	type reg_file is array (0 to 15) of bit_16;
	signal registers : reg_file := (others => (others => '0'));
begin
	process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				registers <= (others => (others => '0'));
			elsif (wren = '1' and (write_address /= x"0")) then -- R0 = 0 and R15 = SIP
				registers(to_integer(unsigned(write_address))) <= write_data;
			end if;
		end if;
	end process;

	process (address_a, wren, write_address, write_data)
	begin
		if (wren = '1' and address_a = write_address) then
			q_a <= write_data;
		else
			q_a <= registers(to_integer(unsigned(address_a)));
		end if;
	end process;

	process (address_b, wren, write_address, write_data)
	begin
		if (wren = '1' and address_b = write_address) then
			q_b <= write_data;
		else
			q_b <= registers(to_integer(unsigned(address_b)));
		end if;
	end process;
end rtl;