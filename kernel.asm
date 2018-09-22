org 0x7e00
jmp 0x0000:start


data:
;MENU
menuuu db '          CHOOSE YOUR GAME', 13, 10, 0
branco db '', 13, 10, 0
escolha1 db '    >TIC TAC TOY', 13, 10, '', 13, 10, '     GENIUS', 13, 10, '', 13, 10, '     QUIT', 0
escolha2 db '     TIC TAC TOY', 13, 10, '', 13, 10, '    >GENIUS', 13, 10, '', 13, 10, '     QUIT', 0
escolha3 db '     TIC TAC TOY', 13, 10, '', 13, 10, '     GENIUS', 13, 10, '', 13, 10, '    >QUIT', 0
;TIC
string db 'Press Enter to Start', 13, 10, 0
vetor times 10 db '0'
empate db 'Draw', 13, 10, 0
player db 'Player      won!!',0 ,0 ,0
;GEN
string1 db 'Press Enter to Start', 10, 10, 0
string2 db 'Write the Sequence', 10, 10, 0
string3 db 'Game Over', 10, 10, 0
string4 db 'You Win', 10, 10, 0
;QUIT
desliga db 'SHUTTING DOWN...', 10, 10, 0



start:
	xor ax, ax
	mov ds, ax
	mov es, ax

	mov ah, 0
	mov al, 13h
    int 10h

;|||||||||||||||||||||||||||||||||

;---------------MENU PRINCIPAL

;||||||||||||||||||||||||||||||||||

mov si, menuuu
call print_string

mov si, branco
call print_string
mov si, branco
call print_string
mov si, branco
call print_string

mov si, escolha1
call print_string

mov dl, 1


	cima:
		

		call ClearScreen

		mov si, menuuu
		call print_string

		mov si, branco
		call print_string
		mov si, branco
		call print_string
		mov si, branco
		call print_string

		mov si, escolha1
		call print_string

		mov dl, 1

		mov ah, 0
		int 16h

		cmp al, 0xd
		je entra

		cmp ax, 0x05000
		je meio

		cmp ax, 0x4800
		je baixo



		jmp cima



	meio:


		call ClearScreen

		mov si, menuuu
		call print_string

		mov si, branco
		call print_string
		mov si, branco
		call print_string
		mov si, branco
		call print_string

		mov si, escolha2
		call print_string

		mov dl, 2

		mov ah, 0
		int 16h

		cmp al, 0xd
		je entra

		cmp ax, 0x4800
		je cima

		cmp ax, 0x05000
		je baixo


		jmp meio



	baixo:



		call ClearScreen

		mov si, menuuu
		call print_string

		mov si, branco
		call print_string
		mov si, branco
		call print_string
		mov si, branco
		call print_string

		mov si, escolha3
		call print_string

		mov dl, 3

		mov ah, 0
		int 16h

		cmp al, 0xd
		je entra


		cmp ax, 0x05000
		je cima

		cmp ax, 0x4800
		je meio


		jmp baixo







entra:
	call ClearScreen
	cmp dl, 1
	je TICTACTOY
	cmp dl, 2
	je GENIUS
	jmp QUITGAME








;|||||||||||||||||||||||||||||||||||||||||||||||

;-------------------------TIC TAC TOY

