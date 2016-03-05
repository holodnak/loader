.MEMORYMAP
	SLOTSIZE $800
	DEFAULTSLOT 0
	SLOT 0 $6000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE $800
	BANKS 1
.ENDRO

.include "defines.s"

;;this slot is just for init code
.BANK 0 SLOT 0

;;sprite data
.ORG $0000
sprites:
	.db	$FF,$19,$83,$10
.repeat 63
	.db	$FF,$FF,$FF,$FF
.endr

;;irq vector
.ORG $0100
irq:
	rti

;;nmi vector
.ORG $0101
nmi:
	pha
	lda	#0
	sta	sleeping
	pla
	rti

;;reset vector
.ORG $0110
reset:

main:

	;;setup stack
	ldx	#$FF
	txs

	;;perform initialization of the nes
	ldsty	$40,$4017		;;disable frame irq
	ldsty	$0F,$4015		;;setup volume

	;;init reset action
	lda		#$C0
	sta		$0101
	sta		$0100

	lda		#0
	sta		PPUCTRL			;;disable nmi
	sta		PPUMASK			;;disable rendering
	sta		$4010			;;disable dmc irq

	;;init local variables
	sta		curline
	sta		curpage
	sta		curdisk+0
	sta		curdisk+1

	;;initialize pad data
	sta		PADDATA
	sta		PADDATA2

	;;copy palette
	jsr		copypalette

	;;calculate number of pages
	jsr 	calcnumpages

	;;setup arrow sprite, perform sprite dma, then draw first page of disk list
	jsr 	movearrow
	jsr		spritedma
	jsr		movepage

	;;enable nmi interrupts
	lda 	#$80
	sta 	PPUCTRL

	jsr 	checkstatus

loop:

	inc		sleeping
-	lda		sleeping
	bne	-

	;;reset scroll
	lda 	#0
	sta 	PPUSCROLL
	sta 	PPUSCROLL

	;;enable rendering
	lda 	#$18
	sta 	PPUMASK

	jsr		spritedma
	jsr		readinput
	jsr		parseinput

	jmp		loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

clearpage:
	ldsty	$00,PPUMASK		;;disable bg/sprites

	ldy	PPUSTATUS			;;reset the toggle
	ldsty	$20,PPUADDR		;;setup destination ppu address
	ldsty	$A2,PPUADDR

	lda 	#23
	sta 	$54

--	lda 	#$10
	ldx		#28

	;;clear line of the box
-	sta 	PPUDATA
	iny
	dex
	bne 	-

	;;move to beginning of next column used for box
	ldx 	#4
-	lda 	PPUDATA
	dex
	bne 	-

	;;decrement loop counter
+	dec 	$54
	bne 	--

	rts

;;draw page of games, variable curpage holds current page number
drawpage:

	;;first, clear the old tiles in the nametable
	jsr clearpage

	;;calculate starting line of this page (multiply page number by 23)
	lda #0
	sta num1+1
	sta num2+1
	lda curpage
	sta num1
	lda #23
	sta num2
	jsr mul16

	sta num1+1
	stx num1+0
	lda #40
	sta num2+0
	lda #0
	sta num2+1
	jsr	mul16

	sta num1+1
	stx num1+0
	lda #$70
	sta num2+1
	lda #0
	sta num2+0
	jsr add16

	lda res+0
	sta listaddr+0
	lda res+1
	sta listaddr+1

	;;first entry in disklist is just the number of disks, bump up by one page
	jsr inclistaddr

	;;setup ppu address
	ldy	PPUSTATUS			;;reset the toggle
	ldsty	$20,PPUADDR			;;high byte of destination address
	ldsty	$A3,PPUADDR			;;low byte of destination address

	;;reset temp disk count on screen variable
	lda #0
	sta $62

	lda maxline
	sta $61
	inc $61

	;;load total number of games and save to temp mem byte
	lda	#23
	sta $60

	;;now start assembling the list, number of disks in list is stored in a

	;;if we are on done, rts
	cmp #0
	beq copydone

	;;copy string to nametable
