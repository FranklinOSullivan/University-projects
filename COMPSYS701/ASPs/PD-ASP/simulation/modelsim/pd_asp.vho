-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Standard Edition"

-- DATE "05/24/2024 17:28:15"

-- 
-- Device: Altera 5CSEMA5F31C6 Package FBGA896
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	pd_asp IS
    PORT (
	clock : IN std_logic;
	reset : IN std_logic;
	\recv.data\ : IN std_logic_vector(31 DOWNTO 0);
	\recv.addr\ : IN std_logic_vector(7 DOWNTO 0);
	\send.data\ : OUT std_logic_vector(31 DOWNTO 0);
	\send.addr\ : OUT std_logic_vector(7 DOWNTO 0)
	);
END pd_asp;

-- Design Ports Information
-- recv.data[17]	=>  Location: PIN_AK26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[18]	=>  Location: PIN_AE24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[19]	=>  Location: PIN_AH3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[20]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[21]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[22]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[23]	=>  Location: PIN_AH13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[24]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[25]	=>  Location: PIN_AC28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[26]	=>  Location: PIN_AG30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[27]	=>  Location: PIN_D4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[0]	=>  Location: PIN_AK12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[1]	=>  Location: PIN_G11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[2]	=>  Location: PIN_AF11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[3]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[4]	=>  Location: PIN_AJ5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[5]	=>  Location: PIN_F14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[6]	=>  Location: PIN_C4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.addr[7]	=>  Location: PIN_AK29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[0]	=>  Location: PIN_AA19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[1]	=>  Location: PIN_AC18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[2]	=>  Location: PIN_AF24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[3]	=>  Location: PIN_AD17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[4]	=>  Location: PIN_AE19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[5]	=>  Location: PIN_AK24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[6]	=>  Location: PIN_AK21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[7]	=>  Location: PIN_AH23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[8]	=>  Location: PIN_Y18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[9]	=>  Location: PIN_AK22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[10]	=>  Location: PIN_AE18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[11]	=>  Location: PIN_AK23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[12]	=>  Location: PIN_AJ25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[13]	=>  Location: PIN_AJ17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[14]	=>  Location: PIN_AH19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[15]	=>  Location: PIN_AG18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[16]	=>  Location: PIN_W16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[17]	=>  Location: PIN_AG5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[18]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[19]	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[20]	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[21]	=>  Location: PIN_AE23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[22]	=>  Location: PIN_AH5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[23]	=>  Location: PIN_AJ12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[24]	=>  Location: PIN_AH28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[25]	=>  Location: PIN_W20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[26]	=>  Location: PIN_AE22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[27]	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[28]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[29]	=>  Location: PIN_AF15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[30]	=>  Location: PIN_G12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.data[31]	=>  Location: PIN_AJ21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[0]	=>  Location: PIN_AE9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[1]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[2]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[3]	=>  Location: PIN_AG10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[4]	=>  Location: PIN_AD29,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[5]	=>  Location: PIN_AF28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[6]	=>  Location: PIN_AC9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- send.addr[7]	=>  Location: PIN_AJ1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_Y27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_AH24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[16]	=>  Location: PIN_AH18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[28]	=>  Location: PIN_AB17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[29]	=>  Location: PIN_AH20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[30]	=>  Location: PIN_AH17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[31]	=>  Location: PIN_AA16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[15]	=>  Location: PIN_AJ22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[14]	=>  Location: PIN_AF20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[13]	=>  Location: PIN_AA18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[12]	=>  Location: PIN_AF21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[11]	=>  Location: PIN_AG23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[9]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[10]	=>  Location: PIN_AG22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[8]	=>  Location: PIN_AH22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[7]	=>  Location: PIN_AF19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[6]	=>  Location: PIN_AJ20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[1]	=>  Location: PIN_AK18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[0]	=>  Location: PIN_AG20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[5]	=>  Location: PIN_V17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[4]	=>  Location: PIN_AK19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[3]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- recv.data[2]	=>  Location: PIN_AJ19,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF pd_asp IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL \ww_recv.data\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \ww_recv.addr\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ww_send.data\ : std_logic_vector(31 DOWNTO 0);
SIGNAL \ww_send.addr\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \recv.data[17]~input_o\ : std_logic;
SIGNAL \recv.data[18]~input_o\ : std_logic;
SIGNAL \recv.data[19]~input_o\ : std_logic;
SIGNAL \recv.data[20]~input_o\ : std_logic;
SIGNAL \recv.data[21]~input_o\ : std_logic;
SIGNAL \recv.data[22]~input_o\ : std_logic;
SIGNAL \recv.data[23]~input_o\ : std_logic;
SIGNAL \recv.data[24]~input_o\ : std_logic;
SIGNAL \recv.data[25]~input_o\ : std_logic;
SIGNAL \recv.data[26]~input_o\ : std_logic;
SIGNAL \recv.data[27]~input_o\ : std_logic;
SIGNAL \recv.addr[0]~input_o\ : std_logic;
SIGNAL \recv.addr[1]~input_o\ : std_logic;
SIGNAL \recv.addr[2]~input_o\ : std_logic;
SIGNAL \recv.addr[3]~input_o\ : std_logic;
SIGNAL \recv.addr[4]~input_o\ : std_logic;
SIGNAL \recv.addr[5]~input_o\ : std_logic;
SIGNAL \recv.addr[6]~input_o\ : std_logic;
SIGNAL \recv.addr[7]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputCLKENA0_outclk\ : std_logic;
SIGNAL \recv.data[7]~input_o\ : std_logic;
SIGNAL \recv.data[29]~input_o\ : std_logic;
SIGNAL \recv.data[30]~input_o\ : std_logic;
SIGNAL \recv.data[31]~input_o\ : std_logic;
SIGNAL \recv.data[28]~input_o\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \recv.data[6]~input_o\ : std_logic;
SIGNAL \current_correlation[6]~feeder_combout\ : std_logic;
SIGNAL \LessThan2~0_combout\ : std_logic;
SIGNAL \recv.data[8]~input_o\ : std_logic;
SIGNAL \recv.data[9]~input_o\ : std_logic;
SIGNAL \LessThan2~4_combout\ : std_logic;
SIGNAL \recv.data[10]~input_o\ : std_logic;
SIGNAL \LessThan0~2_combout\ : std_logic;
SIGNAL \recv.data[15]~input_o\ : std_logic;
SIGNAL \LessThan0~13_combout\ : std_logic;
SIGNAL \recv.data[11]~input_o\ : std_logic;
SIGNAL \current_correlation[11]~feeder_combout\ : std_logic;
SIGNAL \LessThan0~1_combout\ : std_logic;
SIGNAL \recv.data[13]~input_o\ : std_logic;
SIGNAL \recv.data[14]~input_o\ : std_logic;
SIGNAL \recv.data[12]~input_o\ : std_logic;
SIGNAL \previous_correlation[12]~feeder_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \LessThan2~5_combout\ : std_logic;
SIGNAL \LessThan2~8_combout\ : std_logic;
SIGNAL \LessThan2~6_combout\ : std_logic;
SIGNAL \LessThan2~7_combout\ : std_logic;
SIGNAL \LessThan0~18_combout\ : std_logic;
SIGNAL \LessThan2~9_combout\ : std_logic;
SIGNAL \recv.data[3]~input_o\ : std_logic;
SIGNAL \recv.data[4]~input_o\ : std_logic;
SIGNAL \recv.data[5]~input_o\ : std_logic;
SIGNAL \LessThan0~7_combout\ : std_logic;
SIGNAL \LessThan2~2_combout\ : std_logic;
SIGNAL \LessThan0~5_combout\ : std_logic;
SIGNAL \recv.data[2]~input_o\ : std_logic;
SIGNAL \recv.data[1]~input_o\ : std_logic;
SIGNAL \recv.data[0]~input_o\ : std_logic;
SIGNAL \LessThan2~1_combout\ : std_logic;
SIGNAL \LessThan2~3_combout\ : std_logic;
SIGNAL \LessThan0~3_combout\ : std_logic;
SIGNAL \LessThan0~4_combout\ : std_logic;
SIGNAL \LessThan2~10_combout\ : std_logic;
SIGNAL \correlation_count_signal~0_combout\ : std_logic;
SIGNAL \LessThan0~11_combout\ : std_logic;
SIGNAL \LessThan0~12_combout\ : std_logic;
SIGNAL \LessThan0~8_combout\ : std_logic;
SIGNAL \LessThan0~9_combout\ : std_logic;
SIGNAL \LessThan0~6_combout\ : std_logic;
SIGNAL \LessThan0~10_combout\ : std_logic;
SIGNAL \LessThan0~16_combout\ : std_logic;
SIGNAL \LessThan0~17_combout\ : std_logic;
SIGNAL \LessThan0~14_combout\ : std_logic;
SIGNAL \LessThan0~15_combout\ : std_logic;
SIGNAL \correlation_count_signal~1_combout\ : std_logic;
SIGNAL \edge~0_combout\ : std_logic;
SIGNAL \edge~q\ : std_logic;
SIGNAL \recv.data[16]~input_o\ : std_logic;
SIGNAL \invert_signal~0_combout\ : std_logic;
SIGNAL \invert_signal~q\ : std_logic;
SIGNAL \correlation_count_signal~2_combout\ : std_logic;
SIGNAL \count[0]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \correlation_count_signal[8]~3_combout\ : std_logic;
SIGNAL \send.data[0]~reg0feeder_combout\ : std_logic;
SIGNAL \send_flag~q\ : std_logic;
SIGNAL \send.data[0]~reg0_q\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \send.data[1]~reg0_q\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \send.data[2]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[2]~reg0_q\ : std_logic;
SIGNAL \count[3]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~10\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \send.data[3]~reg0_q\ : std_logic;
SIGNAL \count[4]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \send.data[4]~reg0_q\ : std_logic;
SIGNAL \count[5]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \send.data[5]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[5]~reg0_q\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \send.data[6]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[6]~reg0_q\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~29_sumout\ : std_logic;
SIGNAL \send.data[7]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[7]~reg0_q\ : std_logic;
SIGNAL \count[8]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~30\ : std_logic;
SIGNAL \Add0~33_sumout\ : std_logic;
SIGNAL \send.data[8]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[8]~reg0_q\ : std_logic;
SIGNAL \Add0~34\ : std_logic;
SIGNAL \Add0~37_sumout\ : std_logic;
SIGNAL \send.data[9]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[9]~reg0_q\ : std_logic;
SIGNAL \count[10]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~38\ : std_logic;
SIGNAL \Add0~41_sumout\ : std_logic;
SIGNAL \send.data[10]~reg0_q\ : std_logic;
SIGNAL \count[11]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~42\ : std_logic;
SIGNAL \Add0~45_sumout\ : std_logic;
SIGNAL \send.data[11]~reg0_q\ : std_logic;
SIGNAL \Add0~46\ : std_logic;
SIGNAL \Add0~49_sumout\ : std_logic;
SIGNAL \send.data[12]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[12]~reg0_q\ : std_logic;
SIGNAL \count[13]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~50\ : std_logic;
SIGNAL \Add0~53_sumout\ : std_logic;
SIGNAL \send.data[13]~reg0_q\ : std_logic;
SIGNAL \count[14]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~54\ : std_logic;
SIGNAL \Add0~57_sumout\ : std_logic;
SIGNAL \send.data[14]~reg0_q\ : std_logic;
SIGNAL \count[15]~DUPLICATE_q\ : std_logic;
SIGNAL \Add0~58\ : std_logic;
SIGNAL \Add0~61_sumout\ : std_logic;
SIGNAL \send.data[15]~reg0_q\ : std_logic;
SIGNAL \send.data[31]~reg0feeder_combout\ : std_logic;
SIGNAL \send.data[31]~reg0_q\ : std_logic;
SIGNAL correlation_count_signal : std_logic_vector(15 DOWNTO 0);
SIGNAL count : std_logic_vector(15 DOWNTO 0);
SIGNAL previous_correlation : std_logic_vector(15 DOWNTO 0);
SIGNAL current_correlation : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_correlation_count_signal~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~17_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~16_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~15_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~14_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~13_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~12_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~11_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~10_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~9_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~8_combout\ : std_logic;
SIGNAL ALT_INV_current_correlation : std_logic_vector(15 DOWNTO 0);
SIGNAL \ALT_INV_LessThan0~7_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~6_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~5_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~4_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~3_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~0_combout\ : std_logic;
SIGNAL \ALT_INV_correlation_count_signal~0_combout\ : std_logic;
SIGNAL \ALT_INV_edge~q\ : std_logic;
SIGNAL \ALT_INV_invert_signal~q\ : std_logic;
SIGNAL ALT_INV_count : std_logic_vector(12 DOWNTO 1);
SIGNAL ALT_INV_previous_correlation : std_logic_vector(15 DOWNTO 0);
SIGNAL ALT_INV_correlation_count_signal : std_logic_vector(12 DOWNTO 0);
SIGNAL \ALT_INV_count[15]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[14]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[13]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[11]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[10]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[8]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[5]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[4]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[3]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_count[0]~DUPLICATE_q\ : std_logic;
SIGNAL \ALT_INV_recv.data[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[11]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[31]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[30]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[29]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[28]~input_o\ : std_logic;
SIGNAL \ALT_INV_recv.data[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_reset~input_o\ : std_logic;
SIGNAL \ALT_INV_correlation_count_signal~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~10_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~9_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~8_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~7_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~6_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~18_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~5_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~4_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~3_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~2_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan2~0_combout\ : std_logic;

BEGIN

ww_clock <= clock;
ww_reset <= reset;
\ww_recv.data\ <= \recv.data\;
\ww_recv.addr\ <= \recv.addr\;
\send.data\ <= \ww_send.data\;
\send.addr\ <= \ww_send.addr\;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_correlation_count_signal~1_combout\ <= NOT \correlation_count_signal~1_combout\;
\ALT_INV_LessThan0~17_combout\ <= NOT \LessThan0~17_combout\;
\ALT_INV_LessThan0~16_combout\ <= NOT \LessThan0~16_combout\;
\ALT_INV_LessThan0~15_combout\ <= NOT \LessThan0~15_combout\;
\ALT_INV_LessThan0~14_combout\ <= NOT \LessThan0~14_combout\;
\ALT_INV_LessThan0~13_combout\ <= NOT \LessThan0~13_combout\;
\ALT_INV_LessThan0~12_combout\ <= NOT \LessThan0~12_combout\;
\ALT_INV_LessThan0~11_combout\ <= NOT \LessThan0~11_combout\;
\ALT_INV_LessThan0~10_combout\ <= NOT \LessThan0~10_combout\;
\ALT_INV_LessThan0~9_combout\ <= NOT \LessThan0~9_combout\;
\ALT_INV_LessThan0~8_combout\ <= NOT \LessThan0~8_combout\;
ALT_INV_current_correlation(2) <= NOT current_correlation(2);
ALT_INV_current_correlation(3) <= NOT current_correlation(3);
\ALT_INV_LessThan0~7_combout\ <= NOT \LessThan0~7_combout\;
ALT_INV_current_correlation(4) <= NOT current_correlation(4);
ALT_INV_current_correlation(5) <= NOT current_correlation(5);
\ALT_INV_LessThan0~6_combout\ <= NOT \LessThan0~6_combout\;
ALT_INV_current_correlation(0) <= NOT current_correlation(0);
ALT_INV_current_correlation(1) <= NOT current_correlation(1);
\ALT_INV_LessThan0~5_combout\ <= NOT \LessThan0~5_combout\;
ALT_INV_current_correlation(6) <= NOT current_correlation(6);
ALT_INV_current_correlation(7) <= NOT current_correlation(7);
\ALT_INV_LessThan0~4_combout\ <= NOT \LessThan0~4_combout\;
\ALT_INV_LessThan0~3_combout\ <= NOT \LessThan0~3_combout\;
ALT_INV_current_correlation(8) <= NOT current_correlation(8);
\ALT_INV_LessThan0~2_combout\ <= NOT \LessThan0~2_combout\;
ALT_INV_current_correlation(10) <= NOT current_correlation(10);
ALT_INV_current_correlation(9) <= NOT current_correlation(9);
\ALT_INV_LessThan0~1_combout\ <= NOT \LessThan0~1_combout\;
ALT_INV_current_correlation(11) <= NOT current_correlation(11);
\ALT_INV_LessThan0~0_combout\ <= NOT \LessThan0~0_combout\;
ALT_INV_current_correlation(12) <= NOT current_correlation(12);
ALT_INV_current_correlation(13) <= NOT current_correlation(13);
ALT_INV_current_correlation(14) <= NOT current_correlation(14);
\ALT_INV_correlation_count_signal~0_combout\ <= NOT \correlation_count_signal~0_combout\;
ALT_INV_current_correlation(15) <= NOT current_correlation(15);
\ALT_INV_edge~q\ <= NOT \edge~q\;
\ALT_INV_invert_signal~q\ <= NOT \invert_signal~q\;
ALT_INV_count(12) <= NOT count(12);
ALT_INV_count(9) <= NOT count(9);
ALT_INV_count(7) <= NOT count(7);
ALT_INV_count(6) <= NOT count(6);
ALT_INV_count(2) <= NOT count(2);
ALT_INV_count(1) <= NOT count(1);
ALT_INV_previous_correlation(2) <= NOT previous_correlation(2);
ALT_INV_previous_correlation(3) <= NOT previous_correlation(3);
ALT_INV_previous_correlation(4) <= NOT previous_correlation(4);
ALT_INV_previous_correlation(5) <= NOT previous_correlation(5);
ALT_INV_previous_correlation(0) <= NOT previous_correlation(0);
ALT_INV_previous_correlation(1) <= NOT previous_correlation(1);
ALT_INV_previous_correlation(6) <= NOT previous_correlation(6);
ALT_INV_previous_correlation(7) <= NOT previous_correlation(7);
ALT_INV_previous_correlation(8) <= NOT previous_correlation(8);
ALT_INV_previous_correlation(10) <= NOT previous_correlation(10);
ALT_INV_previous_correlation(9) <= NOT previous_correlation(9);
ALT_INV_previous_correlation(11) <= NOT previous_correlation(11);
ALT_INV_previous_correlation(12) <= NOT previous_correlation(12);
ALT_INV_previous_correlation(13) <= NOT previous_correlation(13);
ALT_INV_previous_correlation(14) <= NOT previous_correlation(14);
ALT_INV_previous_correlation(15) <= NOT previous_correlation(15);
ALT_INV_correlation_count_signal(12) <= NOT correlation_count_signal(12);
ALT_INV_correlation_count_signal(9) <= NOT correlation_count_signal(9);
ALT_INV_correlation_count_signal(8) <= NOT correlation_count_signal(8);
ALT_INV_correlation_count_signal(7) <= NOT correlation_count_signal(7);
ALT_INV_correlation_count_signal(6) <= NOT correlation_count_signal(6);
ALT_INV_correlation_count_signal(5) <= NOT correlation_count_signal(5);
ALT_INV_correlation_count_signal(2) <= NOT correlation_count_signal(2);
ALT_INV_correlation_count_signal(0) <= NOT correlation_count_signal(0);
\ALT_INV_count[15]~DUPLICATE_q\ <= NOT \count[15]~DUPLICATE_q\;
\ALT_INV_count[14]~DUPLICATE_q\ <= NOT \count[14]~DUPLICATE_q\;
\ALT_INV_count[13]~DUPLICATE_q\ <= NOT \count[13]~DUPLICATE_q\;
\ALT_INV_count[11]~DUPLICATE_q\ <= NOT \count[11]~DUPLICATE_q\;
\ALT_INV_count[10]~DUPLICATE_q\ <= NOT \count[10]~DUPLICATE_q\;
\ALT_INV_count[8]~DUPLICATE_q\ <= NOT \count[8]~DUPLICATE_q\;
\ALT_INV_count[5]~DUPLICATE_q\ <= NOT \count[5]~DUPLICATE_q\;
\ALT_INV_count[4]~DUPLICATE_q\ <= NOT \count[4]~DUPLICATE_q\;
\ALT_INV_count[3]~DUPLICATE_q\ <= NOT \count[3]~DUPLICATE_q\;
\ALT_INV_count[0]~DUPLICATE_q\ <= NOT \count[0]~DUPLICATE_q\;
\ALT_INV_recv.data[6]~input_o\ <= NOT \recv.data[6]~input_o\;
\ALT_INV_recv.data[11]~input_o\ <= NOT \recv.data[11]~input_o\;
\ALT_INV_recv.data[31]~input_o\ <= NOT \recv.data[31]~input_o\;
\ALT_INV_recv.data[30]~input_o\ <= NOT \recv.data[30]~input_o\;
\ALT_INV_recv.data[29]~input_o\ <= NOT \recv.data[29]~input_o\;
\ALT_INV_recv.data[28]~input_o\ <= NOT \recv.data[28]~input_o\;
\ALT_INV_recv.data[16]~input_o\ <= NOT \recv.data[16]~input_o\;
\ALT_INV_reset~input_o\ <= NOT \reset~input_o\;
\ALT_INV_correlation_count_signal~2_combout\ <= NOT \correlation_count_signal~2_combout\;
\ALT_INV_LessThan2~10_combout\ <= NOT \LessThan2~10_combout\;
\ALT_INV_LessThan2~9_combout\ <= NOT \LessThan2~9_combout\;
\ALT_INV_LessThan2~8_combout\ <= NOT \LessThan2~8_combout\;
\ALT_INV_LessThan2~7_combout\ <= NOT \LessThan2~7_combout\;
\ALT_INV_LessThan2~6_combout\ <= NOT \LessThan2~6_combout\;
\ALT_INV_LessThan0~18_combout\ <= NOT \LessThan0~18_combout\;
\ALT_INV_LessThan2~5_combout\ <= NOT \LessThan2~5_combout\;
\ALT_INV_LessThan2~4_combout\ <= NOT \LessThan2~4_combout\;
\ALT_INV_LessThan2~3_combout\ <= NOT \LessThan2~3_combout\;
\ALT_INV_LessThan2~2_combout\ <= NOT \LessThan2~2_combout\;
\ALT_INV_LessThan2~1_combout\ <= NOT \LessThan2~1_combout\;
\ALT_INV_LessThan2~0_combout\ <= NOT \LessThan2~0_combout\;

-- Location: IOOBUF_X72_Y0_N19
\send.data[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[0]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(0));

-- Location: IOOBUF_X64_Y0_N2
\send.data[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[1]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(1));

-- Location: IOOBUF_X74_Y0_N59
\send.data[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[2]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(2));

-- Location: IOOBUF_X64_Y0_N19
\send.data[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[3]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(3));

-- Location: IOOBUF_X66_Y0_N59
\send.data[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[4]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(4));

-- Location: IOOBUF_X72_Y0_N53
\send.data[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[5]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(5));

-- Location: IOOBUF_X68_Y0_N36
\send.data[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[6]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(6));

-- Location: IOOBUF_X70_Y0_N36
\send.data[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[7]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(7));

-- Location: IOOBUF_X72_Y0_N2
\send.data[8]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[8]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(8));

-- Location: IOOBUF_X68_Y0_N53
\send.data[9]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[9]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(9));

