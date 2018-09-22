org 0x500
jmp 0x0000:start
data:

    inicio db 'Welcome to Time7-BootLoader', 13, 10, 0
    sequencia db 'Starting the Process', 13, 10, 'This Might Take Some Time...',13, 10, 'Checking Disks...',13, 10, 'Done',13, 10, 'Checking I/O Ports...',13, 10, 'Done',13, 10, 'Checking RAM Memory...',13, 10, 'Done',13, 10, 'Checking CPU...',13, 10, 'Done',13, 10, 'Setting up Protected Mode...',13, 10, 'Done',13, 10, 'Loading Kernel in Memory...',13, 10, 'Done',13, 10, 'Running Kernel...', 13, 10, 'Process Finalized', 0

start:
    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ah, 0
    mov al, 13h
    int 10h

    call ClearScreen

        ;printa primeira string
    mov ah, 2
    mov dh, 10
    mov dl, 8
    int 10h
    
    mov si, inicio
    call printstring_delayC
    call delayzao


    call ClearScreen

    mov si, sequencia
    call mostraFrases
    call delayzao

    call ClearScreen


    mov ax, 0x7e0 ;0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;posição es<<1+bx

    jmp reset

reset:
    mov ah, 00h ;reseta o controlador de disco
    mov dl, 0   ;floppy disk
    int 13h

    jc reset    ;se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ;lê um setor do disco
    mov al, 20  ;quantidade de setores ocupados pelo kernel
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 3
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load     ;se o acesso falhar, tenta novamente
    


    call ClearScreen
    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do boot2),



;||||||||||||||||FUNCOES
delay:
    mov ah, 86h
    mov cx, 1
    mov dx, 750h
    int 15h
ret

delayzao:
    mov ah, 86h
    mov cx, 20
    mov dx, 0h
    int 15h
ret

printstring_delayC:
    lodsb
    cmp al, 0
    je .done
    call delay
    mov ah, 0eh
    mov bl, 0xf
    int 10h
    jmp printstring_delayC
    .done:
ret


mostraFrases:
    lodsb
    cmp al, 0
    je fim

    cmp al, 13h
    jne twodelay
    call delay

    twodelay:
    call delay
    mov ah, 0eh
    mov bl, 0xf
    int 10h
    jmp mostraFrases

fim:
    ret

ClearScreen:
    mov ah, 0
    mov al, 13h
    int 10h
ret