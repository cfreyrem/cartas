	TITLE		"<DESARROLLO DE PROGRAMAS CON PIC'S>"
	SUBTITLE	"<Mi Primer Programa>"
	list	p=16f1828
	include	<p16f1828.inc>

Cnt1		set	0x20
Cnt2		set	0x21
Cnt3		set	0x22

Start
	BANKSEL	WDTCON
	bcf	WDTCON,SWDTEN		; No WatchDog

; CONFIGURACION DEL OPTION_REG
	movlw	5			; Prescalador de 64.
	movwf	OPTION_REG

; CONFIGURA LA VELOCIDAD DEL PROCESADOR
	movlw	(1 << SPLLEN)+(14 << IRCF0)+(0 << SCS0)
	movwf	OSCCON

; MANEJO DE LAS INTERRUPCIONES
	clrf	INTCON			; Desabilita Interrupciones
; INICIALIZA LOS PINES I/O
	BANKSEL	ANSELA
	bcf	ANSELA,0		; El Pin A0 es Digital.
	BANKSEL	FVRCON
	clrf	FVRCON
	clrf	DACCON0
	clrf	CM1CON0
	clrf	CM2CON0

	BANKSEL	TRISA
	bcf	TRISA,0			; El Pin A0 es Salida.

Loop
; RETARDO DE UN SEGUNDO
	movlb   0
	movlw	28
	movwf	Cnt1
L1	clrf	Cnt2
L2	clrf	Cnt3
L3	decfsz	Cnt3,F
	goto	L3
	decfsz	Cnt2,F
	goto	L2
	decfsz	Cnt1,F
	goto	L1
; PRENDE Y APAGA EL LED
	movlw	1
	BANKSEL	LATA
	xorwf	LATA,0
	goto	Loop

	end

