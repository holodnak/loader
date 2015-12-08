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
.dw	$0600
.dw	$0600
.dw	$0600

;;reset
.dw	$0600

;;irq
.dw	$0600