copy:
	jsr	copystring

	;;increment game list pointer
	jsr	inclistaddr

	inc $62
	lda $62
	cmp $61
	beq copydone

	;;decrement the counter
	dec $60

	bne copy

copydone:
	rts

inclistaddr:
	clc
	lda listaddr+0
	adc #40
	sta listaddr+0
	bcc +
	inc listaddr+1
+	rts

;;copy sprites
spritedma:
	lda	#0					;;sprite data address
	sta	OAMADDR
	lda	#$60				;;page to dma from
	sta	$4014				;;execute sprite dma
	rts

;;copy initial palette
copypalette:
	ldsty	$3F,PPUADDR		;;setup destination ppu address
	ldsty	$00,PPUADDR
	ldx	#32				;;number of bytes to copy from the palette
-	lda	palette,y		;;load byte to copy to ppu
	sta	PPUDATA			;;write byte to ppu
	iny						;;increment source address
	dex						;;decrement counter
	bne	-					;;repeat until all copied
	rts

;;palettes
palette:
	.incbin "bg.pal" read 16
	.incbin "bg.pal" read 16

;;wait for vblank, missing it sometimes
ppuwait:
	bit PPUSTATUS
	bpl ppuwait
	rts

;;copy string from ($80) to ppu memory
copystring:
	ldx	#28
	ldy	#12
-	lda	(listaddr),y
	dex
	iny
	cmp	#0
	beq	+
	sta	PPUDATA
	bne	-
+	lda	#32
-	sta	PPUDATA
	dex
	cpx	#0
	bne	-
	lda	PPUDATA
	lda	PPUDATA
	lda	PPUDATA
	lda	PPUDATA
	lda	PPUDATA
	rts

startdisk:
	;;setup pointer to disk list data
	ldsty	>(DISKLIST+0),listaddr+1	;;high byte of source address
	ldsty	<(DISKLIST+40),listaddr+0	;;low byte of source address

	;;increment the address pointer enough to get to the selected disk
decloop:
	lda 	curdisk+0
	bne 	+
	lda 	curdisk+1
	beq 	done
	dec 	curdisk+1
+	dec 	curdisk+0
	jsr		inclistaddr
	jmp 	decloop
done:

	;;load the disk index and begin to boot the game
+	ldy	#0

	jsr writefilename

reboot:
	;;tell bios to reboot
	lda	#0
	sta	$102
	jmp	($FFFC)

writefilename:
	lda $0101				;;save irq handler action
	pha

	lda #2					;;error retry count
	sta $05

	jsr STARTXFER
	lda #$DB 				;;block "type"
	jsr WRITEBLOCKTYPE

	;;setup to copy 12 byte filename
	ldy #0
	lda #12
	sta $80

	;;filename write loop
-	lda (listaddr),y
	jsr XFERBYTE			;;write it out
	iny
	dec $80
	bne -

	jsr ENDBLOCKWRITE

	pla 					;;restore irq handler action
	sta $0101
	RTS

;;check status area of disklist for firmware update display

.define decOnes				$47
.define decTens				$46
.define decHundreds			$45
.define decThousands		$44
.define decTenThousands		$43

hextodecbuild:
	lda 	$7027
	ldx 	$7026
	jsr 	HexToDec65535
	sta.w 	decTens
	sty.w 	decHundreds

	;;initialize loop to copy 5 bytes
	ldx 	#0
-	lda 	$43,x

	;;check if this digit is leading zero, if so write a space instead
	cmp 	#$30
	bne 	+
	lda 	#$20
	sta 	$43,x

	;;go to next character and increment loop counter
	inx
	cpx 	#5
	bne 	-
+	rts

checkstatus:
	lda 	#$24
	sta 	$58
	lda 	#$70
	sta 	$59
	ldy 	#0

	lda 	($58),y
	cmp 	#$DB
	bne 	+

	iny
	lda 	($58),y
	cmp 	#$DC
	bne 	+

	;;display box
	jmp 	statusbox

