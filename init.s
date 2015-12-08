;;system setup for getting around kyodoku

.MEMORYMAP
	SLOTSIZE $0100
	DEFAULTSLOT 0
	SLOT 0 $0600

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE $0100
	BANKS 1
.ENDRO

.ORG $0000

.include "defines.s"

reset:
	;;disable interrupts and disable decimal mode
	sei
	cld

	;;init ppu variables and registers
	lda #$10
	sta $FF
	sta $2000                      ;PPU Control register 1
	lda #$06
	sta $FE
	sta $2001                      ;PPU Control register 2
	ldx #$FF

	;;initialize fds bios interrupt actions
	lda #$AC
	sta $0103
	lda #$35
	sta $0102
	lda #$80
	sta $0101
	lda #$C0
	sta $0100

	;;finish initing ppu vars/regs
	lda #$00
	sta $FD
	sta $FC
	sta $2005                      ;Screen scroll offset
	sta $2005                      ;Screen scroll offset
	sta $FB
	sta $4016                      ;Joystick 1 + strobe
	lda #$2F
	sta $FA
	sta $4025
	lda #$FF
	sta $F9
	sta $4026

	;;sound init?
	lda #$00
	sta $4010
	lda #$0F
	sta $4015                      ;Sound control
	lda #$C0
	sta $4017                      ;Joystick 2 + strobe
	lda #$80
	sta $4080
	lda #$E8
	sta $408A
	lda #$00
	sta $4022
	lda #$83
	sta $4023

	;;load boot files
	jsr	LOADFILES
	.dw	diskid
	.dw	loadlist
	jmp	($DFFC)

diskid:
	.db	$FF,$FF,$FF,$FF,$FF,$FF,0,0,0,0
loadlist:
	.db	$10,$FF

