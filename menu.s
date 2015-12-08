.MEMORYMAP
	SLOTSIZE $1000
	DEFAULTSLOT 0
	SLOT 0 $6000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE $1000
	BANKS 1
.ENDRO

.include "defines.s"

;;this slot is just for init code
.BANK 0 SLOT 0

;;sprite data
.ORG $0000
sprites:
.repeat 64
	.db	$FF,$FF,$FF,$FF
.endr

;;irq vector
.ORG $0100
irq:
	rti

;;nmi vector
.ORG $0200
nmi:
	pha
;	pushregs					;;save registers

	lda	#0
	sta	sleeping
	
;	popregs
	pla
	rti

;;reset vector
.ORG $0400
reset:

	;;continue booting with kyodoku bypass
	sei
	ldx	#$FF
	txs
	lda	#$10
	sta	$2000
	lda	#$06
	sta	$2001
	lda	$FA
	ora	#$08
	sta	$4025
	sta	$FA
	lda	$0102
	ldx	$0103
	cmp	#$35
	bne	main
	cpx	#$53
	bne	main
	lda	#$00
	sta	$0102
	jmp	($FFFC)

main:

	ldx	#$FF
	txs					;;setup stack
	inx
	txa
-	sta	$000,x			;;clear ram
	sta	$100,x
	sta	$200,x
	sta	$300,x
	sta	$400,x
	sta	$500,x
	sta	$600,x
	sta	$700,x
	inx
	bne	-
	
	;;perform initialization of the nes
	ldsty	$40,$4017		;;disable frame irq
	ldsty	$0F,$4015		;;setup volume
	ldx	#0
	stx.w	PPUCTRL			;;disable nmi
	stx.w	PPUMASK			;;disable rendering
	stx.w	$4010				;;disable dmc irq
	lda	#0
	sta	PPUCTRL
	sta	PPUMASK

	lda	#$C0
	sta	$0101
	sta	$0100
	ldx	#2

	;;init local variables
	lda	#0
	sta	curline
	sta	curdisk
	sta	curpage
	sta pagecount
	lda	DISKLIST
	cmp	#0
	beq	+
	sta	diskcount
	dec	diskcount
+

	;;calculate number of pages (pagecount is number of pages + 1)
	lda diskcount
-	inc pagecount
	sec
	sbc #23
	bpl -
	dec pagecount

	;;initialize pad data
	lda	#$00
	sta	PADDATA
	sta	PADDATA2

	;;copy palette
	jsr	copypalette
	
	;;setup arrow sprite
	lda	#$19
	sta	SPRITES+1
	lda	#$83
	sta	SPRITES+2
	lda	#16
	sta	SPRITES+3
	jsr movearrow
	
	;;init sprites
	jsr	spritedma

	;;draw initial page of games
	jsr	drawpage

	ldsty	$18,PPUMASK		;;enable bg/sprites

	lda	#%10000000   ; enable NMI interrupts now that the PPU is ready
	sta	PPUCTRL

	jmp	loop

loop:

	inc	sleeping
-	lda	sleeping
	bne	-
 
	jsr	spritedma

	jsr	readinput

	ldsty	$00,PPUSCROLL	;;reset scroll to 0,0
	ldsty	$00,PPUSCROLL
 
	jmp	loop

multable:
	.db	0, 23, 46, 69, 92, 115, 138, 161, 184, 207, 230, 253

.org $0600
;;draw page of games, variable curpage holds current page number
drawpage:

	;;first, clear the old tiles in the nametable
;	jsr clearpage

	;;calculate number of lines on this page
	lda curpage

	;;perform table multiply of page number -> starting game index
	tax
	lda	multable.w, x

	;;save result to temp mem
	sta $60

	;;load number of disks total in the list
	lda DISKLIST

	;;subtract to find number of games on screen
	sec
	sbc $60

	;;if result is 23 or greater, then display max lines, else display the result number of lines
	cmp #23
	bmi +
	lda #23
+	sta maxline
	dec maxline
	
	;;get starting entry index and store it in listaddr var

	;;current page*23 is stored in $60
	lda $60
	sta listaddr+0
	lda #0
	sta listaddr+1

	;;multiply by 32
	ldx #5
-	asl listaddr+0
	rol listaddr+1
	dex
	bne -

	;;add starting offset of $8000
	lda listaddr+1
	clc
	adc #$80
	sta listaddr+1

	;;first entry in disklist is just the number of disks, bump up by one page
	jsr inclistaddr

	;;setup ppu address
	ldy	PPUSTATUS			;;reset the toggle
	ldsty	$20,PPUADDR			;;high byte of destination address
	ldsty	$A3,PPUADDR			;;low byte of destination address

	;;setup pointer to first game in list
