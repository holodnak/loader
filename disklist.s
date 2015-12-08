;;interrupt vectors for getting around kyodoku

.MEMORYMAP
	SLOTSIZE $1000
	DEFAULTSLOT 0
	SLOT 0 $0000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE $1000
	BANKS 1
.ENDRO

.ORG $0000

;;total number of "games"
	.db	24

;;number of slots

.ORG $0020
	.db	0,"loader.fds",0

.ORG $0040
	.db	1,"Zelda no Densetsu",0

.ORG $0060
	.db	3,"Metroid (Japan) (v1.2) [b]",0

.ORG $0080
	.db	5,"Super Mario Brothers 2",0

.ORG $00A0
	.db	8,"Zelda 5",0

.ORG $00C0
	.db	10,"Zelda 6",0

.ORG $00E0
	.db	10,"Zelda 7",0

.ORG $0100
	.db	10,"Zelda 8",0

.ORG $0120
	.db	0,"loader.fds",0

.ORG $0140
	.db	1,"Zelda no Densetsu",0

.ORG $0160
	.db	3,"Metroid (Japan) (v1.2) [b]",0

.ORG $0180
	.db	5,"Super Mario Brothers 2",0

.ORG $01A0
	.db	8,"Zelda 5",0

.ORG $01C0
	.db	10,"Zelda 6",0

.ORG $01E0
	.db	10,"Zelda 7",0

.ORG $0200
	.db	10,"Zelda 8",0

.ORG $0220
	.db	0,"loader.fds",0

.ORG $0240
	.db	1,"Zelda no Densetsu",0

.ORG $0260
	.db	3,"Metroid (Japan) (v1.2) [b]",0

.ORG $0280
	.db	5,"Super Mario Brothers 2",0

.ORG $02A0
	.db	8,"Zelda 5",0

.ORG $02C0
	.db	10,"Zelda 6",0

.ORG $02E0
	.db	10,"Zelda 7",0

.ORG $0300
	.db	10,"Zelda 8",0
