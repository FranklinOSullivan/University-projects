LIBRARY ieee;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.constants_pkg.ALL;
USE work.TdmaMinTypes.ALL;

ENTITY TestAdc IS
END ENTITY;

ARCHITECTURE sim OF TestAdc IS
    SIGNAL clk   : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';

    SIGNAL send_port : tdma_min_ports(0 TO 8);
    SIGNAL recv_port : tdma_min_ports(0 TO 8);

    COMPONENT adcasp IS
        PORT (
            clk   : IN STD_LOGIC;
            reset : IN STD_LOGIC;

            recv : IN tdma_min_port;
            send : OUT tdma_min_port
        );
    END COMPONENT;
BEGIN
    DUT : adcasp PORT MAP(
        clk   => clk,
        reset => reset,

        recv => recv_port(0),
        send => send_port(0)
    );
    reset             <= '0' AFTER 35 ns;
    clk               <= NOT clk AFTER 5 ns;
    recv_port(0).data <= "1001" & "0000" & "0000" & "1001" & "0000000000001000", "1001" & "0000" & "0010" & "0001" & "0000000000001100" AFTER 30 ms, "1001" & "0000" & "0100" & "1001" & "0000000000001010" AFTER 70 ms;
END ARCHITECTURE;