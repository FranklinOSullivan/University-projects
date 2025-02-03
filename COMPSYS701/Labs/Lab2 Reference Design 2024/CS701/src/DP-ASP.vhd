library IEEE;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;

library work;
use work.TdmaMinTypes.all;
entity DpASP is
    port (
        clock : in std_logic;
        send : out tdma_min_port;
        recv : in tdma_min_port
    );
end entity;

architecture sim of DpAsp is
	signal c1 : std_logic_vector(15 downto 0);
	signal c2 : std_logic_vector(15 downto 0);
	signal addr_0 : std_logic_vector(3 downto 0);
	signal addr_1 : std_logic_vector(3 downto 0);
    
begin
	process(clock)
	begin
		if rising_edge(clock) then

			if recv.data(31 downto 28) = "1001" then
				if recv.data(16) = '0' then
					addr_0 <= recv.data(23 downto 20);
				else
					addr_1 <= recv.data(23 downto 20);
				end if;
			end if;

		end if;
	end process;

	 
    process (clock)
		variable channel0 : std_logic_vector(15 downto 0);
    begin
        if rising_edge(clock) then
			if recv.data(31 downto 28) = "1000" then
				channel0 := recv.data(15 downto 0) + recv.data(15 downto 0);
				if (channel0 > conv_std_logic_vector(4096, 16)) then
					channel0 := conv_std_logic_vector(4096, 16);
				elsif (channel0 < -conv_std_logic_vector(4096, 16)) then
					channel0 := -conv_std_logic_vector(4096, 16);
				end if;
				send.data <= "1000" & "0001" & "0000000" & recv.data(16) & channel0; -- Data
				if (recv.data(16) = '0') then
					send.addr <= x"01";
					c1 <= channel0;
				elsif (recv.data(16) = '1') then
					send.addr <= x"01";
					c2 <= channel0;
				end if;
			else
				send.addr <= (others => '0');
				send.data <= (others => '0');
			end if;
		end if;
    end process;
end architecture;