include damam.asm
.model small
.stack 128h
.data  
    banderajugador db 1
    banderajugando db 0
    cabecerasCol db "ABCDEFGH$"
    cabecerasFil db "12345678$"
    cadenafin db 'Fin del juego $'
    color db 0
    entradasTeclado db 10 dup("$"), "$"
    errorent db "Error de entrada",10,'$'
    ingresenombre1 db 'Ingrese nombre fichas blancas:',10,'$'
    ingresenombre2 db 'Ingrese nombre fichas rojas:',10,'$'
    ingresecoor1 db "Ingrese coordenadas jugador 1",10,'$'
    ingresecoor2 db "Ingrese coordenadas jugador 2",10,'$'
    indexI dw 0
    indexJ dw 0
    letraA db "A",10,'$'
    letraB db "B",10,'$'
    letraC db "C",10,'$'
    letraD db "D",10,'$'
    letraE db "E",10,'$'
    letraF db "F",10,'$'
    letraG db "G",10,'$'
    letraH db "H",10,'$'
    lineas db "|-$"
    Menu db "Opciones: ",10,"1. - Jugadores",10,"2. - Jugar",10,'$'
    nochar db " $"
    nombre1  db "#$$$$$$$$"
    nombre2  db "#$$$$$$$$"
    nonames db 'Debe asignar nombre a los jugadores!!','$'
    orgcasillalin dw 0
    proxcasilla db 0,0,0,0,0 ;A1:B1
    proxcasillalin dw 0
    salto db 10,13,' ', '$'
    space db " $"
    tablero db 64 dup(0),'$'

.code
    impsalto proc
        mov ah,02h
        mov dl,0ah ;salto de línea
        int 21h
        mov ah,02h
        mov dl,0dh ;retorno de carro
        int 21h
        ret
    impsalto endp    

    limpiarTerminal proc
        mov ax, 03h 
        int 10h
        ret
    limpiarTerminal endp

    calcularPosicionOrg proc
        XOR AX,AX
        MOV Al, proxcasilla[1]
        mov cl,3
        SHL Al, cl
        ADD Al, proxcasilla[0]
        MOV orgcasillalin, AX
        ret
    calcularPosicionOrg endp
    calcularPosicionDest proc 
        XOR AX,AX
        MOV Al, proxcasilla[4]
        mov cl, 3
        SHL Al, cl
        ADD Al, proxcasilla[3]
        MOV proxcasillalin, AX
        ret
    calcularPosicionDest endp

    ciclojuego proc
        mov banderajugando,1 
        juego:
            cmp banderajugando, 1
            jne salirjuego 

            pedirCoordenada
            call calcularPosicionOrg
            call calcularPosicionDest
            moverFicha
            call limpiarTerminal
            dibujarTablero
            ;  mov banderajugando, 0  ;quitar para que no se cierre 
            jmp juego
        salirjuego:
        ret
    ciclojuego endp

    start:        
        mov ax, @data 
        mov ds, ax
        iniciarjuego
        call limpiarTerminal
        iniciarTablero   
        dibujarTablero 
        call ciclojuego
        imprimir  cadenafin,8EH   
        mov ax,4C00h
        INT 21H
    end start