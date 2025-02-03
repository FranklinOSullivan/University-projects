-- Top level 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Nios_Sys_3 is
	port (CLOCK_50 : in std_logic;
		  KEY : in std_logic_vector(2 downto 0);  -- Note here for reset
		  LEDR : out std_logic_vector(7 downto 0);
		  HEX0 : out std_logic_vector(6 downto 0);
		  HEX1 : out std_logic_vector(6 downto 0);
		  HEX2 : out std_logic_vector(6 downto 0);
		  HEX3 : out std_logic_vector(6 downto 0);
		  SW : in std_logic_vector(7 downto 0));

end entity Nios_Sys_3;

architecture structure of Nios_Sys_3 is
	component Nios_V3 is
		port (
			clk_clk                            : in  std_logic                    := 'X'; -- clk
			reset_reset_n                      : in  std_logic                    := 'X'; -- reset_n
			led_pio_external_connection_export : out std_logic_vector(7 downto 0);
			seven_seg_0_external_connection_export: out std_logic_vector(6 downto 0);
			seven_seg_1_external_connection_export: out std_logic_vector(6 downto 0);
			seven_seg_2_external_connection_export: out std_logic_vector(6 downto 0);
			seven_seg_3_external_connection_export: out std_logic_vector(6 downto 0);
			button_pio_external_connection_export: in  std_logic_vector(1 downto 0);
			switch_pio_external_connection_export: in std_logic_vector(7 downto 0)
		);
	end component Nios_V3;
	
	
begin 
	u0 : component Nios_V3
		port map (
			clk_clk                            => CLOCK_50,
			reset_reset_n                      => KEY(0),
			led_pio_external_connection_export => LEDR,
			seven_seg_0_external_connection_export => HEX0,
			seven_seg_1_external_connection_export => HEX1,
			seven_seg_2_external_connection_export => HEX2,
			seven_seg_3_external_connection_export => HEX3,
			button_pio_external_connection_export => KEY(2 downto 1),
			switch_pio_external_connection_export => SW
		);
end architecture structure;