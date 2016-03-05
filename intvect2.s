;;interrupt vectors for getting around kyodoku

.MEMORYMAP
	SLOTSIZE 10
	DEFAULTSLOT 0
	SLOT 0 $0000

.ENDME

.ROMBANKMAP
	BANKSTOTAL 1
	BANKSIZE 10
	BANKS 1
.ENDRO

;;nmi
.dw	$6101
.dw	$6101
.dw	$6101

;;reset
.dw	$6110

;;irq
.dw	$6100