-- Location: IOOBUF_X66_Y0_N42
\send.data[10]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[10]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(10));

-- Location: IOOBUF_X72_Y0_N36
\send.data[11]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[11]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(11));

-- Location: IOOBUF_X74_Y0_N93
\send.data[12]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[12]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(12));

-- Location: IOOBUF_X58_Y0_N42
\send.data[13]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[13]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(13));

-- Location: IOOBUF_X58_Y0_N93
\send.data[14]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[14]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(14));

-- Location: IOOBUF_X58_Y0_N76
\send.data[15]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[15]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(15));

-- Location: IOOBUF_X52_Y0_N19
\send.data[16]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(16));

-- Location: IOOBUF_X14_Y0_N36
\send.data[17]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(17));

-- Location: IOOBUF_X26_Y81_N93
\send.data[18]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(18));

-- Location: IOOBUF_X6_Y81_N36
\send.data[19]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(19));

-- Location: IOOBUF_X20_Y0_N19
\send.data[20]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(20));

-- Location: IOOBUF_X78_Y0_N19
\send.data[21]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(21));

-- Location: IOOBUF_X14_Y0_N53
\send.data[22]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(22));

-- Location: IOOBUF_X38_Y0_N53
\send.data[23]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(23));

-- Location: IOOBUF_X89_Y4_N96
\send.data[24]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(24));

