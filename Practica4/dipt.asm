.model small
.stack 128
.data
    diptongo db "paisaje",'$'
    hiato db "teorema",'$'
    triptongo db "premi",0A0h,"is",'$'
    esdipt db "Es diptongo",'$'
    noes db "No es ",'$'
    atilde db 0A0h
    etilde db 82h
    itilde db 0A1h
    otilde db 0A2h
    utilde db 0A3h
    flagDiptongo db 0
    flagHiato db 0
    flagTriptongo db 0
    flagcerrada1 db 0
    flagcerrada2 db 0
    flagabierta1 db 0
    flagabierta2 db 0 
    contador db 0
    textoaleer db "Texto de muestra con seis palabras",'$'
.code
    imprimir macro cadena, color
        local longitud, salirlong
        xor bx,bx 
        longitud: ;Pintar el texto en su totalidad
        cmp cadena[bx],"$"
        je salirlong
        inc bx
        jmp longitud
        salirlong: 
        mov ah, 09h ;Tipo de operacion de 21h muestra caracteres, basicamente print
        mov cx,bx
        mov bl, color ;Color del texto de salida
        int 10h ;Interrupcion para dar color
        lea dx, cadena ;Mostrando la cadena
        int 21h ;Interrupcion para mostrar
    endm

    clasificarDiptongo macro cadenad
        local lectura, salirLectura
        xor si,si 
        lectura: 
        cmp si,lengthof cadenad
        je salirLectura
        esA:
            cmp cadenad[si], "a" 
            jne esE
            inc si
            cmp cadenad[si],"i"
            jne esAu 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esAu:
            cmp cadenad[si],"u"
            jne esDolar
            mov flagDiptongo, 1
            jmp salirLectura
        esE: 
            cmp cadenad[si], "e" 
            jne esIla
            inc si
            cmp cadenad[si],"i"
            jne esEu 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esEu:
            cmp cadenad[si],"u"
            jne esDolar
            mov flagDiptongo, 1
            jmp salirLectura
        esIla: 
            cmp cadenad[si], "i" 
            jne esO
            inc si
            cmp cadenad[si],"a"
            jne esIe 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esIe:
            cmp cadenad[si],"e"
            jne esIo 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esIo:
            cmp cadenad[si],"o"
            jne esIu
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esIu:
            cmp cadenad[si],"u"
            jne esDolar
            mov flagDiptongo, 1
            jmp salirLectura
        esO: 
            cmp cadenad[si], "o" 
            jne esU
            inc si
            cmp cadenad[si],"i"
            jne esOu 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esOu:
            cmp cadenad[si],"u"
            jne esDolar
            mov flagDiptongo, 1
            jmp salirLectura
        esU: 
            cmp cadenad[si], "u" 
            jne esDolar
            inc si
            cmp cadenad[si],"a"
            jne esUe 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esUe:
            cmp cadenad[si],"e"
            jne esUi 
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esUi:
            cmp cadenad[si],"i"
            jne esUo
            inc si 
            mov flagDiptongo, 1
            jmp salirLectura
            esUo:
            cmp cadenad[si],"o"
            jne esDolar
            mov flagDiptongo, 1
            jmp salirLectura
        esDolar:
            cmp cadenad[si], 24H ;$
            jne esOtro
            je salirLectura
            inc si
        esOtro:     
            inc si 
            jmp lectura  
        salirLectura: 
    endm

    clasificarTriptongo macro cadenad
        local esDolar, esIla,esOtro, esIau, lectura, salirLectura
        xor si,si 
        mov flagTriptongo, 0
        lectura: 
        cmp si,lengthof cadenad
        je salirLectura
        esIla: 
            cmp cadenad[si], "i" 
            jne esU
            inc si
            cmp cadenad[si], "a" 
            jne esIe
            inc si
            cmp cadenad[si],"i"
            jne esIau
            inc si 
            add flagTriptongo, 1
            jmp salirLectura
            esIau:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                add flagDiptongo, 1
                jmp salirLectura
            esIe:
            cmp cadenad[si], "e" 
            jne esIo
            inc si
            cmp cadenad[si],"i"
            jne esIeu
            inc si 
            add flagTriptongo, 1
            jmp salirLectura
            esIeu:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                add flagTriptongo, 1
                jmp salirLectura
            esIo:
            cmp cadenad[si], "o" 
            jne esDolar
            inc si
            cmp cadenad[si],"i"
            jne esDolar
            inc si 
            add flagTriptongo, 1
            jmp salirLectura
        esU: 
            cmp cadenad[si], "u" 
            jne esDolar
            inc si
            cmp cadenad[si], "a" 
            jne esUe
            inc si
            cmp cadenad[si],"i"
            jne esUau
            inc si 
            add flagTriptongo, 1
            jmp salirLectura
            esUau:
                cmp cadenad[si],"u"
                jne esOtro 
                inc si 
                add flagDiptongo, 1
                jmp salirLectura
            esUe:
            cmp cadenad[si], "e" 
            jne esDolar
            inc si
            cmp cadenad[si],"i"
            jne esDolar
            inc si 
            add flagTriptongo, 1
            jmp salirLectura
        esDolar:
            cmp cadenad[si], 24H ;$
            jne esOtro
            je salirLectura
            inc si
        esOtro:     
            inc si 
            jmp lectura  
        salirLectura: 
    endm

    start:        
        mov ax, @data 
        mov ds, ax
        ; clasificarDiptongo diptongo
        ; cmp flagDiptongo, 1 
        ; jne noesdip
        ; imprimir esdipt, 0Fh
        ; jmp final
        ; noesdip:
        ; imprimir noes,0Fh
        clasificarTriptongo triptongo
        cmp flagTriptongo, 0 
        je noestrip
        imprimir esdipt, 0Fh
        jmp final
        noestrip:
        imprimir noes,0Fh
        final:
        mov ax,4C00h
        INT 21H
    end  start