+	rts

buildbox:
	jsr 	hextodecbuild

	;;initialize loop to copy 5 bytes
	ldx 	#0
	stx 	ok_button
	stx 	cancel_button
-	lda 	$43,x
	sta.w 	box_build_blank,x
	inx
	cpx 	#5
	bne -

	ldsty	>(box_build),$53	;;high byte of source address
	ldsty	<(box_build),$52	;;low byte of source address

	jmp 	finishbox

statusbox:
	jsr 	hextodecbuild

	;;initialize loop to copy 5 bytes
	ldx 	#0
	stx 	ok_button
	stx 	cancel_button
-	lda 	$43,x
	sta.w 	box_status_blank,x
	inx
	cpx 	#5
	bne -

	ldsty	>(box_status),$53	;;high byte of source address
	ldsty	<(box_status),$52	;;low byte of source address

finishbox:

	jsr 	drawbox
	jsr 	copyboxstring

boxloop2:
	inc	sleeping
-	lda	sleeping
	bne	-
 
	jsr	spritedma
	jsr	readinput
	jsr parseboxinput

	lda ok_button
	cmp #1
	beq +

	lda cancel_button
	cmp #1
	beq +

	ldsty	$00,PPUSCROLL	;;reset scroll to 0,0
	ldsty	$00,PPUSCROLL
	ldsty	$18,PPUMASK		;;enable bg/sprites

	jmp	boxloop2

+	ldsty	$00,PPUMASK		;;disable bg/sprites
	jsr		drawpage
	rts

updatefirmware:
	lda #0
	sta ok_button
	sta cancel_button
	jsr drawbox

	ldsty	>(box_updatefirmware),$53	;;high byte of source address
	ldsty	<(box_updatefirmware),$52	;;low byte of source address

	jsr copyboxstring

boxloop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	inc	sleeping
-	lda	sleeping
	bne	-
 
	jsr	spritedma
	jsr	readinput
	jsr parseboxinput

	lda ok_button
	cmp #1
	beq do_update_firmware

	lda cancel_button
	cmp #1
	beq +

	ldsty	$00,PPUSCROLL	;;reset scroll to 0,0
	ldsty	$00,PPUSCROLL
	ldsty	$18,PPUMASK		;;enable bg/sprites

	jmp	boxloop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+	ldsty	$00,PPUMASK		;;disable bg/sprites

	jsr		drawpage

	rts

do_update_firmware:

	lda $0101				;;save irq handler action
	pha

	lda #2					;;error retry count
	sta $05

	jsr STARTXFER
	lda #$DC 				;;block "type"
	jsr WRITEBLOCKTYPE

	;;setup to copy 12 byte filename
	lda #12
	sta $80

	;;filename write loop
-	lda #0
	jsr XFERBYTE			;;write it out
	dec $80
	bne -

	jsr ENDBLOCKWRITE

	pla 					;;restore irq handler action
	sta $0101
	jmp reboot
	rts

drawbox:

	ldsty	$00,PPUMASK		;;disable bg/sprites

	ldy	PPUSTATUS			;;reset the toggle
	ldsty	$21,PPUADDR		;;setup destination ppu address
	ldsty	$04,PPUADDR

	ldsty	>(box_top),$51	;;high byte of source address
	ldsty	<(box_top),$50	;;low byte of source address
	jsr 	copyboxline

	lda 	#5
	sta 	$54

-	ldsty	>(box_line),$51	;;high byte of source address
	ldsty	<(box_line),$50	;;low byte of source address
	jsr 	copyboxline

	dec 	$54
	bne 	-

	ldsty	>(box_bottom),$51	;;high byte of source address
	ldsty	<(box_bottom),$50	;;low byte of source address
	jsr 	copyboxline

	rts

