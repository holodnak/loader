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
	pushregs					;;save registers

	lda	PPUSTATUS
	lda	#%00000000		;;disable NMI
	sta	PPUCTRL

	ldsty	$00,PPUSCROLL	;;scroll x offset
	ldsty	$00,PPUSCROLL	;;scroll y offset

	jsr	readpads2		;;read controller buttons

	lda	PADDATA			;;load controller data
	and	#$04				;;mask off down
	beq	+					;;if 0, then branch
	jsr	nextdisk			;;go to next disk

+	lda	PADDATA			;;load controller data
	and	#$08				;;mask off up
	beq	+
	jsr	prevdisk			;;go to previous disk

+	lda	PADDATA			;;load controller data
	and	#$80				;;mask off a button
	beq	+
	jsr	startdisk		;;start game

+	popregs
	rti

nextdisk:
	inc	CURDISK
	rts

prevdisk:
	lda	CURDISK
	cmp	#0
	beq	+
	dec	CURDISK
+	rts

startdisk:

	lda	CURDISK
	jsr	SETFILECOUNT
	.dw	diskid

	;;tell bios to reboot
	lda	#0
	sta	$102
	jmp	($FFFC)

	;;prepare data to be written to disk
	lda	CURDISK
	sta	$A000
	lda	#0
	sta	$A001
	sta	$A002
	sta	$A003
	sta	$A004
	sta	$A005
	sta	$A006
	sta	$A007

	;;write file to end of disk
	lda	#9
	jsr	WRITEFILE
	.dw	diskid
	.dw	commence

	ldsty	$20,PPUADDR			;;high byte of destination address
	ldsty	$C1,PPUADDR			;;low byte of destination address
	sta	PPUDATA
	ldsty	$00,PPUSCROLL			;;high byte of destination address
	ldsty	$00,PPUSCROLL			;;high byte of destination address
	
	jsr	GETDISKINFO
	.dw	$B000

	lda	CURDISK
	jsr	SETFILECOUNT
	.dw	diskid

	;;tell bios to reboot
	lda	#0
	sta	$102
	jmp	($FFFC)

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

	;;clear ram
	ldx	#$FF
	txs						;;setup stack
	inx
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
	ldx	#$02

	;;init local variables
	lda	#1
	sta	CURDISK
	lda	$8000
	sta	DISKCOUNT

	;;copy palette
	jsr	copypalette

	;;copy sprite data
	lda	#0					;;sprite data address
	sta	OAMADDR
	lda	#$60				;;page to dma from
	sta	$4014				;;execute sprite dma

	;;load the disk information
;	jsr	LOADFILES
;	.dw	diskid
;	.dw	loadlist
	
	ldsty	$00,PPUSCROLL		;;reset scroll to 0,0
	ldsty	$00,PPUSCROLL

	ldy	PPUSTATUS			;;reset the toggle
	lda	#$20
	sta	PPUADDR
	lda	#$C3
	sta	PPUADDR
	ldsta	$20,PPUADDR			;;high byte of destination address
	ldsta	$C3,PPUADDR			;;low byte of destination address
	ldsta	>(DISKLIST+32),$81	;;high byte of source address
	ldsta	<(DISKLIST+32),$80	;;low byte of source address
	jsr	copystring

	ldsty	$00,PPUSCROLL	;;reset scroll to 0,0
	ldsty	$00,PPUSCROLL
	
	ldsty	$18,PPUMASK		;;enable bg/sprites

	ldsty	$00,PADDATA		;;initialize pad data
	ldsty	$00,PADDATA2

loop:

	lda	#%10000000				;;enable nmi
	sta	PPUCTRL

	jmp	loop

diskid:
	.db	$FF,$FF,$FF,$FF,$FF,$FF,0,0,0,0
loadlist:
	.db	$20,$FF
commence:
	.db	48
	.db	"COMMENCE"
	.dw	$A000
	.dw	8
	.db	0
	.dw	$A000
	.db	0

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

;;read controller buttons, stores them in PADDATA
readpads:
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
	rts

;;read controller buttons, store up->down changes in PADDATA
readpads2:
	jsr	readpads
	lda	PADDATA
	tay
	eor	PADDATA2
	and	PADDATA
	sta	PADDATA
	sty.w	PADDATA2
	rts

;;copy string from ($80) to ppu memory (helper for init)
copystring:
	ldx	#28
	ldy	#0
-	lda	($80),y
	dex
	iny
	cmp	#0
	beq	+
	sbc	#16
	sta	PPUDATA
	bne	-
+	lda	#16
-	sta	PPUDATA
	dex
	cpx	#0
	bne	-
	rts
