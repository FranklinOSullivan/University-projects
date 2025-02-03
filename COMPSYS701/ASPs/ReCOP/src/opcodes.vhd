------------------------------------------------------------------------------
-- Author's: Dylan Chamberlain, Franklin O'Sullivan
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.recop_types.all;

package opcodes is

    -- instruction format
    -- ---------------------------------------------
    -- |AM(2)|OP(6)|Rz(4)|Rx(4)|ADDR/VAL/OTHERs(16)|
    -- ---------------------------------------------
    -- addressing modes (AM)
    constant am_inherent  : bit_2 := "00";
    constant am_immediate : bit_2 := "01";
    constant am_direct    : bit_2 := "10";

    -- instruction format
    -- -----------------------------------------
    -- |AM(2)|OP(6)|Rz(4)|Rx(4)|Ry(4)|EMPTY(12)|
    -- -----------------------------------------
    constant am_register : bit_2 := "11";

    -----------------------------	
    --   normal instructions   --
    -----------------------------
    constant NOOP : bit_6 := "000000";

    -- operations with immediate, direct and indirect AM
    -- immediate: LDR Rz #value
    -- indirect: LDR Rz $address
    -- register: LDR Rz Rx
    constant LDR : bit_6 := "000010";

    -- operations with direct and immediate AM
    -- immediate: STR Rz #value
    -- indirect: STR Rx Rz
    -- register: STR Rx $address
    constant STR : bit_6 := "000011";

    -- operations with immediate and direct AM
    -- immediate: JMP #address 
    -- register: JMP Rx 
    constant JMP : bit_6 := "000100";
    -- operations with immediate and direct AM
    -- immediate: JAL Rz #address 
    -- register: JAL Rz Rx 
    constant JAL : bit_6 := "000101";

    -- operations with direct AM
    -- immediate: BEQ Rz Rx #address 
    constant BEQ : bit_6 := "000110";
    -- immediate: BNE Rz Rx #address
    constant BNE : bit_6 := "000111";

    -- operations with immediate and register AM
    constant ADDR : bit_6 := "010000"; --  ADD Rz Rx Op, ADD Ry Rx Rz
    constant SUBR : bit_6 := "010001"; --  SUB RZ Rx Op, SUB Ry Rx Rz
    constant ANDR : bit_6 := "010010"; --  AND Rz Rx Op, AND Ry Rx Rz
    constant ORR  : bit_6 := "010011"; --  OR Rz Rx Op,  OR Ry Rx Rz
    constant XORR : bit_6 := "010100"; --  XOR Rz Rx Op, XOR Ry Rx Rz
    constant MAX  : bit_6 := "010101"; --  MAX Rz Rx Op, MAX Ry Rx Rz
    constant SLLR : bit_6 := "010110"; --  SLL Rz Rx Op, SLL Ry Rx Rz
    constant SRLR : bit_6 := "010111"; --  SRL Rz Rx Op, SRL Ry Rx Rz

    ---------------------------
    --  other instructions  --
    ---------------------------

    -- operations with register and immediate AM
    -- register:  DCALL Rz Rx
    -- immediate: DCALL Rz #Operadnd
    constant DCALL : bit_6 := "100000";
    constant POPR  : bit_6 := "100001";

    -- Memory mapped IO addresses
    constant HEX0_ADDR       : bit_16 := x"8000";
    constant HEX1_ADDR       : bit_16 := x"8002";
    constant HEX2_ADDR       : bit_16 := x"8004";
    constant HEX3_ADDR       : bit_16 := x"8006";
    constant HEX4_ADDR       : bit_16 := x"8008";
    constant HEX5_ADDR       : bit_16 := x"800A";
    constant LEDR_ADDR       : bit_16 := x"800C";
    constant SWITCHES_ADDR   : bit_16 := x"800E";
    constant KEY_ADDR        : bit_16 := x"8010";
    constant TO_NOC_ADDR_U   : bit_16 := x"8012";
    constant TO_NOC_ADDR_L   : bit_16 := x"8014";
    constant FROM_NOC_ADDR_U : bit_16 := x"8016";
    constant FROM_NOC_ADDR_L : bit_16 := x"8018";
end opcodes;