;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 16 bit math functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
div16:
	lda #0	        ;preset remainder to 0
	sta remainder
	sta remainder+1
	ldx #16	        ;repeat for each bit: ...

divloop:
	asl dividend	;dividend lb & hb*2, msb -> Carry
	rol dividend+1	
	rol remainder	;remainder lb & hb * 2 + msb from carry
	rol remainder+1
	lda remainder
	sec
	sbc divisor	;substract divisor to see if it fits in
	tay	        ;lb result -> Y, for we may need it later
	lda remainder+1
	sbc divisor+1
	bcc skip	;if carry=0 then divisor didn't fit in yet

	sta remainder+1	;else save substraction result as new remainder,
	sty remainder	
	inc result	;and INCrement result cause divisor fit in 1 times

skip:
	dex
	bne divloop	
	rts

;;result stored in A=hi, X=lo
mul16:
	lda #$00
	ldx #$08
	clc
-	bcc +
	clc
	adc num2
+	ror
	ror num1
	dex
	bpl -
	ldx num1
	rts

; 16-bit addition and subtraction by FMan/Tropyx
sub16:
	sec						; set carry for borrow purpose
	lda 	num1+0
	sbc 	num2+0			; perform subtraction on the LSBs
	sta 	res+0
	lda 	num1+1			; do the same for the MSBs, with carry
	sbc 	num2+1			; set according to the previous result
	sta 	res+1
	rts

add16:
	clc				; clear carry
	lda num1+0
	adc num2+0
	sta res+0			; store sum of LSBs
	lda num1+1
	adc num2+1			; add the MSBs using carry from
	sta res+1			; the previous calculation
	rts