-- Location: IOOBUF_X89_Y6_N5
\send.data[25]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(25));

-- Location: IOOBUF_X78_Y0_N2
\send.data[26]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(26));

-- Location: IOOBUF_X12_Y81_N2
\send.data[27]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(27));

-- Location: IOOBUF_X6_Y81_N53
\send.data[28]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(28));

-- Location: IOOBUF_X32_Y0_N19
\send.data[29]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(29));

-- Location: IOOBUF_X10_Y81_N42
\send.data[30]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.data\(30));

-- Location: IOOBUF_X62_Y0_N53
\send.data[31]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \send.data[31]~reg0_q\,
	devoe => ww_devoe,
	o => \ww_send.data\(31));

-- Location: IOOBUF_X2_Y0_N93
\send.addr[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(0));

-- Location: IOOBUF_X36_Y81_N36
\send.addr[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(1));

-- Location: IOOBUF_X30_Y81_N53
\send.addr[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(2));

-- Location: IOOBUF_X18_Y0_N76
\send.addr[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(3));

-- Location: IOOBUF_X89_Y23_N56
\send.addr[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(4));

-- Location: IOOBUF_X89_Y13_N56
\send.addr[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(5));

-- Location: IOOBUF_X4_Y0_N2
\send.addr[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(6));

-- Location: IOOBUF_X14_Y0_N2
\send.addr[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ww_send.addr\(7));

-- Location: IOIBUF_X89_Y25_N21
\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G10
\clock~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clock~input_o\,
	outclk => \clock~inputCLKENA0_outclk\);

-- Location: IOIBUF_X62_Y0_N1
\recv.data[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(7),
	o => \recv.data[7]~input_o\);

-- Location: IOIBUF_X54_Y0_N18
\recv.data[29]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(29),
	o => \recv.data[29]~input_o\);

-- Location: IOIBUF_X56_Y0_N35
\recv.data[30]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(30),
	o => \recv.data[30]~input_o\);

-- Location: IOIBUF_X56_Y0_N1
\recv.data[31]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(31),
	o => \recv.data[31]~input_o\);

-- Location: IOIBUF_X56_Y0_N18
\recv.data[28]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(28),
	o => \recv.data[28]~input_o\);

