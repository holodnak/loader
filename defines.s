;;nes registers
.define PPUCTRL			$2000
.define PPUMASK			$2001
.define PPUSTATUS			$2002
.define OAMADDR			$2003
.define OAMDATA			$2004
.define PPUSCROLL			$2005
.define PPUADDR			$2006
.define PPUDATA			$2007

;;data
.define RAM					$0400
.define DISKLIST			$8000
.define SPRITES			$6000

;;fds bios routines
.define LOADFILES			$E1F8
.define APPENDFILE		$E237
.define WRITEFILE			$E239
.define GETDISKINFO		$E32A
.define SETFILECOUNT		$E305

;;joypad data
.define PADDATA			RAM+0
.define PADDATA2			RAM+1

;;current disk selected
.define sleeping			$90
.define curline				$91
.define maxline				$92
.define curdisk				$93
.define curpage				$94
.define diskcount			$95
.define pagecount			$96

.define listaddr			$A0
.define ntaddr				$A2

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
