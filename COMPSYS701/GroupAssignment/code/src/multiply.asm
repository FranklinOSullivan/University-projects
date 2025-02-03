main:
loop:
    LDR T0 $SWITCHES ; Load the value of the switches

    ; Split into 2 values
    SRL A1 T0 #4
    AND A1 A1 #0xF ; A1 = SWITCHES >> 4 & 0xF
    AND A0 T0 #0xF ; A0 = SWITCHES & 0xF

    ; Add together
    ADD S0 A0 A1 ; S0 = A0 + A1

    ; Multiply
    JAL RA #mult ; V0 = A0 * A1

    ; Store the two digits in hex0 and hex1
    STR V0 $LEDR ; LEDR = V0
    STR A0 $HEX0 ; HEX0 = A0
    STR A1 $HEX1 ; HEX1 = A1

    ; Store the sum in hex2 and hex3
    SRL T1 S0 #4 
    AND T1 T1 #0xF ; T1 = S0 >> 4 & 0xF 
    AND T0 S0 #0xF ; T0 = S0 & 0xF
    STR T0 $HEX2 ; HEX2 = T0
    STR T1 $HEX3 ; HEX3 = T1

    ; Store the product in hex4 and hex5
    SRL T1 V0 #4
    AND T1 T1 #0xF ; T1 = V0 >> 4 & 0xF
    AND T0 V0 #0xF ; T0 = V0 & 0xFF
    STR T0 $HEX4 ; HEX4 = T0
    STR T1 $HEX5 ; HEX5 = T1

    ; Jump to the start of the main loop
    JMP #LOOP


mult: ; A0 = A, A1 == B, V0 = Result = A * B
    SUB SP SP #2 ; Store on stack
    STR S0 SP ; USE S0 to show stack works

    LDR V0 #0 ; V0 is the result
    OR S0 A0 R0 ; S0 is counter
mult_loop:
    BEQ S0 R0 #mult_end ; Loop until counter is 0
    ADD V0 V0 A1 ; Add B to result
    SUB S0 S0 #1 ; Decrement counter
    JMP #mult_loop
mult_end:
    LDR S0 SP ; Load Stored on stack
    ADD SP SP #2
    JMP RA