;|||||||||||||||||||||||||||||||||||||||||||||||
TICTACTOY:

		inicio:
		    call mostratela
		    mov ah, 0
		    int 16h
		    cmp al, 0dh
		    je gameplay


		    

		gameplay:
    	
    	call clear
    	call chamaVelha
    	call PutNumbers
    	mov cx, 0
    	mov di, vetor
    
    	comecou:
        	lerX:
        	mov ah, 0
        	int 16h
        	sub al, 48
        	mov bl, al
        	cmp byte[di+bx], '0'
        	jne lerX
        	inc byte[di+bx]
        	call printX

        	inc cx
        	push cx
        	xor cx, cx
        ;mov si, vetor
        	call verifyX
       		pop cx

        lerTrian:
	        mov ah, 0
	        int 16h
	        sub al, 48
	        mov bl, al
	        cmp byte[di+bx], '0'
	        jne lerTrian
	        times 2 inc byte[di+bx]
	        call printTrian

	        inc cx
	        push cx
	        xor cx, cx
	        ;mov si, vetor
	        call verifyT
	        pop cx

        ;inc cx
	    cmp cx, 9
	    jne comecou
	    mov ah, 2h
	    mov dh, 13
	    mov dl, 12
	    int 10h
	    mov si, empate
	    call printstring
	    jmp done




		mostratela:
		    mov cx, 80
		    mov dx, 40
		    mov al, 0eh
		    call fazT

		    mov cx, 135
		    mov dx, 40
		    mov al, 1
		    call fazT

		    mov cx, 190
		    mov dx, 40
		    mov al, 4
		    call fazT 

		    mov ah, 2
		    mov dh, 17
		    mov dl, 10
		    int 10h

		    mov si, string
		    call printstring
		    
		ret

		fazT:
		    b1:
		        push cx
		        mov di, cx
		        add di, 50
		        b2:
		            mov ah, 0ch
		            mov bh, 0
		            ;mov al, 0xd
		            int 10h
		            inc cx
		            cmp cx, di
		        jle b2
		        pop cx 
		        inc dx
		        cmp dx, 50
		    jle b1

		    b3:
		        push cx
		        add cx, 20 
		        mov di, cx
		        add di, 10
		        b4:
		            mov ah, 0ch
		            mov bh, 0
		            ;mov al, 0xd
		            int 10h
		            inc cx
		            cmp cx, di
		        jle b4
		        pop cx
		        inc dx
		        cmp dx, 100
		    jle b3
		ret

		printstring:
		    lodsb
		    cmp al, 0
		    je .done

		    mov ah, 0eh
		    mov bl, 0xf
		    int 10h
		    jmp printstring
		    .done:
		        ret

		chamaVelha:
		    ;1coluna
		    mov al, 0xf
		    mov dx, 9
		    mov cx, 109
		    c1:
		        mov cx, 109
		        inc dx 
		        c2:
		            inc cx
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            cmp cx,115 
		        jle c2 
		        cmp dx, 190
		    jle c1
		    ;2coluna
		    mov dx, 9
		    mov cx, 184
		    c3:
		        mov cx, 184
		        inc dx 
		        c4:
		            inc cx
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            cmp cx, 190
		        jle c4 
		        cmp dx, 190
		    jle c3

		    ;1linha
		    mov dx, 64
		    mov cx, 39
		    c5:  
		        mov cx, 39
		        inc dx 
		        b6:
		            inc cx
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            cmp cx,260 
		        jle b6 
		        cmp dx, 70
		    jle c5

		    ;2linha
		    mov dx, 129
		    mov cx, 39
		    c7:
		        mov cx, 39
		        inc dx 
		        c8:
		            inc cx
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            cmp cx,260 
		        jle c8 
		        cmp dx, 135
		    jle c7
		ret

		clear:
		    mov ah, 0
		    mov al, 13h
		    int 10h
		ret

		PutNumbers:
		    mov ah, 2
		    mov dh, 2
		    mov dl, 5
		    int 10h
		    mov ah, 0xe
		    mov al, '1'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 2
		    mov dl, 15
		    int 10h
		    mov ah, 0xe
		    mov al, '2'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 2
		    mov dl, 25
		    int 10h
		    mov ah, 0xe
		    mov al, '3'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 10
		    mov dl, 5
		    int 10h
		    mov ah, 0xe
		    mov al, '4'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 10
		    mov dl, 15
		    int 10h
		    mov ah, 0xe
		    mov al, '5'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 10
		    mov dl, 25
		    int 10h
		    mov ah, 0xe
		    mov al, '6'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 18
		    mov dl, 5
		    int 10h
		    mov ah, 0xe
		    mov al, '7'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 18
		    mov dl, 15
		    int 10h
		    mov ah, 0xe
		    mov al, '8'
		    mov bl, 0xf
		    int 10h

		    mov ah, 2
		    mov dh, 18
		    mov dl, 25
		    int 10h
		    mov ah, 0xe
		    mov al, '9'
		    mov bl, 0xf
		    int 10h
		ret

		printX:
		    cmp al, 1
		    je umX
		    cmp al, 2
		    je doisX
		    cmp al, 3
		    je tresX
		    cmp al, 4
		    je quatroX
		    cmp al, 5
		    je cincoX
		    cmp al, 6
		    je seisX
		    cmp al, 7
		    je seteX
		    cmp al, 8
		    je oitoX
		    cmp al, 9
		    je noveX

		    umX:
		        mov al, 0xe
		        mov cx, 60
		        mov dx, 20
		        a1:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 60
		        jle a1

		        mov cx, 100
		        mov dx, 20
		        a3:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 60
		        jle a3

		    jmp finish
		    doisX:
		        mov al, 0xe
		        mov cx, 130
		        mov dx, 20
		        a2:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 60
		        jle a2

		        mov cx, 170
		        mov dx, 20
		        a4:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 60
		        jle a4

		    jmp finish
		    tresX:
		        mov al, 0xe
		        mov cx, 210
		        mov dx, 20
		        a5:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 60
		        jle a5

		        mov cx, 250
		        mov dx, 20
		        a6:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 60
		        jle a6

		    jmp finish
		    quatroX:
		        mov al, 0xe
		        mov cx, 60
		        mov dx, 80
		        a7:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 120
		        jle a7

		        mov cx, 100
		        mov dx, 80
		        a8:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 120
		        jle a8

		    jmp finish
		    cincoX:
		        mov al, 0xe
		        mov cx, 130
		        mov dx, 80
		        a9:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 120
		        jle a9

		        mov cx, 170
		        mov dx, 80
		        a10:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 120
		        jle a10

		    jmp finish
		    seisX:
		        mov al, 0xe
		        mov cx, 210
		        mov dx, 80
		        a11:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 120
		        jle a11

		        mov cx, 250
		        mov dx, 80
		        a12:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 120
		        jle a12

		    jmp finish
		    seteX:
		        mov al, 0xe
		        mov cx, 60
		        mov dx, 140
		        a13:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 180
		        jle a13

		        mov cx, 100
		        mov dx, 140
		        a14:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 180
		        jle a14

		    jmp finish
		    oitoX:
		        mov al, 0xe
		        mov cx, 130
		        mov dx, 140
		        a15:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 180
		        jle a15

		        mov cx, 170
		        mov dx, 140
		        a26:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 180
		        jle a26

		    jmp finish
		    noveX:
		        mov al, 0xe
		        mov cx, 210
		        mov dx, 140
		        a17:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            inc dx
		            cmp dx, 180
		        jle a17

		        mov cx, 250
		        mov dx, 140
		        a18:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            inc dx
		            cmp dx, 180
		        jle a18

		    jmp finish


		finish:
		    ret


		printTrian:
		    cmp al, 1
		    je umT
		    cmp al, 2
		    je doisT
		    cmp al, 3
		    je tresT
		    cmp al, 4
		    je quatroT
		    cmp al, 5
		    je cincoT
		    cmp al, 6
		    je seisT
		    cmp al, 7
		    je seteT
		    cmp al, 8
		    je oitoT
		    cmp al, 9
		    je noveT

		    umT:
		        mov al, 9
		        mov cx, 75
		        mov dx, 20
		        ba1:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 60
		        jle ba1

		        mov cx, 75
		        mov dx, 20
		        ba2:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 60
		        jle ba2

		        mov cx, 55
		        mov dx, 60
		        ba3:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 95
		        jle ba3

		    jmp finish1
		    doisT:
		        mov al, 9
		        mov cx, 155
		        mov dx, 20
		        ba4:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 60
		        jle ba4

		        mov cx, 155
		        mov dx, 20
		        ba5:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 60
		        jle ba5

		        mov cx, 135
		        mov dx, 60
		        ba6:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 175
		        jle ba6

		    jmp finish1
		    tresT:
		        mov al, 9
		        mov cx, 235
		        mov dx, 20
		        b7:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 60
		        jle b7

		        mov cx, 235
		        mov dx, 20
		        b8:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 60
		        jle b8

		        mov cx, 215
		        mov dx, 60
		        b9:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 255
		        jle b9
		    jmp finish1
		    quatroT:
		        mov al, 9
		        mov cx, 75
		        mov dx, 80
		        b10:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b10

		        mov cx, 75
		        mov dx, 80
		        b11:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b11

		        mov cx, 55
		        mov dx, 120
		        b12:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 95
		        jle b12
		    jmp finish1

		    cincoT:
		        mov al, 9
		        mov cx, 155
		        mov dx, 80
		        b13:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b13


		        mov cx, 155
		        mov dx, 80
		        b14:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b14

		        mov cx, 135
		        mov dx, 120
		        b15:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 175
		        jle b15

		    jmp finish1
		    seisT:
		        mov al, 9
		        mov cx, 235
		        mov dx, 80
		        b16:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b16

		        mov cx, 235
		        mov dx, 80
		        b17:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 120
		        jle b17

		        mov cx, 215
		        mov dx, 120
		        b18:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 255
		        jle b18

		    jmp finish1
		    seteT:
		        mov al, 9
		        mov cx, 75
		        mov dx, 140
		        b19:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b19

		        mov cx, 75
		        mov dx, 140
		        b20:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b20

		        mov cx, 55
		        mov dx, 180
		        b21:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 95
		        jle b21

		    jmp finish1
		    oitoT:
		        mov al, 9
		        mov cx, 155
		        mov dx, 140
		        b22:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b22

		        mov cx, 155
		        mov dx, 140
		        b23:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b23

		        mov cx, 135
		        mov dx, 180
		        b24:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 175
		        jle b24

		    jmp finish1
		    noveT:
		        mov al, 9
		        mov cx, 235
		        mov dx, 140
		        b25:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b25

		        mov cx, 235
		        mov dx, 140
		        b26:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            dec cx
		            times 2 inc dx
		            cmp dx, 180
		        jle b26

		        mov cx, 215
		        mov dx, 180
		        b27:
		            mov ah, 0ch
		            mov bh, 0
		            int 10h
		            inc cx
		            cmp cx, 255
		        jle b27

		    jmp finish1


		finish1:
		    ret


		verifyX:
		    ;123
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 2
		    mov al, byte[di+bx]
		    mov bx, 3
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox1
		    cmp ah, cl
		    jne prox1
		    cmp ah, '1'
		    je winX

		    ;456
		    prox1:
		    mov bx, 4
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 6
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox2
		    cmp ah, cl
		    jne prox2
		    cmp ah, '1'
		    je winX

		    ;789
		    prox2:
		    mov bx, 7
		    mov ah, byte[di+bx]
		    mov bx, 8
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox3
		    cmp ah, cl
		    jne prox3
		    cmp ah, '1'
		    je winX

		    ;147
		    prox3:
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 4
		    mov al, byte[di+bx]
		    mov bx, 7
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox4
		    cmp ah, cl
		    jne prox4
		    cmp ah, '1'
		    je winX

		    ;258
		    prox4:
		    mov bx, 2
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 8
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox5
		    cmp ah, cl
		    jne prox5
		    cmp ah, '1'
		    je winX

		    ;369
		    prox5:
		    mov bx, 3
		    mov ah, byte[di+bx]
		    mov bx, 6
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox6
		    cmp ah, cl
		    jne prox6
		    cmp ah, '1'
		    je winX

		    ;159
		    prox6:
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne prox7
		    cmp ah, cl
		    jne prox7
		    cmp ah, '1'
		    je winX

		    ;357
		    prox7:
		    mov bx, 3
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 7
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne fim
		    cmp ah, cl
		    jne fim
		    cmp ah, '1'
		    je winX

		fim:
		    ret
		    
		verifyT:
		    ;123
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 2
		    mov al, byte[di+bx]
		    mov bx, 3
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next1
		    cmp ah, cl
		    jne next1
		    cmp ah, '2'
		    je winT

		    ;456
		    next1:
		    mov bx, 4
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 6
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next2
		    cmp ah, cl
		    jne next2
		    cmp ah, '2'
		    je winT

		    ;789
		    next2:
		    mov bx, 7
		    mov ah, byte[di+bx]
		    mov bx, 8
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next3
		    cmp ah, cl
		    jne next3
		    cmp ah, '2'
		    je winT

		    ;147
		    next3:
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 4
		    mov al, byte[di+bx]
		    mov bx, 7
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next4
		    cmp ah, cl
		    jne next4
		    cmp ah, '2'
		    je winT

		    ;258
		    next4:
		    mov bx, 2
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 8
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next5
		    cmp ah, cl
		    jne next5
		    cmp ah, '2'
		    je winT

		    ;369
		    next5:
		    mov bx, 3
		    mov ah, byte[di+bx]
		    mov bx, 6
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next6
		    cmp ah, cl
		    jne next6
		    cmp ah, '2'
		    je winT

		    ;159
		    next6:
		    mov bx, 1
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 9
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne next7
		    cmp ah, cl
		    jne next7
		    cmp ah, '2'
		    je winT

		    ;357
		    next7:
		    mov bx, 3
		    mov ah, byte[di+bx]
		    mov bx, 5
		    mov al, byte[di+bx]
		    mov bx, 7
		    mov cl, byte[di+bx]
		    cmp ah, al
		    jne fim2
		    cmp ah, cl
		    jne fim2
		    cmp ah, '2'
		    je winT

		fim2:
		    ret

		winX:
		    times 2 call delay
		    call clear
		    mov ah, 2
		    mov dh, 11
		    mov dl, 10
		    int 10h

		    mov si, player
		    call printstring

		    mov al, 0xf
		    mov cx, 140
		    mov dx, 80
		    lol1:
		        mov ah, 0ch
		        mov bh, 0
		        int 10h
		        inc cx
		        inc dx
		        cmp dx, 100
		    jle lol1

		    mov cx, 160
		    mov dx, 80
		    lol2:
		        mov ah, 0ch
		        mov bh, 0
		        int 10h
		        dec cx
		        inc dx
		        cmp dx, 100
		    jle lol2

		    call delayzao
		    jmp done

		winT:
		    times 2 call delay
		    call clear
		    mov ah, 2
		    mov dh, 11
		    mov dl, 10
		    int 10h

		    mov si, player
		    call printstring

		    mov al, 0xf
		    mov cx, 150
		    mov dx, 75
		    lol3:
		        mov ah, 0ch
		        mov bh, 0
		        int 10h
		        inc cx
		        times 2 inc dx
		        cmp dx, 105
		    jle lol3


		    mov cx, 150
		    mov dx, 75
		    lol4:
		        mov ah, 0ch
		        mov bh, 0
		        int 10h
		        dec cx
		        times 2 inc dx
		        cmp dx, 105
		    jle lol4

		    mov cx, 135
		    mov dx, 105
		    lol5:
		        mov ah, 0ch
		        mov bh, 0
		        int 10h
		        inc cx
		        cmp cx, 165
		    jle lol5
		    call delayzao
		    jmp done


