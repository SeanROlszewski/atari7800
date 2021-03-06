;@A D	 *4>HR\+p
; Z-1________ -0

	.subttl "SSCMAC.S:  Macros for Atari 7800"
; Z-1________ -0

*____ MACROS TO ABBREVIATE SYNTAX ______

  .macro put this,there
	lda \this	      
	sta \there	      
  .endm

	.macro putadr adr,des
	lda	#\adr &$ff
	sta	\des
	lda	#\adr >>8
 	sta	\des+1
	.endm

;____ CRITICAL SYSTEM SETUP SIMPLIFICATION _____

;THIS MACRO CEASED TO FUNCTION 10/11/88 IN ALL OCCURRANCES THOUGH UNEDITED!

*  "CTRLset" writes to the crtl register:
;	.macro CTRLset ck,dma,cw,bc,km,mode
;	lda	#((\ck*$80) | (\dma*$20) | (\cw*$10) | (\bc*8) | (\km*4)|\mode)
;	sta	CTRL
;	.endm
;
;; Param options:
;COLORon	 =  $0	;normal color
;COLORoff	 =  $1	;kill the color
;DMAoff	=   $3	;turn off dma
;DMAon	=   $2	;normal dma
;CHAR1by	 =  $0	;one byte character definition
;CHAR2by	 =  $1	;two byte character definition
;BORDERbk	=   $0	;black border
;BORDERbg	=   $1	;background colored border
;TRANSon	 =  $0	;transparency
;TRANSoff	 =  $1	;"kangaroo" mode : no transparency!
;mode160	  =   $0	;160x2 or 160x4 modes
;mode320bd  =   $2	;320b or 320d modes
;mode320ac  =   $3	;320a or 320c modes

;  putbyte %01000000 	;for 160 mode
;  putbyte %01000011 	;for 320ac mode

*____ DISPLAY LIST AND DISPLAY LIST LIST ______

*  "header" constructs a 4 byte header for display lists:

  .macro header address,palette,width,hpos	 
	dc.B	\address & $ff		       
	dc.B	(\palette*$20) | ($1f & -\width)     
	dc.B	\address >> 8		       
	dc.B	\hpos			       
	.endm

*  "header5" constructs a 5 byte header for display lists:

  .macro header5 address,palette,width,hpos,wm,ind
	dc.B	\address & $ff		       
	dc.B	((\wm*$80) | $40 | (\ind*$20))       
	dc.B	\address >> 8		       
	dc.B	((\palette*$20) | ($1F & -\width))   
	dc.B	\hpos			       
	.endm

*  "nullhdr" constructs an end-of-display-list header:

	.macro nullhdr
	dc.B	0,0
	.endm

*  "pinhead" constructs a 4 byte header with integral nullhdr:

	.macro pinhead address,palette,width,hpos
	dc.B	\address & $ff		       
	dc.B	(\palette*$20) | ($1f & -\width)     
	dc.B	\address >> 8		       
	dc.B	\hpos			       
	dc.B	0,0
	.endm

;note, byte sequence loaddr, pal/wid, hiaddr, hpos

*  "display" constructs a 3 byte entry for the display list list:

	.macro display dli,h16,h8,offset,address

	dc.B	((\dli*$80) | (\h16*$40) | (\h8*$20) | \offset)
	dc.B	\address >> 8
	dc.B	\address & $ff
	.endm

;	.macro paint palnum,colornum,color,lum
;	lda	#(\color*$10) | \lum
;	sta	\bkgrnd | ((\palnum*4) | (\colornum))
;	.endm
; Z-1________ -0

; Z-1________ -0


                                                                                                                                                                   