;;copy entire box line and position the vramaddr to start of next line
;;address of box data is stored at $50 (16bit ptr)
copyboxline:
	ldy 	#0
	ldx		#24

	;;copy part of the box
-	lda 	($50),y
	sta 	PPUDATA
	iny
	dex
	bne 	-

	;;move to beginning of next column used for box
	ldx 	#8
-	lda 	PPUDATA
	dex
	bne 	-

	rts

copyboxstring:

	;;setup destination ppu address
	ldsty	$21,PPUADDR
	ldsty	$25,PPUADDR

	;;starting offset in string data
	ldy	#0

	;;number of charactrers in a line
	ldx	#23

	;;copy string until chars is reached or a 0 is encountered
-	lda	($52),y

copymore:
	dex
	iny
	cmp	#0
	beq	+
	sta	PPUDATA
	bne	-

	;;fill remaining with space character
+	lda	#32
-	sta	PPUDATA
	dex
	cpx	#0
	bne	-

	;;go to next line
	ldx 	#10
-	lda 	PPUDATA
	dex
	bne 	-

	lda 	($52),y
	cmp 	#$FF
	beq 	+
	ldx		#23
	jmp 	copymore

+	rts

;; 168 bytes
box_top:
	.db $11,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$12
box_line:
	.db $13,$10,$10,$10, $10,$10,$10,$10, $10,$10,$10,$10, $10,$10,$10,$10, $10,$10,$10,$10, $10,$10,$10,$13
box_bottom:
	.db $15,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$14, $14,$14,$14,$16

box_updatefirmware:
	.db "Update firmware?",0
	.db 0
	.db 0
	.db "A: Continue",0
	.db "B: Cancel",0
	.db $ff

box_status:
	.db "Firmware is now at",0
	.db "build number: "
box_status_blank:
	.db 0,0,0,0,0,0
	.db 0
	.db 0
	.db "A: Continue",0
	.db $ff

box_build:
	.db "Firmware build: "
box_build_blank:
	.db 0,0,0,0,0,0
	.db 0
	.db 0
	.db 0
	.db "A: Continue",0
	.db $ff

diskid:
	.db	$FF,$FF,$FF,$FF,$FF,$FF,0,0,0,0

;;identification string followed by version
ident:
	.db	"]|LOADER.FDS|[",0
	.db	030

;;calculate number of pages
calcnumpages:
	;;divide number of disks in the list by the number of disks per page
	lda 	DISKLIST
	sta 	dividend
	lda 	DISKLIST+1
	sta 	dividend+1

	;;disks per page
	lda 	#23
	sta 	divisor
	lda 	#0
	sta 	divisor+1

	;;perform division, result is stored in dividend
	jsr 	div16
	lda 	dividend
	sta 	pagecount
	rts

;Hex to Decimal (0-65535) conversion
;by Omegamatrix
;
;HexToDec99     ; 37 cycles
;HexToDec255    ; 52-57 cycles
;HexToDec999    ; 72-77 cycles
;HexToDec65535  ; 178-186 cycles

;temp         = decOnes
;hexHigh      = temp2
;hexLow       = temp3

.equ ASCII_OFFSET $30

.define temp 		$40
.define hexLow 		$41
.define hexHigh		$42

Mod100Tab:
    .db 0,56,12,68 ;56+12

ShiftedBcdTab:
    .db $00,$01,$02,$03,$04,$08,$09,$0A,$0B,$0C
    .db $10,$11,$12,$13,$14,$18,$19,$1A,$1B,$1C
    .db $20,$21,$22,$23,$24,$28,$29,$2A,$2B,$2C
    .db $30,$31,$32,$33,$34,$38,$39,$3A,$3B,$3C
    .db $40,$41,$42,$43,$44,$48,$49,$4A,$4B,$4C