-- Location: LABCELL_X60_Y4_N45
\Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = ( \recv.data[31]~input_o\ & ( !\recv.data[28]~input_o\ & ( (!\recv.data[29]~input_o\ & \recv.data[30]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000010100000101000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_recv.data[29]~input_o\,
	datac => \ALT_INV_recv.data[30]~input_o\,
	datae => \ALT_INV_recv.data[31]~input_o\,
	dataf => \ALT_INV_recv.data[28]~input_o\,
	combout => \Equal0~0_combout\);

-- Location: FF_X62_Y4_N11
\current_correlation[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[7]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(7));

-- Location: IOIBUF_X64_Y0_N52
\reset~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: FF_X62_Y4_N38
\previous_correlation[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(7),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(7));

-- Location: IOIBUF_X62_Y0_N35
\recv.data[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(6),
	o => \recv.data[6]~input_o\);

-- Location: LABCELL_X62_Y4_N15
\current_correlation[6]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \current_correlation[6]~feeder_combout\ = ( \recv.data[6]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_recv.data[6]~input_o\,
	combout => \current_correlation[6]~feeder_combout\);

-- Location: FF_X62_Y4_N17
\current_correlation[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \current_correlation[6]~feeder_combout\,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(6));

-- Location: FF_X62_Y4_N59
\previous_correlation[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(6),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(6));

-- Location: LABCELL_X62_Y4_N42
\LessThan2~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~0_combout\ = ( previous_correlation(6) & ( current_correlation(7) & ( !previous_correlation(7) ) ) ) # ( !previous_correlation(6) & ( current_correlation(7) & ( (!previous_correlation(7)) # (current_correlation(6)) ) ) ) # ( 
-- !previous_correlation(6) & ( !current_correlation(7) & ( (!previous_correlation(7) & current_correlation(6)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011110000000000000000000011110000111111111111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_previous_correlation(7),
	datad => ALT_INV_current_correlation(6),
	datae => ALT_INV_previous_correlation(6),
	dataf => ALT_INV_current_correlation(7),
	combout => \LessThan2~0_combout\);

-- Location: IOIBUF_X66_Y0_N92
\recv.data[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(8),
	o => \recv.data[8]~input_o\);

-- Location: FF_X63_Y4_N41
\current_correlation[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[8]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(8));

-- Location: IOIBUF_X68_Y0_N1
\recv.data[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(9),
	o => \recv.data[9]~input_o\);

-- Location: FF_X63_Y4_N8
\current_correlation[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[9]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(9));

-- Location: FF_X63_Y4_N17
\previous_correlation[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(9),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(9));

-- Location: FF_X63_Y4_N14
\previous_correlation[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(8),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(8));

-- Location: LABCELL_X63_Y4_N24
\LessThan2~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~4_combout\ = ( previous_correlation(8) & ( current_correlation(9) & ( !previous_correlation(9) ) ) ) # ( !previous_correlation(8) & ( current_correlation(9) & ( (!previous_correlation(9)) # (current_correlation(8)) ) ) ) # ( 
-- !previous_correlation(8) & ( !current_correlation(9) & ( (current_correlation(8) & !previous_correlation(9)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100000000000000000000000011111111001100111111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_current_correlation(8),
	datad => ALT_INV_previous_correlation(9),
	datae => ALT_INV_previous_correlation(8),
	dataf => ALT_INV_current_correlation(9),
	combout => \LessThan2~4_combout\);

-- Location: IOIBUF_X66_Y0_N75
\recv.data[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(10),
	o => \recv.data[10]~input_o\);

-- Location: FF_X65_Y4_N53
\current_correlation[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[10]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(10));

-- Location: FF_X65_Y4_N20
\previous_correlation[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(10),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(10));

-- Location: LABCELL_X64_Y4_N30
\LessThan0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~2_combout\ = ( current_correlation(10) & ( !previous_correlation(10) ) ) # ( !current_correlation(10) & ( previous_correlation(10) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_previous_correlation(10),
	dataf => ALT_INV_current_correlation(10),
	combout => \LessThan0~2_combout\);

-- Location: IOIBUF_X70_Y0_N52
\recv.data[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(15),
	o => \recv.data[15]~input_o\);

-- Location: FF_X65_Y4_N29
\current_correlation[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[15]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(15));

-- Location: FF_X65_Y4_N32
\previous_correlation[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(15),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(15));

-- Location: MLABCELL_X65_Y4_N54
\LessThan0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~13_combout\ = ( previous_correlation(15) & ( !current_correlation(15) ) ) # ( !previous_correlation(15) & ( current_correlation(15) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_current_correlation(15),
	dataf => ALT_INV_previous_correlation(15),
	combout => \LessThan0~13_combout\);

-- Location: IOIBUF_X64_Y0_N35
\recv.data[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(11),
	o => \recv.data[11]~input_o\);

-- Location: LABCELL_X64_Y4_N9
\current_correlation[11]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \current_correlation[11]~feeder_combout\ = ( \recv.data[11]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_recv.data[11]~input_o\,
	combout => \current_correlation[11]~feeder_combout\);

-- Location: FF_X64_Y4_N11
\current_correlation[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \current_correlation[11]~feeder_combout\,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(11));

-- Location: FF_X65_Y4_N8
\previous_correlation[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(11),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(11));

-- Location: LABCELL_X64_Y4_N3
\LessThan0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~1_combout\ = ( !previous_correlation(11) & ( current_correlation(11) ) ) # ( previous_correlation(11) & ( !current_correlation(11) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => ALT_INV_previous_correlation(11),
	dataf => ALT_INV_current_correlation(11),
	combout => \LessThan0~1_combout\);

-- Location: IOIBUF_X68_Y0_N18
\recv.data[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(13),
	o => \recv.data[13]~input_o\);

-- Location: FF_X65_Y4_N38
\current_correlation[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[13]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(13));

-- Location: FF_X65_Y4_N14
\previous_correlation[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(13),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(13));

-- Location: IOIBUF_X70_Y0_N1
\recv.data[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(14),
	o => \recv.data[14]~input_o\);

-- Location: FF_X65_Y4_N26
\current_correlation[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[14]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(14));

-- Location: IOIBUF_X70_Y0_N18
\recv.data[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(12),
	o => \recv.data[12]~input_o\);

-- Location: FF_X65_Y4_N50
\current_correlation[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[12]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(12));

-- Location: MLABCELL_X65_Y4_N21
\previous_correlation[12]~feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \previous_correlation[12]~feeder_combout\ = current_correlation(12)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(12),
	combout => \previous_correlation[12]~feeder_combout\);

-- Location: FF_X65_Y4_N23
\previous_correlation[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \previous_correlation[12]~feeder_combout\,
	sclr => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(12));

-- Location: FF_X65_Y4_N2
\previous_correlation[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(14),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(14));

-- Location: MLABCELL_X65_Y4_N39
\LessThan0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = ( previous_correlation(14) & ( current_correlation(12) & ( (current_correlation(14) & (previous_correlation(12) & (!current_correlation(13) $ (previous_correlation(13))))) ) ) ) # ( !previous_correlation(14) & ( 
-- current_correlation(12) & ( (!current_correlation(14) & (previous_correlation(12) & (!current_correlation(13) $ (previous_correlation(13))))) ) ) ) # ( previous_correlation(14) & ( !current_correlation(12) & ( (current_correlation(14) & 
-- (!previous_correlation(12) & (!current_correlation(13) $ (previous_correlation(13))))) ) ) ) # ( !previous_correlation(14) & ( !current_correlation(12) & ( (!current_correlation(14) & (!previous_correlation(12) & (!current_correlation(13) $ 
-- (previous_correlation(13))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1001000000000000000010010000000000000000100100000000000000001001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(13),
	datab => ALT_INV_previous_correlation(13),
	datac => ALT_INV_current_correlation(14),
	datad => ALT_INV_previous_correlation(12),
	datae => ALT_INV_previous_correlation(14),
	dataf => ALT_INV_current_correlation(12),
	combout => \LessThan0~0_combout\);