;|||||||||||||||||||||||||||||||||||||||||||||||

;----------------------GENIUS

;||||||||||||||||||||||||||||||||||||||||||

GENIUS:

		;MENU
		;FUNDO
		    mov dx, 0
		    mov cx, 0

		    for1:
		    mov dx, 0
		    inc cx

		    for2:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 200
		    jne for2

		    cmp cx, 320

		    jne for1

		;G1
		    mov dx, 20
		    mov cx, 50

		    for3:
		    mov dx, 20
		    inc cx

		    for4:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 2 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne for4

		    cmp cx, 100

		    jne for3

		;E1
		    mov dx, 20
		    mov cx, 135

		    for5:
		    mov dx, 20
		    inc cx

		    for6:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 4 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne for6

		    cmp cx, 185

		    jne for5

		;N1
		    mov dx, 20
		    mov cx, 220

		    for7:
		    mov dx, 20
		    inc cx

		    for8:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 3 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne for8

		    cmp cx, 270

		    jne for7

		;E2
		    mov dx, 36
		    mov cx, 150

		    for9:
		    mov dx, 36
		    inc cx

		    for10:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne for10

		    cmp cx, 185

		    jne for9

		;E3
		    mov dx, 68
		    mov cx, 150

		    for11:
		    mov dx, 68
		    inc cx

		    for12:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne for12

		    cmp cx, 185

		    jne for11

		;G2

		    mov dx, 36
		    mov cx, 63

		    for13:
		    mov dx, 36
		    inc cx

		    for14:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne for14

		    cmp cx, 100

		    jne for13

		;G2

		    mov dx, 68
		    mov cx, 63

		    for15:
		    mov dx, 68
		    inc cx

		    for16:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne for16

		    cmp cx, 87

		    jne for15

		;G3

		    mov dx, 52
		    mov cx, 63

		    for17:
		    mov dx, 52
		    inc cx

		    for18:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 68
		    jne for18

		    cmp cx, 75

		    jne for17

		;N2
		    mov dx, 44
		    mov cx, 233

		    for19:
		    mov dx, 44
		    inc cx

		    for20:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne for20

		    cmp cx, 255

		    jne for19



		;PRESS START
		;seta cursor
		    mov ah, 02h
		    mov dh, 17 ;linha
		    mov dl, 10 ;coluna
		    int 10h
		 

		;print_string PRESS START:

		mov si, string1

		forstring:
		    lodsb ;carrega uma letra de si em al e passa para o proximo caractere
		    cmp al, 0
		    je continue

		    mov ah, 0xe
		    mov bl, 0xf
		    int 10h
		    jmp forstring

		continue:
		    mov ah, 0; n da chamda
		    int 16h
		    cmp al, 0dh ;compara com o ENTER
		    jne continue 

		call clear

		call padrao
		call delay


		;seta o cursor


		;FASE 1
		;seta o cursor
		mov ah, 02h
		mov dh, 0 ;linha
		mov dl, 0 ;coluna
		int 10h

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call Q1
		call delay
		call padrao
		call Sequencia
		call R1
		call delay
		call clear

		;FASE 2
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "2" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Q4
		call delay
		call padrao
		call Sequencia
		call R1
		call R4
		call delay
		call clear



		;FASE 3
		;seta o cursor
		mov AH, 0xe ;Número da chamada
		mov AL, "3" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call delay
		call clear

		;FASE 4
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "4" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call delay
		call clear

		;FASE 5
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "5" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call delay
		call clear

		;FASE 6
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "6" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call delay
		call clear

		;FASE 7
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "7" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call delay
		call clear

		;FASE 8
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "8" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call delay
		call clear

		;FASE 9
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "9" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call delay
		call clear

		;FASE 10
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "0" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call delay
		call clear

		;FASE11
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call delay
		call clear

		;FASE12
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "2" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call delay
		call clear

		;FASE13
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "3" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call delay
		call clear

		;FASE14
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "4" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call delay
		call clear

		;FASE15
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "5" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call delay
		call clear

		;FASE 16
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "6" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call R3
		call delay
		call clear

		;FASE 17
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "7" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call R3
		call R2
		call delay
		call clear

		;FASE 18
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "8" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call R3
		call R2
		call R4
		call delay
		call clear

		;FASE 19
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "1" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "9" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call R3
		call R2
		call R4
		call R4
		call delay
		call clear

		;FASE 20
		;seta o cursor

		mov AH, 0xe ;Número da chamada
		mov AL, "2" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		mov AH, 0xe ;Número da chamada
		mov AL, "0" ;Caractere em ASCII a se escrever
		mov BL, 0xf ;Cor da letra, Branco,
		int 10h
		;
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call delay
		call Q3
		call delay
		call padrao
		call delay
		call Q2
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q4
		call delay
		call padrao
		call delay
		call Q1
		call delay
		call padrao
		call Sequencia
		call delay
		call R1
		call R4
		call R4
		call R2
		call R3
		call R1
		call R1
		call R2
		call R4
		call R3
		call R3
		call R4
		call R2
		call R1
		call R1
		call R3
		call R2
		call R4
		call R4
		call R1
		call delay
		call clear


		;You Win
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay
		call GG1
		call delay
		call GG2
		call delay





		call delayzao
		jmp done













		gameover:
		;seta o cursor
		call clear
		mov ah, 2
		mov bh, 0
		mov dh, 13 ;linha
		mov dl, 15 ;coluna
		int 10h
		;print_string:


		mov si, string3


		forstring2:
		    lodsb ;carrega uma letra de si em al e passa para o proximo caractere
		    cmp al, 0
		    je continue7

		    mov ah, 0xe
		    mov bl, 0xf
		    mov bh, 0
		    int 10h
		    jmp forstring2

		continue7:

		;call delay
		;call delay
		;call delay


		call delayzao
		jmp done

		;FUNCOES

		GG1:
		;G1
		    mov dx, 20
		    mov cx, 106

		    zum7:
		    mov dx, 20
		    inc cx

		    zum8:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 4 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne zum8

		    cmp cx, 156

		    jne zum7
		;G2

		    mov dx, 36
		    mov cx, 119

		    zum1:
		    mov dx, 36
		    inc cx

		    zum2:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne zum2

		    cmp cx, 156

		    jne zum1

		;G2

		    mov dx, 68
		    mov cx, 119

		    zum3:
		    mov dx, 68
		    inc cx

		    zum4:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne zum4

		    cmp cx, 143

		    jne zum3

		;G3

		    mov dx, 52
		    mov cx, 119

		    zum5:
		    mov dx, 52
		    inc cx

		    zum6:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 68
		    jne zum6

		    cmp cx, 131

		    jne zum5

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		;G1
		    mov dx, 20
		    mov cx, 164

		    zum9:
		    mov dx, 20
		    inc cx

		    zum10:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 4 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne zum10

		    cmp cx, 214

		    jne zum9
		;G2

		    mov dx, 36
		    mov cx, 177

		    zum11:
		    mov dx, 36
		    inc cx

		    zum12:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne zum12

		    cmp cx, 214

		    jne zum11

		;G2

		    mov dx, 68
		    mov cx, 177

		    zum13:
		    mov dx, 68
		    inc cx

		    zum14:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne zum14

		    cmp cx, 201

		    jne zum13

		;G3

		    mov dx, 52
		    mov cx, 177

		    zum15:
		    mov dx, 52
		    inc cx

		    zum16:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 68
		    jne zum16

		    cmp cx, 189

		    jne zum15
		    
		;seta cursor
		    mov ah, 02h
		    mov dh, 17 ;linha
		    mov dl, 17 ;coluna
		    int 10h
		 

		;print_string YOU WIN:

		mov si, string4

		forstring9:
		    lodsb ;carrega uma letra de si em al e passa para o proximo caractere
		    cmp al, 0
		    je continue9

		    mov ah, 0xe
		    mov bl, 1
		    int 10h
		    jmp forstring9

		continue9:

		ret

		GG2:
		;G1
		    mov dx, 20
		    mov cx, 106

		    zum27:
		    mov dx, 20
		    inc cx

		    zum28:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 1 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne zum28

		    cmp cx, 156

		    jne zum27
		;G2

		    mov dx, 36
		    mov cx, 119

		    zum21:
		    mov dx, 36
		    inc cx

		    zum22:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne zum22

		    cmp cx, 156

		    jne zum21

		;G2

		    mov dx, 68
		    mov cx, 119

		    zum23:
		    mov dx, 68
		    inc cx

		    zum24:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne zum24

		    cmp cx, 143

		    jne zum23

		;G3

		    mov dx, 52
		    mov cx, 119

		    zum25:
		    mov dx, 52
		    inc cx

		    zum26:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 68
		    jne zum26

		    cmp cx, 131

		    jne zum25

		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		;G1
		    mov dx, 20
		    mov cx, 164

		    zum29:
		    mov dx, 20
		    inc cx

		    zum210:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 1 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 100
		    jne zum210

		    cmp cx, 214

		    jne zum29
		;G2

		    mov dx, 36
		    mov cx, 177

		    zum211:
		    mov dx, 36
		    inc cx

		    zum212:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 52
		    jne zum212

		    cmp cx, 214

		    jne zum211

		;G2

		    mov dx, 68
		    mov cx, 177

		    zum213:
		    mov dx, 68
		    inc cx

		    zum214:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 84
		    jne zum214

		    cmp cx, 201

		    jne zum213

		;G3

		    mov dx, 52
		    mov cx, 177

		    zum215:
		    mov dx, 52
		    inc cx

		    zum216:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 68
		    jne zum216

		    cmp cx, 189

		    jne zum215
		    
		;seta cursor
		    mov ah, 02h
		    mov dh, 17 ;linha
		    mov dl, 17 ;coluna
		    int 10h
		 

		;print_string YOU WIN:

		mov si, string4

		forstring10:
		    lodsb ;carrega uma letra de si em al e passa para o proximo caractere
		    cmp al, 0
		    je continue10

		    mov ah, 0xe
		    mov bl, 4
		    int 10h
		    jmp forstring10

		continue10:

		ret


		R1:
		;lê
		mov ah, 0
		int 16h
		;printa
		mov ah, 0eh
		mov bl, 0xf
		mov bh, 1
		int 10h
		cmp al, '1'
		jne gameover
		ret

		R2:
		;lê
		mov ah, 0
		int 16h
		;printa
		mov ah, 0eh
		mov bl, 0xf
		mov bh, 1
		int 10h
		cmp al, '2'
		jne gameover
		ret

		R3:
		;lê
		mov ah, 0
		int 16h
		;printa
		mov ah, 0eh
		mov bl, 0xf
		mov bh, 1
		int 10h
		cmp al, '3'
		jne gameover
		ret


		R4:
		;lê
		mov ah, 0
		int 16h
		;printa
		mov ah, 0eh
		mov bl, 0xf
		mov bh, 1
		int 10h
		cmp al, '4'
		jne gameover
		ret


		Sequencia:
		;seta posicao da string
		mov ah, 02h
		mov dh, 1 ;linha
		mov dl, 11 ;coluna
		int 10h

		mov si, string2

		forstring1:
		    lodsb ;carrega uma letra de si em al e passa para o proximo caractere
		    cmp al, 0
		    je continue1

		    mov ah, 0xe
		    mov bl, 0xf
		    int 10h
		    jmp forstring1

		continue1:
		    mov ah, 02h
		    mov dh, 23 ;linha
		    mov dl, 10 ;coluna
		    int 10h

		ret

		Q1:
		 ;QUADRADO 1
		    mov dx, 20
		    mov cx, 80

		    para11:
		    mov dx, 20
		    inc cx

		    para12:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 1 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 97
		    jne para12

		    cmp cx, 157;

		    jne para11
		 ret

		 Q2:
		 ;QUADRADO 2
		    mov dx, 20
		    mov cx, 163

		    para13:
		    mov dx, 20
		    inc cx

		    para14:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 4 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 97
		    jne para14

		    cmp cx, 240

		    jne para13

		 ret

		 Q3:
		 ;QUADRADO 3
		    mov dx, 103
		    mov cx, 80

		    para15:
		    mov dx, 103
		    inc cx

		    para16:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 2 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 180
		    jne para16

		    cmp cx, 157

		    jne para15
		 ret

		 Q4:
		 ;QUADRADO 4
		    mov dx, 103
		    mov cx, 163

		    para9:
		    mov dx, 103
		    inc cx

		    para10:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 0xe ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 180
		    jne para10

		    cmp cx, 240

		    jne para9
		ret

		padrao:
		 ;QUADRADO 1

		    mov dx, 20
		    mov cx, 80

		    para1:
		    mov dx, 20
		    inc cx

		    para2:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 7 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 97
		    jne para2

		    cmp cx, 157

		    jne para1
		  ;
		    mov ah, 02h
		    mov dh, 3 ;linha
		    mov dl, 11 ;coluna
		    int 10h

		    mov AH, 0xe ;Número da chamada
		    mov AL, "1" ;Caractere em ASCII a se escrever
		    mov BH, 0 ;Número da página.
		    mov BL, 0xf ;Cor da letra, Branco, apenas em
		    int 10h
		 ;

		;QUADRADO 2

		    mov dx, 20
		    mov cx, 163

		    para3:
		    mov dx, 20
		    inc cx

		    para4:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 7 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 97
		    jne para4

		    cmp cx, 240

		    jne para3
		  ;
		    mov ah, 02h
		    mov dh, 3;linha
		    mov dl, 21 ;coluna
		    int 10h

		    mov AH, 0xe ;Número da chamada
		    mov AL, "2" ;Caractere em ASCII a se escrever
		    mov BH, 0 ;Número da página.
		    mov BL, 0xf ;Cor da letra, Branco, apenas em
		    int 10h
		;

		 ;QUADRADO 3
		    mov dx, 103
		    mov cx, 80

		    para5:
		    mov dx, 103
		    inc cx

		    para6:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 7 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 180
		    jne para6

		    cmp cx, 157

		    jne para5
		      ;
		    mov ah, 02h
		    mov dh, 14 ;linha
		    mov dl, 11 ;coluna
		    int 10h

		    mov AH, 0xe ;Número da chamada
		    mov AL, "3" ;Caractere em ASCII a se escrever
		    mov BH, 0 ;Número da página.
		    mov BL, 0xf ;Cor da letra, Branco, apenas em
		    int 10h
		 ;


		 ;QUADRADO 4
		    mov dx, 103
		    mov cx, 163

		    para7:
		    mov dx, 103
		    inc cx

		    para8:
		    inc dx

		    mov ah, 0ch ;pixel na coordenada [dx, cx]
		    mov bh, 0
		    mov al, 7 ;cor do pixel (verde claro)
		    int 10h

		    cmp dx, 180
		    jne para8

		    cmp cx, 240

		    jne para7
		      ;
		    mov ah, 02h
		    mov dh, 14 ;linha
		    mov dl, 21 ;coluna
		    int 10h

		    mov AH, 0xe ;Número da chamada
		    mov AL, "4" ;Caractere em ASCII a se escrever
		    mov BH, 0 ;Número da página.
		    mov BL, 0xf ;Cor da letra, Branco, apenas em
		    int 10h
		 ;
		ret



;||||||||||||||||||||||||||||||||||||||||||||

;--------------------------QUIT

;|||||||||||||||||||||||||||||||||||||||||||||


QUITGAME:
	call ClearScreen

    mov ah, 02h
    mov dh, 12 ;linha
    mov dl, 11 ;coluna
    int 10h

	mov si, desliga

	call printstring_delayC

	call delay

	mov ax, 0x5307
	mov bx, 0x0001
	mov cx, 0x003
	int 15h









;;;FUNCOES

delay:
    mov ah, 86h
    mov cx, 3h
    mov dx, 750h
    int 15h
ret

delayzao:
    mov ah, 86h
    mov cx, 50h
    mov dx, 750h
    int 15h
ret

print_string:
	lodsb
	cmp al, 0
	je finaal

	mov ah, 0eh
	mov bl, 0xf
	int 10h
	jmp print_string

finaal:
ret

printstring_delayC:
    lodsb
    cmp al, 0
    je .done
    call delay
    call delay
    mov ah, 0eh
    mov bl, 0xf
    int 10h
    jmp printstring_delayC
    .done:
ret


ClearScreen:
pusha
    mov ah, 0
    mov al, 13h
    int 10h
popa
ret

done:
	call ClearScreen
	jmp start