HexToDec65535:; SUBROUTINE
    sta    hexHigh               ;3  @9
    stx    hexLow                ;3  @12
    tax                          ;2  @14
    lsr                          ;2  @16
    lsr                          ;2  @18   integer divide 1024 (result 0-63)

    cpx    #$A7                  ;2  @20   account for overflow of multiplying 24 from 43,000 ($A7F8) onward,
    adc    #1                    ;2  @22   we can just round it to $A700, and the divide by 1024 is fine...

    ;at this point we have a number 1-65 that we have to times by 24,
    ;add to original sum, and Mod 1024 to get a remainder 0-999


    sta    temp                  ;3  @25
    asl                          ;2  @27
    adc    temp                  ;3  @30  x3
    tay                          ;2  @32
    lsr                          ;2  @34
    lsr                          ;2  @36
    lsr                          ;2  @38
    lsr                          ;2  @40
    lsr                          ;2  @42
    tax                          ;2  @44
    tya                          ;2  @46
    asl                          ;2  @48
    asl                          ;2  @50
    asl                          ;2  @52
    clc                          ;2  @54
    adc    hexLow                ;3  @57
    sta    hexLow                ;3  @60
    txa                          ;2  @62
    adc    hexHigh               ;3  @65
    sta    hexHigh               ;3  @68
    ror                          ;2  @70
    lsr                          ;2  @72
    tay                          ;2  @74    integer divide 1,000 (result 0-65)

    lsr                          ;2  @76    split the 1,000 and 10,000 digit
    tax                          ;2  @78
    lda.w    ShiftedBcdTab,X       ;4  @82
    tax                          ;2  @84
    rol                          ;2  @86
    and    #$0F                  ;2  @88
ora    #ASCII_OFFSET
    sta    decThousands          ;3  @91
    txa                          ;2  @93
    lsr                          ;2  @95
    lsr                          ;2  @97
    lsr                          ;2  @99
ora    #ASCII_OFFSET
    sta    decTenThousands       ;3  @102

    lda    hexLow                ;3  @105
    cpy    temp                  ;3  @108
    bmi    doSubtract           ;2³ @110/111
    beq    useZero               ;2³ @112/113
    adc    #23 + 24              ;2  @114
doSubtract:
    sbc    #23                   ;2  @116
    sta    hexLow                ;3  @119
useZero:
    lda    hexHigh               ;3  @122
    sbc    #0                    ;2  @124

Start100s:
    and    #$03                  ;2  @126
    tax                          ;2  @128   0,1,2,3
    cmp    #2                    ;2  @130
    rol                          ;2  @132   0,2,5,7
ora    #ASCII_OFFSET
    tay                          ;2  @134   Y = Hundreds digit

    lda    hexLow                ;3  @137
    adc.w    Mod100Tab,X           ;4  @141    adding remainder of 256, 512, and 256+512 (all mod 100)
    bcs    doSub200             ;2³ @143/144

try200:
    cmp    #200                  ;2  @145
    bcc    try100               ;2³ @147/148
doSub200:
    iny                          ;2  @149
    iny                          ;2  @151
    sbc    #200                  ;2  @153
try100:
    cmp    #100                  ;2  @155
    bcc    HexToDec99            ;2³ @157/158
    iny                          ;2  @159
    sbc    #100                  ;2  @161

HexToDec99:; SUBROUTINE
    lsr                          ;2  @163
    tax                          ;2  @165
    lda.w    ShiftedBcdTab,X       ;4  @169
    tax                          ;2  @171
    rol                          ;2  @173
    and    #$0F                  ;2  @175
ora    #ASCII_OFFSET
    sta    decOnes               ;3  @178
    txa                          ;2  @180
    lsr                          ;2  @182
    lsr                          ;2  @184
    lsr                          ;2  @186
ora    #ASCII_OFFSET
    rts                          ;6  @192   A = tens digit

HexToDec255:; SUBROUTINE
    ldy    #0                    ;2  @8
    beq    try200               ;3  @11    always branch

HexToDec999:; SUBROUTINE
    stx    hexLow                ;3  @9
    jmp    Start100s             ;3  @12

.include "menu-draw.s"
.include "menu-input.s"
.include "math.s"