;	ldsty	>(DISKLIST+32),$A1	;;high byte of source address
;	ldsty	<(DISKLIST+32),$A0	;;low byte of source address

;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;

	;;reset temp disk count on screen variable
	lda #0
	sta $62

	;;load total number of games and save to temp mem byte
	lda	DISKLIST
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
	cmp #23
	beq copydone

	;;decrement the counter
	dec $60

	bne copy

copydone:
	rts

;;;;;;;;;;;;working;;;;;;;;;;;;;;;
	;;if total number of games is 0, bail
	cmp	#0
	bne	+
	rts

	;;save game count in temp var
+	sta	$60

	;;keep copying disk names until there is no more
-	jsr	copystring
	jsr	inclistaddr
	dec	$60
	bne	-

	rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;setup number of games listed per page
	lda	$8000					;;load total number of games
	cmp	#23
	bcc	+						;;branch if total number of games is less than 23
;;games is greater than 23
	lda	#23
;;games less than 23 (draw partial page)
+	sta	$60

	;;keep copying
-	jsr	copystring
	dec	$60
	bne	-

end:
	rts

inclistaddr:
	clc
	lda listaddr+0
	adc #32
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
	ldy	#1
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

;;read input and deal with button presses
readinput:
	ldsty	1,$4016			;;strobe controllers
	ldsty	0,$4016
	lda	#0
	sta	PADDATA
	ldx	#8
-	lda	$4016
	lsr	a
	rol	PADDATA
	dex
	bne	-

	lda	PADDATA
	tay
	eor	PADDATA2
	and	PADDATA
	sta	PADDATA
	sty.w	PADDATA2

	lda	PADDATA			;;load controller data
	and	#$04				;;mask off down
	beq	+					;;if 0, then branch
	jsr	nextdisk			;;go to next disk

+	lda	PADDATA			;;load controller data
	and	#$08				;;mask off up
	beq	+
	jsr	prevdisk			;;go to previous disk

+	lda	PADDATA			;;load controller data
	and	#$01				;;mask off right
	beq	+
	jsr	nextpage			;;go to next page

+	lda	PADDATA			;;load controller data
	and	#$02				;;mask off left
	beq	+
	jsr prevpage			;;go to previous page

+	lda	PADDATA			;;load controller data
	and	#$80				;;mask off a button
	beq	+
	jsr	startdisk		;;start game

	rts

;;move down in the list
nextdisk:
	lda	curline
	cmp maxline
	beq	+
	inc	curline
	jsr	movearrow
+	rts

;;go up in the list
prevdisk:
	lda	curline
	cmp	#0
	beq	+
	dec	curline
	jsr	movearrow
+	rts

nextpage:
	lda curpage
	cmp pagecount
	beq +
	inc curpage
	jsr movepage
+	rts

prevpage:
	lda curpage
	cmp #0
	beq +
	dec curpage
	jsr movepage
+	rts

;;move the disk selection cursor
movearrow:
	lda	curline
	asl
	asl
	asl
	clc
	adc	#39
	sta	SPRITES+0
	rts

;;change the page
movepage:

	;;reset line to 0
	lda #0
	sta curline

	;;calculate number of lines on this page
	lda curpage

	;;perform table multiply of page number -> starting game index
	tax
	lda	multable.w, x

	;;save result to temp mem
	sta $60

	;;load number of disks total in the list
	lda DISKLIST

	;;subtract to find number of games on screen
	sec
	sbc $60

	;;if result is 23 or greater, then display max lines, else display the result number of lines
	cmp #23
	bmi +
	lda #23
+	sta maxline
	dec maxline

	jsr movearrow

	ldsty	$00,PPUMASK		;;disable bg/sprites

	jsr drawpage

	ldsty	$18,PPUMASK		;;enable bg/sprites

	rts

startdisk:
	;;setup pointer to disk list data
	ldsty	>(DISKLIST),listaddr+1	;;high byte of source address
	ldsty	<(DISKLIST),listaddr+0	;;low byte of source address

	;;calculate the disk number
	lda curpage
	tax
	lda	multable.w, x
	clc
	adc curline
	sta curdisk

	;;increment the address pointer enough to get to the selected disk
-	jsr	inclistaddr
	dec	curdisk
	bpl	-

	;;load the disk index and begin to boot the game
+	ldy	#0
	lda	(listaddr),y
	jsr	SETFILECOUNT
	.dw	diskid

	;;tell bios to reboot
	lda	#0
	sta	$102
	jmp	($FFFC)

diskid:
	.db	$FF,$FF,$FF,$FF,$FF,$FF,0,0,0,0

;;identification string followed by version
ident:
	.db	"]|<=--LOADER.FDS--=>|[",0
	.db	010
