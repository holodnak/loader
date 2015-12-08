;;data to load to start nmi's and get around kyodoku

.MEMORYMAP
	SLOTSIZE 256
	DEFAULTSLOT 0
	SLOT 0 $0000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE 256
	BANKS 1
.ENDRO

.repeat 256
	.db	$80
.endr
