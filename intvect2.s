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
.dw	$6200
.dw	$6200
.dw	$6200

;;reset
.dw	$6400

;;irq
.dw	$6100