-- Location: LABCELL_X64_Y4_N15
\LessThan2~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~5_combout\ = ( !\LessThan0~1_combout\ & ( \LessThan0~0_combout\ & ( (\LessThan2~4_combout\ & (!\LessThan0~2_combout\ & !\LessThan0~13_combout\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000110000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_LessThan2~4_combout\,
	datac => \ALT_INV_LessThan0~2_combout\,
	datad => \ALT_INV_LessThan0~13_combout\,
	datae => \ALT_INV_LessThan0~1_combout\,
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \LessThan2~5_combout\);

-- Location: MLABCELL_X65_Y4_N3
\LessThan2~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~8_combout\ = ( current_correlation(15) & ( current_correlation(14) & ( (!previous_correlation(15)) # (!previous_correlation(14)) ) ) ) # ( !current_correlation(15) & ( current_correlation(14) & ( (!previous_correlation(15) & 
-- !previous_correlation(14)) ) ) ) # ( current_correlation(15) & ( !current_correlation(14) & ( !previous_correlation(15) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000011110000000000001111111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_previous_correlation(15),
	datad => ALT_INV_previous_correlation(14),
	datae => ALT_INV_current_correlation(15),
	dataf => ALT_INV_current_correlation(14),
	combout => \LessThan2~8_combout\);

-- Location: MLABCELL_X65_Y4_N57
\LessThan2~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~6_combout\ = ( current_correlation(13) & ( (!previous_correlation(13)) # ((!previous_correlation(12) & current_correlation(12))) ) ) # ( !current_correlation(13) & ( (!previous_correlation(12) & (!previous_correlation(13) & 
-- current_correlation(12))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000100000001000000010000000100011001110110011101100111011001110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(12),
	datab => ALT_INV_previous_correlation(13),
	datac => ALT_INV_current_correlation(12),
	dataf => ALT_INV_current_correlation(13),
	combout => \LessThan2~6_combout\);

-- Location: MLABCELL_X65_Y4_N27
\LessThan2~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~7_combout\ = ( current_correlation(11) & ( (!previous_correlation(11)) # ((current_correlation(10) & !previous_correlation(10))) ) ) # ( !current_correlation(11) & ( (current_correlation(10) & (!previous_correlation(11) & 
-- !previous_correlation(10))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000000000000010100000000000011110101111100001111010111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(10),
	datac => ALT_INV_previous_correlation(11),
	datad => ALT_INV_previous_correlation(10),
	dataf => ALT_INV_current_correlation(11),
	combout => \LessThan2~7_combout\);

-- Location: MLABCELL_X65_Y4_N24
\LessThan0~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~18_combout\ = !previous_correlation(14) $ (!current_correlation(14))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111110000000011111111000000001111111100000000111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_previous_correlation(14),
	datad => ALT_INV_current_correlation(14),
	combout => \LessThan0~18_combout\);

-- Location: MLABCELL_X65_Y4_N33
\LessThan2~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~9_combout\ = ( \LessThan2~7_combout\ & ( \LessThan0~18_combout\ & ( (!\LessThan2~8_combout\ & ((!\LessThan0~0_combout\) # (\LessThan0~13_combout\))) ) ) ) # ( !\LessThan2~7_combout\ & ( \LessThan0~18_combout\ & ( !\LessThan2~8_combout\ ) ) ) # 
-- ( \LessThan2~7_combout\ & ( !\LessThan0~18_combout\ & ( (!\LessThan2~8_combout\ & (((!\LessThan0~0_combout\ & !\LessThan2~6_combout\)) # (\LessThan0~13_combout\))) ) ) ) # ( !\LessThan2~7_combout\ & ( !\LessThan0~18_combout\ & ( (!\LessThan2~8_combout\ & 
-- ((!\LessThan2~6_combout\) # (\LessThan0~13_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010000010101010100000001010101010101010101010101000100010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan2~8_combout\,
	datab => \ALT_INV_LessThan0~0_combout\,
	datac => \ALT_INV_LessThan2~6_combout\,
	datad => \ALT_INV_LessThan0~13_combout\,
	datae => \ALT_INV_LessThan2~7_combout\,
	dataf => \ALT_INV_LessThan0~18_combout\,
	combout => \LessThan2~9_combout\);

-- Location: IOIBUF_X60_Y0_N18
\recv.data[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(3),
	o => \recv.data[3]~input_o\);

-- Location: FF_X63_Y4_N11
\current_correlation[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[3]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(3));

-- Location: FF_X63_Y4_N23
\previous_correlation[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(3),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(3));

-- Location: IOIBUF_X60_Y0_N52
\recv.data[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(4),
	o => \recv.data[4]~input_o\);

-- Location: FF_X63_Y4_N29
\current_correlation[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[4]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(4));

-- Location: FF_X63_Y4_N50
\previous_correlation[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(4),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(4));

-- Location: IOIBUF_X60_Y0_N1
\recv.data[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(5),
	o => \recv.data[5]~input_o\);

-- Location: FF_X63_Y4_N47
\current_correlation[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[5]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(5));

-- Location: FF_X63_Y4_N35
\previous_correlation[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(5),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(5));

-- Location: LABCELL_X63_Y4_N57
\LessThan0~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~7_combout\ = ( current_correlation(5) & ( previous_correlation(5) & ( !current_correlation(4) $ (previous_correlation(4)) ) ) ) # ( !current_correlation(5) & ( !previous_correlation(5) & ( !current_correlation(4) $ (previous_correlation(4)) ) ) 
-- )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101001010101000000000000000000000000000000001010101001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(4),
	datad => ALT_INV_previous_correlation(4),
	datae => ALT_INV_current_correlation(5),
	dataf => ALT_INV_previous_correlation(5),
	combout => \LessThan0~7_combout\);

-- Location: LABCELL_X63_Y4_N18
\LessThan2~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~2_combout\ = ( current_correlation(5) & ( previous_correlation(5) & ( (current_correlation(4) & !previous_correlation(4)) ) ) ) # ( current_correlation(5) & ( !previous_correlation(5) ) ) # ( !current_correlation(5) & ( !previous_correlation(5) 
-- & ( (current_correlation(4) & !previous_correlation(4)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101000001010000111111111111111100000000000000000101000001010000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(4),
	datac => ALT_INV_previous_correlation(4),
	datae => ALT_INV_current_correlation(5),
	dataf => ALT_INV_previous_correlation(5),
	combout => \LessThan2~2_combout\);

-- Location: LABCELL_X62_Y4_N21
\LessThan0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~5_combout\ = ( previous_correlation(7) & ( current_correlation(7) & ( !previous_correlation(6) $ (current_correlation(6)) ) ) ) # ( !previous_correlation(7) & ( !current_correlation(7) & ( !previous_correlation(6) $ (current_correlation(6)) ) ) 
-- )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1100001111000011000000000000000000000000000000001100001111000011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_previous_correlation(6),
	datac => ALT_INV_current_correlation(6),
	datae => ALT_INV_previous_correlation(7),
	dataf => ALT_INV_current_correlation(7),
	combout => \LessThan0~5_combout\);

-- Location: IOIBUF_X60_Y0_N35
\recv.data[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(2),
	o => \recv.data[2]~input_o\);

-- Location: FF_X63_Y4_N56
\current_correlation[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[2]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(2));

-- Location: FF_X62_Y4_N35
\previous_correlation[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(2),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(2));

-- Location: IOIBUF_X58_Y0_N58
\recv.data[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(1),
	o => \recv.data[1]~input_o\);

-- Location: FF_X62_Y4_N47
\current_correlation[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[1]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(1));

-- Location: IOIBUF_X62_Y0_N18
\recv.data[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(0),
	o => \recv.data[0]~input_o\);

-- Location: FF_X62_Y4_N14
\current_correlation[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \recv.data[0]~input_o\,
	sload => VCC,
	ena => \Equal0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => current_correlation(0));

-- Location: FF_X62_Y4_N56
\previous_correlation[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(0),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(0));

-- Location: FF_X62_Y4_N50
\previous_correlation[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => current_correlation(1),
	sclr => \reset~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => previous_correlation(1));

-- Location: LABCELL_X62_Y4_N24
\LessThan2~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~1_combout\ = ( current_correlation(2) & ( previous_correlation(1) & ( (!previous_correlation(2)) # ((current_correlation(1) & (!previous_correlation(0) & current_correlation(0)))) ) ) ) # ( !current_correlation(2) & ( previous_correlation(1) & 
-- ( (!previous_correlation(2) & (current_correlation(1) & (!previous_correlation(0) & current_correlation(0)))) ) ) ) # ( current_correlation(2) & ( !previous_correlation(1) & ( (!previous_correlation(2)) # (((!previous_correlation(0) & 
-- current_correlation(0))) # (current_correlation(1))) ) ) ) # ( !current_correlation(2) & ( !previous_correlation(1) & ( (!previous_correlation(2) & (((!previous_correlation(0) & current_correlation(0))) # (current_correlation(1)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010001010100010101110111111101100000000001000001010101010111010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(2),
	datab => ALT_INV_current_correlation(1),
	datac => ALT_INV_previous_correlation(0),
	datad => ALT_INV_current_correlation(0),
	datae => ALT_INV_current_correlation(2),
	dataf => ALT_INV_previous_correlation(1),
	combout => \LessThan2~1_combout\);

-- Location: LABCELL_X63_Y4_N15
\LessThan2~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~3_combout\ = ( \LessThan0~5_combout\ & ( \LessThan2~1_combout\ & ( ((\LessThan0~7_combout\ & ((!previous_correlation(3)) # (current_correlation(3))))) # (\LessThan2~2_combout\) ) ) ) # ( \LessThan0~5_combout\ & ( !\LessThan2~1_combout\ & ( 
-- ((!previous_correlation(3) & (current_correlation(3) & \LessThan0~7_combout\))) # (\LessThan2~2_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000101111111100000000000000000000101111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(3),
	datab => ALT_INV_current_correlation(3),
	datac => \ALT_INV_LessThan0~7_combout\,
	datad => \ALT_INV_LessThan2~2_combout\,
	datae => \ALT_INV_LessThan0~5_combout\,
	dataf => \ALT_INV_LessThan2~1_combout\,
	combout => \LessThan2~3_combout\);

-- Location: LABCELL_X63_Y4_N30
\LessThan0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~3_combout\ = ( current_correlation(8) & ( !previous_correlation(8) ) ) # ( !current_correlation(8) & ( previous_correlation(8) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_previous_correlation(8),
	dataf => ALT_INV_current_correlation(8),
	combout => \LessThan0~3_combout\);

-- Location: LABCELL_X64_Y4_N27
\LessThan0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~4_combout\ = ( !\LessThan0~1_combout\ & ( \LessThan0~0_combout\ & ( (!\LessThan0~2_combout\ & (!\LessThan0~3_combout\ & (!previous_correlation(9) $ (current_correlation(9))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000010000100000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(9),
	datab => \ALT_INV_LessThan0~2_combout\,
	datac => ALT_INV_current_correlation(9),
	datad => \ALT_INV_LessThan0~3_combout\,
	datae => \ALT_INV_LessThan0~1_combout\,
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \LessThan0~4_combout\);

-- Location: LABCELL_X64_Y4_N48
\LessThan2~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan2~10_combout\ = ( \LessThan0~13_combout\ & ( \LessThan0~4_combout\ & ( (!\LessThan2~5_combout\ & \LessThan2~9_combout\) ) ) ) # ( !\LessThan0~13_combout\ & ( \LessThan0~4_combout\ & ( (!\LessThan2~0_combout\ & (!\LessThan2~5_combout\ & 
-- (\LessThan2~9_combout\ & !\LessThan2~3_combout\))) ) ) ) # ( \LessThan0~13_combout\ & ( !\LessThan0~4_combout\ & ( (!\LessThan2~5_combout\ & \LessThan2~9_combout\) ) ) ) # ( !\LessThan0~13_combout\ & ( !\LessThan0~4_combout\ & ( (!\LessThan2~5_combout\ & 
-- \LessThan2~9_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110000001100000011000000110000001000000000000000110000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan2~0_combout\,
	datab => \ALT_INV_LessThan2~5_combout\,
	datac => \ALT_INV_LessThan2~9_combout\,
	datad => \ALT_INV_LessThan2~3_combout\,
	datae => \ALT_INV_LessThan0~13_combout\,
	dataf => \ALT_INV_LessThan0~4_combout\,
	combout => \LessThan2~10_combout\);

-- Location: MLABCELL_X65_Y4_N51
\correlation_count_signal~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \correlation_count_signal~0_combout\ = ( previous_correlation(15) & ( !current_correlation(15) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011110000111100001111000011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_current_correlation(15),
	dataf => ALT_INV_previous_correlation(15),
	combout => \correlation_count_signal~0_combout\);

-- Location: LABCELL_X62_Y4_N0
\LessThan0~11\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~11_combout\ = ( current_correlation(6) & ( (!current_correlation(7) & previous_correlation(7)) ) ) # ( !current_correlation(6) & ( (!current_correlation(7) & ((previous_correlation(6)) # (previous_correlation(7)))) # (current_correlation(7) & 
-- (previous_correlation(7) & previous_correlation(6))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000110011001111000011001100111100001100000011000000110000001100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_current_correlation(7),
	datac => ALT_INV_previous_correlation(7),
	datad => ALT_INV_previous_correlation(6),
	dataf => ALT_INV_current_correlation(6),
	combout => \LessThan0~11_combout\);

-- Location: LABCELL_X63_Y4_N42
\LessThan0~12\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~12_combout\ = ( \LessThan0~5_combout\ & ( !\LessThan0~11_combout\ & ( (!previous_correlation(5) & (((!previous_correlation(4)) # (current_correlation(5))) # (current_correlation(4)))) # (previous_correlation(5) & (current_correlation(5) & 
-- ((!previous_correlation(4)) # (current_correlation(4))))) ) ) ) # ( !\LessThan0~5_combout\ & ( !\LessThan0~11_combout\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111101000101111101100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(5),
	datab => ALT_INV_current_correlation(4),
	datac => ALT_INV_previous_correlation(4),
	datad => ALT_INV_current_correlation(5),
	datae => \ALT_INV_LessThan0~5_combout\,
	dataf => \ALT_INV_LessThan0~11_combout\,
	combout => \LessThan0~12_combout\);

-- Location: LABCELL_X63_Y4_N36
\LessThan0~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~8_combout\ = ( previous_correlation(3) & ( previous_correlation(2) & ( (current_correlation(2) & current_correlation(3)) ) ) ) # ( !previous_correlation(3) & ( previous_correlation(2) & ( (current_correlation(2) & !current_correlation(3)) ) ) ) 
-- # ( previous_correlation(3) & ( !previous_correlation(2) & ( (!current_correlation(2) & current_correlation(3)) ) ) ) # ( !previous_correlation(3) & ( !previous_correlation(2) & ( (!current_correlation(2) & !current_correlation(3)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111000000000000000000001111000000001111000000000000000000001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_current_correlation(2),
	datad => ALT_INV_current_correlation(3),
	datae => ALT_INV_previous_correlation(3),
	dataf => ALT_INV_previous_correlation(2),
	combout => \LessThan0~8_combout\);

-- Location: LABCELL_X63_Y4_N0
\LessThan0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~9_combout\ = ( previous_correlation(3) & ( previous_correlation(2) & ( (!current_correlation(2)) # (!current_correlation(3)) ) ) ) # ( !previous_correlation(3) & ( previous_correlation(2) & ( (!current_correlation(2) & !current_correlation(3)) 
-- ) ) ) # ( previous_correlation(3) & ( !previous_correlation(2) & ( !current_correlation(3) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111110000000011110000000000001111111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_current_correlation(2),
	datad => ALT_INV_current_correlation(3),
	datae => ALT_INV_previous_correlation(3),
	dataf => ALT_INV_previous_correlation(2),
	combout => \LessThan0~9_combout\);

-- Location: LABCELL_X62_Y4_N6
\LessThan0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~6_combout\ = ( current_correlation(1) & ( previous_correlation(1) & ( (previous_correlation(0) & !current_correlation(0)) ) ) ) # ( !current_correlation(1) & ( previous_correlation(1) ) ) # ( !current_correlation(1) & ( !previous_correlation(1) 
-- & ( (previous_correlation(0) & !current_correlation(0)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100000000000000000000000011111111111111110000111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_previous_correlation(0),
	datad => ALT_INV_current_correlation(0),
	datae => ALT_INV_current_correlation(1),
	dataf => ALT_INV_previous_correlation(1),
	combout => \LessThan0~6_combout\);

-- Location: LABCELL_X63_Y4_N51
\LessThan0~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~10_combout\ = ( \LessThan0~5_combout\ & ( \LessThan0~6_combout\ & ( (\LessThan0~7_combout\ & ((\LessThan0~9_combout\) # (\LessThan0~8_combout\))) ) ) ) # ( \LessThan0~5_combout\ & ( !\LessThan0~6_combout\ & ( (\LessThan0~7_combout\ & 
-- \LessThan0~9_combout\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000111100000000000000000000010100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan0~8_combout\,
	datac => \ALT_INV_LessThan0~7_combout\,
	datad => \ALT_INV_LessThan0~9_combout\,
	datae => \ALT_INV_LessThan0~5_combout\,
	dataf => \ALT_INV_LessThan0~6_combout\,
	combout => \LessThan0~10_combout\);

-- Location: LABCELL_X63_Y4_N6
\LessThan0~16\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~16_combout\ = ( !current_correlation(8) & ( previous_correlation(8) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_previous_correlation(8),
	dataf => ALT_INV_current_correlation(8),
	combout => \LessThan0~16_combout\);

-- Location: LABCELL_X64_Y4_N39
\LessThan0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~17_combout\ = ( !\LessThan0~1_combout\ & ( \LessThan0~0_combout\ & ( (!\LessThan0~2_combout\ & ((!previous_correlation(9) & (!current_correlation(9) & \LessThan0~16_combout\)) # (previous_correlation(9) & ((!current_correlation(9)) # 
-- (\LessThan0~16_combout\))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000001000000110001000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(9),
	datab => \ALT_INV_LessThan0~2_combout\,
	datac => ALT_INV_current_correlation(9),
	datad => \ALT_INV_LessThan0~16_combout\,
	datae => \ALT_INV_LessThan0~1_combout\,
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \LessThan0~17_combout\);

-- Location: MLABCELL_X65_Y4_N9
\LessThan0~14\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~14_combout\ = ( previous_correlation(14) & ( current_correlation(12) & ( (!current_correlation(14)) # ((!current_correlation(13) & previous_correlation(13))) ) ) ) # ( !previous_correlation(14) & ( current_correlation(12) & ( 
-- (!current_correlation(13) & (previous_correlation(13) & !current_correlation(14))) ) ) ) # ( previous_correlation(14) & ( !current_correlation(12) & ( (!current_correlation(14)) # ((!current_correlation(13) & ((previous_correlation(12)) # 
-- (previous_correlation(13)))) # (current_correlation(13) & (previous_correlation(13) & previous_correlation(12)))) ) ) ) # ( !previous_correlation(14) & ( !current_correlation(12) & ( (!current_correlation(14) & ((!current_correlation(13) & 
-- ((previous_correlation(12)) # (previous_correlation(13)))) # (current_correlation(13) & (previous_correlation(13) & previous_correlation(12))))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010000010110000111100101111101100100000001000001111001011110010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_current_correlation(13),
	datab => ALT_INV_previous_correlation(13),
	datac => ALT_INV_current_correlation(14),
	datad => ALT_INV_previous_correlation(12),
	datae => ALT_INV_previous_correlation(14),
	dataf => ALT_INV_current_correlation(12),
	combout => \LessThan0~14_combout\);

-- Location: MLABCELL_X65_Y4_N42
\LessThan0~15\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~15_combout\ = ( current_correlation(11) & ( \LessThan0~0_combout\ & ( (!\LessThan0~14_combout\ & ((!previous_correlation(10)) # ((!previous_correlation(11)) # (current_correlation(10))))) ) ) ) # ( !current_correlation(11) & ( 
-- \LessThan0~0_combout\ & ( (!previous_correlation(11) & (!\LessThan0~14_combout\ & ((!previous_correlation(10)) # (current_correlation(10))))) ) ) ) # ( current_correlation(11) & ( !\LessThan0~0_combout\ & ( !\LessThan0~14_combout\ ) ) ) # ( 
-- !current_correlation(11) & ( !\LessThan0~0_combout\ & ( !\LessThan0~14_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111100000000111111110000000010001100000000001110111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_previous_correlation(10),
	datab => ALT_INV_previous_correlation(11),
	datac => ALT_INV_current_correlation(10),
	datad => \ALT_INV_LessThan0~14_combout\,
	datae => ALT_INV_current_correlation(11),
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \LessThan0~15_combout\);

-- Location: LABCELL_X64_Y4_N18
\correlation_count_signal~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \correlation_count_signal~1_combout\ = ( \LessThan0~4_combout\ & ( \LessThan0~15_combout\ & ( (!\LessThan0~13_combout\ & ((!\LessThan0~12_combout\) # ((\LessThan0~17_combout\) # (\LessThan0~10_combout\)))) ) ) ) # ( !\LessThan0~4_combout\ & ( 
-- \LessThan0~15_combout\ & ( (!\LessThan0~13_combout\ & \LessThan0~17_combout\) ) ) ) # ( \LessThan0~4_combout\ & ( !\LessThan0~15_combout\ & ( !\LessThan0~13_combout\ ) ) ) # ( !\LessThan0~4_combout\ & ( !\LessThan0~15_combout\ & ( !\LessThan0~13_combout\ 
-- ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101010101010101010101010101000000000101010101000101010101010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan0~13_combout\,
	datab => \ALT_INV_LessThan0~12_combout\,
	datac => \ALT_INV_LessThan0~10_combout\,
	datad => \ALT_INV_LessThan0~17_combout\,
	datae => \ALT_INV_LessThan0~4_combout\,
	dataf => \ALT_INV_LessThan0~15_combout\,
	combout => \correlation_count_signal~1_combout\);

-- Location: MLABCELL_X65_Y4_N15
\edge~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \edge~0_combout\ = ( \edge~q\ & ( \correlation_count_signal~1_combout\ & ( \LessThan2~10_combout\ ) ) ) # ( !\edge~q\ & ( \correlation_count_signal~1_combout\ ) ) # ( \edge~q\ & ( !\correlation_count_signal~1_combout\ & ( \LessThan2~10_combout\ ) ) ) # ( 
-- !\edge~q\ & ( !\correlation_count_signal~1_combout\ & ( \correlation_count_signal~0_combout\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111001100110011001111111111111111110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_LessThan2~10_combout\,
	datac => \ALT_INV_correlation_count_signal~0_combout\,
	datae => \ALT_INV_edge~q\,
	dataf => \ALT_INV_correlation_count_signal~1_combout\,
	combout => \edge~0_combout\);

-- Location: FF_X65_Y4_N17
edge : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \edge~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \edge~q\);

-- Location: IOIBUF_X56_Y0_N52
\recv.data[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(16),
	o => \recv.data[16]~input_o\);

-- Location: LABCELL_X60_Y4_N12
\invert_signal~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \invert_signal~0_combout\ = ( \recv.data[31]~input_o\ & ( \recv.data[16]~input_o\ & ( (!\recv.data[28]~input_o\ & (\recv.data[30]~input_o\ & !\recv.data[29]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000010000000100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_recv.data[28]~input_o\,
	datab => \ALT_INV_recv.data[30]~input_o\,
	datac => \ALT_INV_recv.data[29]~input_o\,
	datae => \ALT_INV_recv.data[31]~input_o\,
	dataf => \ALT_INV_recv.data[16]~input_o\,
	combout => \invert_signal~0_combout\);

-- Location: FF_X60_Y4_N14
invert_signal : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \invert_signal~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \invert_signal~q\);

-- Location: LABCELL_X64_Y4_N45
\correlation_count_signal~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \correlation_count_signal~2_combout\ = ( \LessThan2~10_combout\ & ( (!\edge~q\ & (!\invert_signal~q\ & ((\correlation_count_signal~1_combout\) # (\correlation_count_signal~0_combout\)))) ) ) # ( !\LessThan2~10_combout\ & ( (!\edge~q\ & (!\invert_signal~q\ 
-- & ((\correlation_count_signal~1_combout\) # (\correlation_count_signal~0_combout\)))) # (\edge~q\ & (((\invert_signal~q\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010010110100101001001011010010100100000101000000010000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_edge~q\,
	datab => \ALT_INV_correlation_count_signal~0_combout\,
	datac => \ALT_INV_invert_signal~q\,
	datad => \ALT_INV_correlation_count_signal~1_combout\,
	dataf => \ALT_INV_LessThan2~10_combout\,
	combout => \correlation_count_signal~2_combout\);

-- Location: FF_X66_Y4_N2
\count[0]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[0]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N0
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( \count[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))
-- \Add0~2\ = CARRY(( \count[0]~DUPLICATE_q\ ) + ( VCC ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_count[0]~DUPLICATE_q\,
	cin => GND,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X66_Y4_N1
\count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(0));

-- Location: LABCELL_X64_Y4_N54
\correlation_count_signal[8]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \correlation_count_signal[8]~3_combout\ = ( \LessThan2~10_combout\ & ( \correlation_count_signal~1_combout\ & ( ((!\edge~q\ & !\invert_signal~q\)) # (\reset~input_o\) ) ) ) # ( !\LessThan2~10_combout\ & ( \correlation_count_signal~1_combout\ & ( 
-- (!\edge~q\ $ (\invert_signal~q\)) # (\reset~input_o\) ) ) ) # ( \LessThan2~10_combout\ & ( !\correlation_count_signal~1_combout\ & ( ((!\edge~q\ & (\correlation_count_signal~0_combout\ & !\invert_signal~q\))) # (\reset~input_o\) ) ) ) # ( 
-- !\LessThan2~10_combout\ & ( !\correlation_count_signal~1_combout\ & ( ((!\edge~q\ & (\correlation_count_signal~0_combout\ & !\invert_signal~q\)) # (\edge~q\ & ((\invert_signal~q\)))) # (\reset~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0010111101011111001011110000111110101111010111111010111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_edge~q\,
	datab => \ALT_INV_correlation_count_signal~0_combout\,
	datac => \ALT_INV_reset~input_o\,
	datad => \ALT_INV_invert_signal~q\,
	datae => \ALT_INV_LessThan2~10_combout\,
	dataf => \ALT_INV_correlation_count_signal~1_combout\,
	combout => \correlation_count_signal[8]~3_combout\);

-- Location: FF_X64_Y4_N52
\correlation_count_signal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(0),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(0));

-- Location: LABCELL_X66_Y4_N51
\send.data[0]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[0]~reg0feeder_combout\ = ( correlation_count_signal(0) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => ALT_INV_correlation_count_signal(0),
	combout => \send.data[0]~reg0feeder_combout\);

-- Location: FF_X65_Y4_N11
send_flag : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => \correlation_count_signal~2_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send_flag~q\);

-- Location: FF_X66_Y4_N52
\send.data[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[0]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[0]~reg0_q\);

-- Location: LABCELL_X66_Y4_N3
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( count(1) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( count(1) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_count(1),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: FF_X66_Y4_N5
\count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(1));

-- Location: FF_X64_Y4_N26
\correlation_count_signal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(1),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(1));

-- Location: FF_X63_Y4_N1
\send.data[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(1),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[1]~reg0_q\);

-- Location: LABCELL_X66_Y4_N6
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( count(2) ) + ( GND ) + ( \Add0~6\ ))
-- \Add0~10\ = CARRY(( count(2) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_count(2),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\,
	cout => \Add0~10\);

-- Location: FF_X66_Y4_N7
\count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(2));

-- Location: FF_X64_Y4_N16
\correlation_count_signal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(2),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(2));

-- Location: LABCELL_X68_Y4_N48
\send.data[2]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[2]~reg0feeder_combout\ = correlation_count_signal(2)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_correlation_count_signal(2),
	combout => \send.data[2]~reg0feeder_combout\);

-- Location: FF_X68_Y4_N50
\send.data[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[2]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[2]~reg0_q\);

-- Location: FF_X66_Y4_N11
\count[3]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[3]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N9
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( \count[3]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~10\ ))
-- \Add0~14\ = CARRY(( \count[3]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~10\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[3]~DUPLICATE_q\,
	cin => \Add0~10\,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: FF_X66_Y4_N10
\count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(3));

-- Location: FF_X64_Y4_N4
\correlation_count_signal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(3),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(3));

-- Location: FF_X65_Y4_N43
\send.data[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(3),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[3]~reg0_q\);

-- Location: FF_X66_Y4_N14
\count[4]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[4]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N12
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( \count[4]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( \count[4]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_count[4]~DUPLICATE_q\,
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X66_Y4_N13
\count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(4));

-- Location: FF_X64_Y4_N56
\correlation_count_signal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(4),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(4));

-- Location: FF_X65_Y4_N58
\send.data[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(4),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[4]~reg0_q\);

-- Location: FF_X66_Y4_N17
\count[5]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[5]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N15
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( \count[5]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( \count[5]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[5]~DUPLICATE_q\,
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X66_Y4_N16
\count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(5));

-- Location: FF_X64_Y4_N37
\correlation_count_signal[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(5),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(5));

-- Location: LABCELL_X67_Y4_N0
\send.data[5]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[5]~reg0feeder_combout\ = correlation_count_signal(5)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_correlation_count_signal(5),
	combout => \send.data[5]~reg0feeder_combout\);

-- Location: FF_X67_Y4_N1
\send.data[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[5]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[5]~reg0_q\);

-- Location: LABCELL_X66_Y4_N18
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( count(6) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( count(6) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_count(6),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X66_Y4_N20
\count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(6));

-- Location: FF_X64_Y4_N1
\correlation_count_signal[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(6),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(6));

-- Location: LABCELL_X68_Y4_N54
\send.data[6]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[6]~reg0feeder_combout\ = correlation_count_signal(6)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_correlation_count_signal(6),
	combout => \send.data[6]~reg0feeder_combout\);

-- Location: FF_X68_Y4_N56
\send.data[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[6]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[6]~reg0_q\);

-- Location: LABCELL_X66_Y4_N21
\Add0~29\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~29_sumout\ = SUM(( count(7) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~30\ = CARRY(( count(7) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_count(7),
	cin => \Add0~26\,
	sumout => \Add0~29_sumout\,
	cout => \Add0~30\);

-- Location: FF_X66_Y4_N23
\count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~29_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(7));

-- Location: FF_X64_Y4_N34
\correlation_count_signal[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(7),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(7));

-- Location: LABCELL_X67_Y4_N45
\send.data[7]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[7]~reg0feeder_combout\ = correlation_count_signal(7)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_correlation_count_signal(7),
	combout => \send.data[7]~reg0feeder_combout\);

-- Location: FF_X67_Y4_N46
\send.data[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[7]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[7]~reg0_q\);

-- Location: FF_X66_Y4_N26
\count[8]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[8]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N24
\Add0~33\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~33_sumout\ = SUM(( \count[8]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~30\ ))
-- \Add0~34\ = CARRY(( \count[8]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~30\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[8]~DUPLICATE_q\,
	cin => \Add0~30\,
	sumout => \Add0~33_sumout\,
	cout => \Add0~34\);

-- Location: FF_X66_Y4_N25
\count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~33_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(8));

-- Location: FF_X64_Y4_N13
\correlation_count_signal[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(8),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(8));

-- Location: LABCELL_X68_Y4_N24
\send.data[8]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[8]~reg0feeder_combout\ = correlation_count_signal(8)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => ALT_INV_correlation_count_signal(8),
	combout => \send.data[8]~reg0feeder_combout\);

-- Location: FF_X68_Y4_N25
\send.data[8]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[8]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[8]~reg0_q\);

-- Location: LABCELL_X66_Y4_N27
\Add0~37\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~37_sumout\ = SUM(( count(9) ) + ( GND ) + ( \Add0~34\ ))
-- \Add0~38\ = CARRY(( count(9) ) + ( GND ) + ( \Add0~34\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_count(9),
	cin => \Add0~34\,
	sumout => \Add0~37_sumout\,
	cout => \Add0~38\);

-- Location: FF_X66_Y4_N29
\count[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~37_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(9));

-- Location: FF_X64_Y4_N22
\correlation_count_signal[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(9),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(9));

-- Location: LABCELL_X68_Y4_N33
\send.data[9]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[9]~reg0feeder_combout\ = correlation_count_signal(9)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_correlation_count_signal(9),
	combout => \send.data[9]~reg0feeder_combout\);

-- Location: FF_X68_Y4_N35
\send.data[9]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[9]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[9]~reg0_q\);

-- Location: FF_X66_Y4_N31
\count[10]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[10]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N30
\Add0~41\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~41_sumout\ = SUM(( \count[10]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~38\ ))
-- \Add0~42\ = CARRY(( \count[10]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~38\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[10]~DUPLICATE_q\,
	cin => \Add0~38\,
	sumout => \Add0~41_sumout\,
	cout => \Add0~42\);

-- Location: FF_X66_Y4_N32
\count[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~41_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(10));

-- Location: FF_X64_Y4_N43
\correlation_count_signal[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(10),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(10));

-- Location: FF_X65_Y4_N46
\send.data[10]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(10),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[10]~reg0_q\);

-- Location: FF_X66_Y4_N35
\count[11]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[11]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N33
\Add0~45\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~45_sumout\ = SUM(( \count[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~42\ ))
-- \Add0~46\ = CARRY(( \count[11]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~42\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_count[11]~DUPLICATE_q\,
	cin => \Add0~42\,
	sumout => \Add0~45_sumout\,
	cout => \Add0~46\);

-- Location: FF_X66_Y4_N34
\count[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~45_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(11));

-- Location: FF_X64_Y4_N47
\correlation_count_signal[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(11),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(11));

-- Location: FF_X68_Y4_N37
\send.data[11]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(11),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[11]~reg0_q\);

-- Location: LABCELL_X66_Y4_N36
\Add0~49\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~49_sumout\ = SUM(( count(12) ) + ( GND ) + ( \Add0~46\ ))
-- \Add0~50\ = CARRY(( count(12) ) + ( GND ) + ( \Add0~46\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_count(12),
	cin => \Add0~46\,
	sumout => \Add0~49_sumout\,
	cout => \Add0~50\);

-- Location: FF_X66_Y4_N38
\count[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~49_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(12));

-- Location: FF_X64_Y4_N29
\correlation_count_signal[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(12),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(12));

-- Location: LABCELL_X68_Y4_N18
\send.data[12]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[12]~reg0feeder_combout\ = correlation_count_signal(12)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_correlation_count_signal(12),
	combout => \send.data[12]~reg0feeder_combout\);

-- Location: FF_X68_Y4_N19
\send.data[12]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[12]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[12]~reg0_q\);

-- Location: FF_X66_Y4_N41
\count[13]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[13]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N39
\Add0~53\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~53_sumout\ = SUM(( \count[13]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~50\ ))
-- \Add0~54\ = CARRY(( \count[13]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~50\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[13]~DUPLICATE_q\,
	cin => \Add0~50\,
	sumout => \Add0~53_sumout\,
	cout => \Add0~54\);

-- Location: FF_X66_Y4_N40
\count[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~53_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(13));

-- Location: FF_X64_Y4_N59
\correlation_count_signal[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(13),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(13));

-- Location: FF_X62_Y4_N26
\send.data[13]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(13),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[13]~reg0_q\);

-- Location: FF_X66_Y4_N44
\count[14]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[14]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N42
\Add0~57\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~57_sumout\ = SUM(( \count[14]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~54\ ))
-- \Add0~58\ = CARRY(( \count[14]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~54\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_count[14]~DUPLICATE_q\,
	cin => \Add0~54\,
	sumout => \Add0~57_sumout\,
	cout => \Add0~58\);

-- Location: FF_X66_Y4_N43
\count[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~57_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(14));

-- Location: FF_X64_Y4_N32
\correlation_count_signal[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(14),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(14));

-- Location: FF_X63_Y4_N4
\send.data[14]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(14),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[14]~reg0_q\);

-- Location: FF_X66_Y4_N47
\count[15]~DUPLICATE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \count[15]~DUPLICATE_q\);

-- Location: LABCELL_X66_Y4_N45
\Add0~61\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~61_sumout\ = SUM(( \count[15]~DUPLICATE_q\ ) + ( GND ) + ( \Add0~58\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_count[15]~DUPLICATE_q\,
	cin => \Add0~58\,
	sumout => \Add0~61_sumout\);

-- Location: FF_X66_Y4_N46
\count[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \Add0~61_sumout\,
	sclr => \correlation_count_signal~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => count(15));

-- Location: FF_X64_Y4_N40
\correlation_count_signal[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => count(15),
	sclr => \ALT_INV_correlation_count_signal~2_combout\,
	sload => VCC,
	ena => \correlation_count_signal[8]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => correlation_count_signal(15));

-- Location: FF_X62_Y4_N19
\send.data[15]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	asdata => correlation_count_signal(15),
	sload => VCC,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[15]~reg0_q\);

-- Location: LABCELL_X62_Y4_N3
\send.data[31]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \send.data[31]~reg0feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	combout => \send.data[31]~reg0feeder_combout\);

-- Location: FF_X62_Y4_N4
\send.data[31]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \send.data[31]~reg0feeder_combout\,
	ena => \send_flag~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \send.data[31]~reg0_q\);

-- Location: IOIBUF_X76_Y0_N52
\recv.data[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(17),
	o => \recv.data[17]~input_o\);

-- Location: IOIBUF_X88_Y0_N53
\recv.data[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(18),
	o => \recv.data[18]~input_o\);

-- Location: IOIBUF_X16_Y0_N52
\recv.data[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(19),
	o => \recv.data[19]~input_o\);

-- Location: IOIBUF_X50_Y0_N41
\recv.data[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(20),
	o => \recv.data[20]~input_o\);

-- Location: IOIBUF_X18_Y81_N92
\recv.data[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(21),
	o => \recv.data[21]~input_o\);

-- Location: IOIBUF_X20_Y81_N1
\recv.data[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(22),
	o => \recv.data[22]~input_o\);

-- Location: IOIBUF_X30_Y0_N1
\recv.data[23]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(23),
	o => \recv.data[23]~input_o\);

-- Location: IOIBUF_X26_Y81_N58
\recv.data[24]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(24),
	o => \recv.data[24]~input_o\);

-- Location: IOIBUF_X89_Y20_N78
\recv.data[25]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(25),
	o => \recv.data[25]~input_o\);

-- Location: IOIBUF_X89_Y16_N55
\recv.data[26]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(26),
	o => \recv.data[26]~input_o\);

-- Location: IOIBUF_X10_Y81_N92
\recv.data[27]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.data\(27),
	o => \recv.data[27]~input_o\);

-- Location: IOIBUF_X36_Y0_N35
\recv.addr[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(0),
	o => \recv.addr[0]~input_o\);

-- Location: IOIBUF_X10_Y81_N58
\recv.addr[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(1),
	o => \recv.addr[1]~input_o\);

-- Location: IOIBUF_X18_Y0_N41
\recv.addr[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(2),
	o => \recv.addr[2]~input_o\);

-- Location: IOIBUF_X22_Y81_N35
\recv.addr[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(3),
	o => \recv.addr[3]~input_o\);

-- Location: IOIBUF_X24_Y0_N35
\recv.addr[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(4),
	o => \recv.addr[4]~input_o\);

-- Location: IOIBUF_X36_Y81_N18
\recv.addr[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(5),
	o => \recv.addr[5]~input_o\);

-- Location: IOIBUF_X20_Y81_N52
\recv.addr[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(6),
	o => \recv.addr[6]~input_o\);

-- Location: IOIBUF_X82_Y0_N92
\recv.addr[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_recv.addr\(7),
	o => \recv.addr[7]~input_o\);

-- Location: LABCELL_X56_Y14_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


