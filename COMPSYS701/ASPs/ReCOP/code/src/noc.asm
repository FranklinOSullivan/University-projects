main:
; Setup
    LDR S0 #0
    
loop:
    LDR S1 #1249
    ; HEX0
    OR A0 S1 RZ
    JAL #divide_by_10: ; V0 = A0 / 10
    OR A0 V0 RZ ; A0 = V0
    JAL #mult_by_10: ; V0 = A0 * 10
    SUB T0 S1 V0 ; T0 = S1 - V0 ; S1 MOD 10
    STR T0 $HEX0

    ; HEX1
    OR S1 S2 RZ
    OR A0 S1 RZ
    JAL #divide_by_10: ; V0 = A0 / 10
    OR S2 V0 RZ ; S2 = V0
    OR A0 V0 RZ ; A0 = V0
    JAL #mult_by_10: ; V0 = A0 * 10
    SUB T0 S1 V0 ; T0 = S1 - A0 ; S1 MOD 10
    STR T0 $HEX1

    ; HEX2
    OR S1 S2 RZ
    OR A0 S1 RZ
    JAL #divide_by_10: ; V0 = A0 / 10
    OR S2 V0 RZ ; S2 = V0
    OR A0 V0 RZ ; A0 = V0
    JAL #mult_by_10: ; V0 = A0 * 10
    SUB T0 S1 V0 ; T0 = S1 - A0 ; S1 MOD 10
    STR T0 $HEX2

    ; HEX3
    OR S1 S2 RZ
    OR A0 S1 RZ
    JAL #divide_by_10: ; V0 = A0 / 10
    OR S2 V0 RZ ; S2 = V0
    OR A0 V0 RZ ; A0 = V0
    JAL #mult_by_10: ; V0 = A0 * 10
    SUB T0 S1 V0 ; T0 = S1 - A0 ; S1 MOD 10
    STR T0 $HEX3

    JMP #loop


; ; Check if the switches have changed
;     LDR T0 $SWITCHES
; ; if it has send config messages based on switches
;     BEQ S0 T0 #send_config_end 
;     ADD S0 T0 RZ ; Update the last value of swithc
; ; SW0 & SW1 => 0b00 8bit, 0b01 10bit, 0b10 12bit, 0b11 OFF
;     AND T0 S0 #0b11
    
; adc_config_case:
;     LDR T1 #0b01 
;     LDR T2 #0b10
;     LDR T0 #0b1001001000000001
;     BEQ S0 RZ #adc_confic_case_0
;     BEQ S0 T1 #adc_confic_case_1
;     BEQ S0 T2 #adc_confic_case_2
;     JMP #adc_config_case_end ; If both switches are on do nothing
    
; adc_confic_case_0: ; Data width 8
;     LDR T1 #8
;     DCALL T0 T1
;     JMP #adc_config_case_end
; adc_confic_case_1: ; Data width 10
;     LDR T1 #10
;     DCALL T0 T1
;     JMP #adc_config_case_end
; adc_confic_case_2: ; Data width 12
;     LDR T1 #12
;     DCALL T0 T1
;     JMP #adc_config_case_end

; adc_config_case_end:

; avg_on_off:
;     LDR T0 #0b1001001000001000
;     SLL T1 S0 #2
;     AND T1 T1 #0b1
;     BEQ T1 RZ #avg_off
; avg_on:
;     LDR T1 #3
;     SLL T1 T1 #4
;     OR T0 T0 T1
;     DCALL T0 RZ
;     JMP #avg_on_off_end
; avg_off:
;     LDR T1 #4
;     SLL T1 T1 #4
;     OR T0 T0 T1
;     DCALL T0 RZ
; avg_on_off_end:

; send_config_end:

; ; Display LEDS
;     STR S0 $LEDR

; read_noc_loop:
;     LDR T0 $FROM_NOC_U  
; ; Check if there are any incoming messages
;     BEQ T0 RZ #loop
; ; If there are messages read them all
;     LDR S1 $FROM_NOC_L
;     POP
; ; Display latest frequency value on the 7-segment display

;     ; HEX0
;     OR A0 S1 RZ
;     JAL divide_by_10: ; V0 = A0 / 10
;     OR S2 V0 RZ ; S2 = V0
;     OR A0 V0 RZ ; A0 = V0
;     JAL #mult_by_10: ; V0 = A0 * 10
;     SUB T0 S1 A0 ; T0 = S1 - A0 ; S1 MOD 10
;     STR T0 $HEX0

;     ; HEX1
;     OR S1 S2 RZ
;     OR A0 S1 RZ
;     JAL divide_by_10: ; V0 = A0 / 10
;     OR S2 V0 RZ ; S2 = V0
;     OR A0 V0 RZ ; A0 = V0
;     JAL #mult_by_10: ; V0 = A0 * 10
;     SUB T0 S1 A0 ; T0 = S1 - A0 ; S1 MOD 10
;     STR T0 $HEX1

;     ; HEX2
;     OR S1 S2 RZ
;     OR A0 S1 RZ
;     JAL #divide_by_10: ; V0 = A0 / 10
;     OR S2 V0 RZ ; S2 = V0
;     OR A0 V0 RZ ; A0 = V0
;     JAL #mult_by_10: ; V0 = A0 * 10
;     SUB T0 S1 A0 ; T0 = S1 - A0 ; S1 MOD 10
;     STR T0 $HEX2

;     ; HEX3
;     OR S1 S2 RZ
;     OR A0 S1 RZ
;     JAL #divide_by_10: ; V0 = A0 / 10
;     OR S2 V0 RZ ; S2 = V0
;     OR A0 V0 RZ ; A0 = V0
;     JAL #mult_by_10: ; V0 = A0 * 10
;     SUB T0 S1 A0 ; T0 = S1 - A0 ; S1 MOD 10
;     STR T0 $HEX3

;     JMP #read_noc_loop
; ; Read


mult_by_10: ; V0 = A0 * 10
    SUB SP SP #2 ; Store on stack
    STR S0 SP ; USE S0 to show stack works
    SUB SP SP #2 ; Store on stack
    STR S1 SP ; USE S0 to show stack works

    SLL V0 A0 #3 ; V0 = A0 * 8
    ADD V0 V0 A0 ; V0 = V0 + A0
    ADD V0 V0 A0 ; V0 = V0 + A0
    ; V0 = 10 * A0

    LDR S1 SP ; Load Stored on stack
    ADD SP SP #2
    LDR S0 SP ; Load Stored on stack
    ADD SP SP #2
    JMP RA

divide_by_10: ; V0 = A0 / 10
    SUB SP SP #2 ; Store on stack
    STR S0 SP ; USE S0 to show stack works
    SUB SP SP #2 ; Store on stack
    STR S1 SP ; USE S0 to show stack works

    SLL T0 A0 #1 ; T0 = A0 * 2
    SLL T1 A0 #3 ; T1 = T0 * 8
    SLL T2 A0 #4 ; T2 = T0 * 16
    SRL T3 A0 #1 ; T3 = T3 / 2
    ADD T0 T0 A0 ; T0 = T0 + A0
    ADD T1 T1 T2 ; T1 = T1 + T2
    ADD T0 T0 T1 ; T0 = T0 + T1
    SUB T0 T0 T3 ; T0 = T0 + T3
    ; T0 = 25.5 * A0
    SRL V0 T0 #8 ; V0 = T0 / 256
    ; V0 = (25.5 / 256) * A0

    LDR S1 SP ; Load Stored on stack
    ADD SP SP #2
    LDR S0 SP ; Load Stored on stack
    ADD SP SP #2
    JMP RA