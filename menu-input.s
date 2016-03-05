;;read input and deal with button presses
readinput:

;;strobe
	lda #1
	sta $4016
	lda	#0
	sta $4016

;;read pad data
	ldx	#8

-	pha
	lda	$4016
	and #3
	cmp #1
	pla
	rol a
	dex
	bne	-

	sta 	PADDATA
	tay
	eor		PADDATA2
	and		PADDATA
	sta		PADDATA
	sty.w	PADDATA2

;Also in the joypad reading code:
;While any directional button is currently being held down, decrease a somewhat long timer.
;If no directions are held, reset the timer. If the timer goes down to zero, copy the current
;pad state as-is to the joypad trigger. You then reload the timer with a very short timer
;value as long as the direction (or pad in general) continues to be pressed.

	;;load joypad directional button presses, branch if none are being held
	lda 	PADDATA2
	and 	#$0F
	beq 	+

	dec 	joycount
	beq 	repeat
	rts

	;;reset the joypad repeat timer
+	lda 	#30
	sta 	joycount
	rts

repeat:
	ora 	PADDATA
	sta 	PADDATA
	lda 	#5
	sta 	joycount
	rts

parseinput:
;;parse pad data

	lda	PADDATA2		;;load controller data
	cmp #$38
	bne +
	jmp	updatefirmware	;;update the firmware

+	lda	PADDATA			;;load controller data
	and	#$04			;;mask off down
	beq	+				;;if 0, then branch
	jsr	nextdisk		;;go to next disk

+	lda	PADDATA			;;load controller data
	and	#$08			;;mask off up
	beq	+
	jsr	prevdisk		;;go to previous disk

+	lda	PADDATA			;;load controller data
	and	#$01			;;mask off right
	beq	+
	jsr	nextpage		;;go to next page

+	lda	PADDATA			;;load controller data
	and	#$02			;;mask off left
	beq	+
	jsr prevpage		;;go to previous page

+	lda	PADDATA			;;load controller data
	and	#$80			;;mask off a button
	beq	+
	jsr	startdisk		;;start game

+	rts

parseboxinput:

	lda	PADDATA			;;load controller data
	and	#$80			;;mask off a button
	beq	+
	lda #1
	sta ok_button

+	lda	PADDATA			;;load controller data
	and	#$40			;;mask off b button
	beq	+
	lda #1
	sta cancel_button

+	rts

;;move down in the list
nextdisk:
	lda	curline
	cmp maxline
	beq	+
	inc	curline
	jmp	movearrow
+	lda #0
	sta curline
	jmp	movearrow

;;go up in the list
prevdisk:
	lda	curline
	cmp	#0
	beq	+
	dec	curline
	jmp	movearrow
+	lda maxline
	sta curline
	jmp	movearrow

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
;;also keeps up with the current selected disks index number (curdisk var)
movearrow:

	;;get disk index offset from current page
	;;perform multiply of page number -> starting game index
	lda 	curpage
	sta 	num1
	lda 	#23
	sta 	num2
	jsr		mul16
;;a = hi, x = lo
	sta 	curdisk+1
	stx 	curdisk
	txa
	clc
	adc 	curline
	sta 	curdisk
	bcc 	+
	inc 	curdisk+1

+	lda		curline
	asl
	asl
	asl
	clc
	adc		#39
	sta		SPRITES+0
	rts

;;change the page
movepage:

	;;reset line to 0
	lda 	#0
	sta 	curline

	;;calculate number of lines on this page
	lda 	curpage

	;;perform multiply of page number -> starting game index
	sta 	num1
	lda 	#23
	sta 	num2
	jsr		mul16

	;;save result to temp mem
	sta 	num2+1
	stx 	num2+0

	;;load number of disks total in the list
	lda 	DISKLIST+0
	sta 	num1+0
	lda 	DISKLIST+1
	sta 	num1+1

	jsr 	sub16

	;;check high byte of result if it is zero
	lda 	res+1
	bne 	allines

	;;check low byte 
	lda 	res+0

	;;if result is 23 or greater, then display max lines, else display the result number of lines
	cmp #23
	bcc +
allines:
	lda #23
+	sta maxline
	dec maxline

	jsr movearrow

	jsr drawpage

	rts
