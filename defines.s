;;nes registers
.define PPUCTRL			$2000
.define PPUMASK			$2001
.define PPUSTATUS		$2002
.define OAMADDR			$2003
.define OAMDATA			$2004
.define PPUSCROLL		$2005
.define PPUADDR			$2006
.define PPUDATA			$2007

;;fds bios routines
.define LOADFILES		$E1F8
.define APPENDFILE		$E237
.define WRITEFILE		$E239
.define GETDISKINFO		$E32A
.define SETFILECOUNT	$E305
.define WRITEBLOCKTYPE	$E6B0
.define XFERBYTE		$E7A3
.define ENDBLOCKWRITE	$E729
.define STARTXFER		$E6E3

;;data
.define DISKLIST		$7000
.define SPRITES			$6000

;;current disk selected
.define sleeping			$90
.define curline				$91
.define maxline				$92
.define curpage				$93
.define pagecount			$94
.define curdisk				$95		;;16 bits

.define ok_button			$B0
.define cancel_button		$B1
.define PADDATA 			$B8
.define PADDATA2 			$B9
.define joycount 			$BA

;;16bit number "diskcount" is stored here
.define diskcount			$7000

.define listaddr			$A0
.define ntaddr				$A2
.define diskblock			$A4

.define num1				$C0
.define num2				$C2
.define res 				$C4

.define divisor				$C8
.define dividend			$CA
.define remainder			$CC
.define result				dividend


;;save registers to stack
.macro pushregs
	pha
	tya
	pha
	txa
	pha
.endm

;;restore registers from stack
.macro popregs
	pla
	tax
	pla
	tay
	pla
.endm

.macro ldsta
	lda	#\1
	sta	\2
.endm

.macro ldsty
	ldy	#\1
	sty.w	\2
.endm
