.model small
.stack 128
.data
    diptongo db "ia ie io ua ue uo ai au ei eu oi ou iu ui",'$'
    hiato db "aí aú eí eú oí oú ía íe ío úa úe úo aa ee ii oo uu ae ao ea eo oa oe",'$'
    ;hiato db "aú",'$'
    triptongo db "iai ieu iei ieu ioi iou uai uau uei ueu uoi uoi",'$'
    esdipt db "Es diptongo",'$'
    estript db "Es triptongo",'$'
    esHiato db "Es hiato",'$'
    noes db "No es ",'$'
    flagDiptongo db 0
    flagcreciente db 0
    flagdecreciente db 0
    flaghomogeneo db 0
    flagHiato db 0
    flagacentual db 0
    flagsimple db 0
    flagTriptongo db 0
    atilde db 0A0h,10,13,'$'
    etilde db 82h,10,13,'$'
    itilde db 0A1h,10,13,'$'
    otilde db 0A2h,10,13,'$'
    utilde db 0A3h,10,13,'$'
    testi db "í",'$'
    testu db "ú",'$'
    salto db " ",10,13,'$'
    marca db "llego hasta aqui",10,13,'$'
    letraa db "a",'$'
    letrao db "o",'$'
    letrai db "i",'$'
    letrae db "e",'$'
    letrau db "u",'$'
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
        local esA,esE,esAu, esIla,esEu,esO,esIe,esIo,esIu,esDolar,esU,esOu,esUe,esUi,esUo,esOtro,lectura, salirLectura
        xor si,si 
        mov flagDiptongo, 0
        mov flagcreciente, 0
        mov flagdecreciente, 0
        mov flaghomogeneo, 0
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
            inc flagDiptongo
            inc flagdecreciente
            jmp lectura
            esAu:
                cmp cadenad[si],"u"
                jne esDolar
                inc flagDiptongo
                inc flagdecreciente
                jmp lectura
        esE: 
            cmp cadenad[si], "e" 
            jne esIla
            inc si
            cmp cadenad[si],"i"
            jne esEu 
            inc si 
            inc flagDiptongo
            inc flagdecreciente
            jmp lectura
            esEu:
                cmp cadenad[si],"u"
                jne esDolar
                inc si
                inc flagDiptongo
                inc flagdecreciente
                jmp lectura
        esIla: 
            cmp cadenad[si], "i" 
            jne esO
            inc si
            cmp cadenad[si],"a"
            jne esIe 
            inc si 
            inc flagDiptongo
            inc flagcreciente
            jmp lectura
            esIe:
                cmp cadenad[si],"e"
                jne esIo 
                inc si 
                inc flagDiptongo
                inc flagcreciente
                jmp lectura
            esIo:
                cmp cadenad[si],"o"
                jne esIu
                inc si 
                inc flagDiptongo
                inc flagcreciente
                jmp lectura
            esIu:
                cmp cadenad[si],"u"
                jne esDolar
                inc si 
                inc flagDiptongo
                inc flaghomogeneo
                jmp lectura
        esO: 
            cmp cadenad[si], "o" 
            jne esU
            inc si
            cmp cadenad[si],"i"
            jne esOu 
            inc si 
            inc flagDiptongo
            inc flagdecreciente
            jmp lectura
            esOu:
                cmp cadenad[si],"u"
                jne esDolar
                inc si
                inc flagDiptongo
                inc flagdecreciente
                jmp lectura
        esU: 
            cmp cadenad[si], "u" 
            jne esDolar
            inc si
            cmp cadenad[si],"a"
            jne esUe 
            inc si 
            inc flagDiptongo
            inc flagcreciente
            jmp lectura
            esUe:
                cmp cadenad[si],"e"
                jne esUi 
                inc si 
                inc flagDiptongo
                inc flagcreciente
                jmp lectura
            esUi:
                cmp cadenad[si],"i"
                jne esUo
                inc si 
                inc flagDiptongo
                inc flaghomogeneo
                jmp lectura
            esUo:
                cmp cadenad[si],"o"
                jne esDolar
                inc si
                inc flagDiptongo
                inc flagcreciente
                jmp lectura
        esDolar:
            cmp cadenad[si], 24H ;$
            jne esOtro
            je salirLectura
        esOtro:     
            inc si 
            jmp lectura  
        salirLectura: 
    endm

    clasificarHiato macro cadenad
        local esA,esAe, esAiti, esAo, esAuti,esE,esEe,esEiti,esEo,esEuti,esIla,esIti,esItie,esItio, esO, esOe,esOiti,esOo,esOuti,esU,esUti, esUtie, esUtio, esDolar,esOtro,lectura, salirLectura
        xor si,si 
        mov flagHiato, 0
        mov flagacentual, 0 
        mov flagsimple, 0
        lectura: 
        cmp si,lengthof cadenad
        je salirLectura
        esA:
            cmp cadenad[si], "a" 
            jne esE
            inc si
            cmp cadenad[si],"a"
            jne esAe 
            inc si 
            inc flagHiato
            inc flagsimple 
            jmp lectura
            esAe:
                cmp cadenad[si],"e"
                jne esAiti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
            esAiti:
                cmp cadenad[si],195
                jne esAo
                inc si 
                cmp cadenad[si],173
                jne esAuti
                inc si
                inc flagHiato 
                inc flagacentual
                jmp lectura
                esAuti:
                    cmp cadenad[si],186
                    jne esDolar
                    inc si 
                    inc flagHiato 
                    inc flagacentual
                    jmp lectura
            esAo:
                cmp cadenad[si],"o"
                jne esDolar
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
        esE: 
            cmp cadenad[si], "e" 
            jne esIla
            inc si
            cmp cadenad[si],"a"
            jne esEe
            inc si 
            inc flagHiato
            inc flagsimple 
            jmp lectura
            esEe:
                cmp cadenad[si],"e"
                jne esEiti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
            esEiti:
                cmp cadenad[si],195
                jne esEo
                inc si 
                cmp cadenad[si],173
                jne esEuti
                inc si
                inc flagHiato 
                inc flagacentual
                jmp lectura
                esEuti:
                    cmp cadenad[si],186
                    jne esDolar
                    inc si 
                    inc flagHiato 
                    inc flagacentual
                    jmp lectura
            esEo:
                cmp cadenad[si],"o"
                jne esEuti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
        esIla:
            cmp cadenad[si], "i" 
            jne esIti
            inc si
            cmp cadenad[si],"i"
            jne esDolar
            inc si 
            add flagHiato, 1
            add flagsimple, 1 
            jmp lectura
        esIti:
            cmp cadenad[si],195
            jne esO
            inc si 
            cmp cadenad[si],173
            jne esUti
            inc si 
            cmp cadenad[si],"a"
            jne esItie
            inc si 
            inc flagHiato
            inc flagacentual
            jmp lectura
            esItie:
                cmp cadenad[si],"e"
                jne esItio
                inc si 
                inc flagHiato
                inc flagacentual
                jmp lectura
            esItio:
                cmp cadenad[si],"o"
                jne esDolar
                inc si 
                inc flagHiato
                inc flagacentual
                jmp lectura
        esUti:
            cmp cadenad[si],186
            jne esDolar
            inc si 
            cmp cadenad[si],"a"
            jne esUtie
            inc si 
            inc flagHiato
            inc flagacentual
            jmp lectura
            esUtie:
                cmp cadenad[si],"e"
                jne esUtio
                inc si 
                inc flagHiato
                inc flagacentual
                jmp lectura
            esUtio:
                cmp cadenad[si],"o"
                jne esDolar
                inc si 
                inc flagHiato
                inc flagacentual
                jmp lectura
        esO:
            cmp cadenad[si], "o" 
            jne esU
            inc si
            cmp cadenad[si],"a"
            jne esOe
            inc si 
            inc flagHiato
            inc flagsimple 
            jmp lectura
            esOe:
                cmp cadenad[si],"e"
                jne esOiti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
            esOiti:
                cmp cadenad[si],195
                jne esOo
                inc si 
                cmp cadenad[si],173
                jne esOuti
                inc si
                inc flagHiato 
                inc flagacentual
                jmp lectura
                esOuti:
                    cmp cadenad[si],186
                    jne esDolar
                    inc si
                    inc flagHiato 
                    inc flagacentual
                    jmp lectura
            esOo:
                cmp cadenad[si],"o"
                jne esOuti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
        esU:
            cmp cadenad[si], "u" 
            jne esDolar
            inc si
            cmp cadenad[si],"u"
            jne esDolar
            inc si 
            add flagHiato, 1
            add flagsimple, 1 
            jmp lectura

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
        local esIla,esIau,esIe,esIeu,esIo,esIou, esU,esUau,esUe,esUeu,esUo,esUou,esDolar,esOtro, lectura, salirLectura
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
            inc flagTriptongo
            jmp lectura
            esIau:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                inc flagTriptongo
                jmp lectura
            esIe:
                cmp cadenad[si], "e" 
                jne esIo
                inc si
                cmp cadenad[si],"i"
                jne esIeu
                inc si 
                inc flagTriptongo
                jmp lectura
            esIeu:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                inc flagTriptongo
                jmp lectura
            esIo:
                cmp cadenad[si], "o" 
                jne esDolar
                inc si
                cmp cadenad[si],"i"
                jne esIou
                inc si 
                inc flagTriptongo
                jmp lectura
            esIou:
                cmp cadenad[si],"u"
                jne esDolar
                inc si
                inc flagTriptongo
                jmp lectura
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
            inc flagTriptongo
            jmp lectura
            esUau:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                inc flagTriptongo
                jmp lectura
            esUe:
                cmp cadenad[si], "e" 
                jne esUo
                inc si
                cmp cadenad[si],"i"
                jne esUeu
                inc si 
                inc flagTriptongo
                jmp lectura
            esUeu:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                inc flagTriptongo
                jmp lectura
            esUo:
            cmp cadenad[si], "o" 
            jne esDolar
            inc si
            cmp cadenad[si],"i"
            jne esUou
            inc si 
            inc flagTriptongo
            jmp lectura
            esUou:
                cmp cadenad[si],"u"
                jne esDolar 
                inc si 
                inc flagTriptongo
                jmp lectura
        esDolar:
            cmp cadenad[si], 24H ;$
            jne esOtro
            je salirLectura
        esOtro:     
            inc si 
            jmp lectura  
        salirLectura: 
    endm

    PRINT PROC             
        ;initialize count
        mov cx,0
        mov dx,0
        label1:
            ; if ax is zero
            cmp ax,0
            je print1                
            ;initialize bx to 10
            mov bx,10                  
            ; extract the last digit
            div bx                         
            ;push it in the stack
            push dx                       
            ;increment the count
            inc cx                       
            ;set dx to 0
            xor dx,dx
            jmp label1
        print1:
            ;check if count
            ;is greater than zero
            cmp cx,0
            je exit          
            ;pop the top of stack
            pop dx
            ;add 48 so that it
            ;represents the ASCII
            ;value of digits
            add dx,48    
            ;interrupt to print a
            ;character
            mov ah,02h
            int 21h
            
            ;decrease the count
            dec cx
            jmp print1
        exit:
        ret
    PRINT ENDP

    start:        
        mov ax, @data 
        mov ds, ax

        clasificarDiptongo diptongo
        cmp flagDiptongo, 0
        je noesdip
        imprimir esdipt, 0Fh
        mov ax,0
        mov al,flagDiptongo
        call PRINT
        jmp seguir
        noesdip:
        imprimir noes,0Fh
        seguir:

        clasificarTriptongo triptongo
        cmp flagTriptongo, 0 
        je noestrip
        imprimir estript, 0Fh
        mov ax,0
        mov al,flagTriptongo
        call PRINT
        jmp seguir2
        noestrip:
        imprimir noes,0Fh
        seguir2:

        clasificarHiato hiato
        cmp flagHiato, 0
        je noeshiato
        imprimir esHiato,0Fh
        mov ax,0
        mov al,flagHiato
        call PRINT 
        jmp final
        noeshiato:
        imprimir noes, 0Fh
        final:
        mov ax,4C00h
        INT 21H
    end  start
