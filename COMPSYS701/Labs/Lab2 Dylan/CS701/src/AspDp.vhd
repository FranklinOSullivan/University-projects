library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;
use work.TdmaMinTypes.all;

entity AspDp is
	port (
		clock : in  std_logic;
		send  : out tdma_min_port;
		recv  : in  tdma_min_port
	);
end entity;

architecture rtl of AspDp is
    constant MAX_VALUE : signed(15 downto 0) := to_signed(4096, 16);
    constant DATA_TYPE_AUDIO : std_logic_vector(3 downto 0) := "1000";
    constant SEND_ADDR : std_logic_vector(7 downto 0) := x"01";

    signal debug_channel_0 : signed(15 downto 0);
    signal debug_channel_1 : signed(15 downto 0);
begin



	process(clock)
        variable output_data : std_logic_vector(15 downto 0);
	begin
		if rising_edge(clock) then
			if recv.data(31 downto 28) = "1000" then
                send.data(31 downto 28) <= DATA_TYPE_AUDIO;
                send.data(27 downto 17) <= (others => '0');
                send.data(16) <= recv.data(16);
                send.addr <= SEND_ADDR;

                -- Debug values going into the block 
                if (recv.data(16) = '0') then
                    debug_channel_0 <= signed(recv.data(15 downto 0));
                else
                    debug_channel_1 <= signed(recv.data(15 downto 0));
                end if;

                output_data := recv.data(14 downto 0) & '0';
				if (signed(output_data) > MAX_VALUE) then
                    send.data(15 downto 0) <= std_logic_vector(MAX_VALUE);
                elsif (signed(output_data) < -MAX_VALUE) then
                    send.data(15 downto 0) <= std_logic_vector(-MAX_VALUE);
                else
                    send.data(15 downto 0) <= output_data;
                end if;
            else
                send.data <= (others => '0');
                send.addr <= (others => '0');
			end if;
		end if;
	end process;

end architecture;
