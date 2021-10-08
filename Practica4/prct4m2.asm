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

    clasificarHiato2 macro cadenad
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
                cmp cadenad[si],0A1H
                jne esAo
                inc si 
                inc flagHiato 
                inc flagacentual
                jmp lectura
            esAo:
                cmp cadenad[si],"o"
                jne esAuti
                inc si 
                inc flagHiato 
                inc flagsimple
                jmp lectura
             esAuti:
                cmp cadenad[si],0A3h
                jne esDolar
                inc si 
                inc flagHiato 
                inc flagacentual
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
                cmp cadenad[si],0A1H
                jne esEO
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
            esEuti:
                cmp cadenad[si],0A3h
                jne esDolar
                inc si 
                inc flagHiato 
                inc flagacentual
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
            cmp cadenad[si],0A1H
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
            cmp cadenad[si],0A3h    
            jne esO
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
                cmp cadenad[si],0A1H
                jne esOuti
                inc si
                inc flagHiato 
                inc flagacentual
                jmp lectura
                esOuti:
                    cmp cadenad[si],0A3h
                    jne esOo
                    inc si
                    inc flagHiato 
                    inc flagacentual
                    jmp lectura
            esOo:
                cmp cadenad[si],"o"
                jne esDolar
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
                jne esDolar
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

    clasificarHiatoPrint macro
        local esAcentual,noeshiato,finalhia
        cmp flagHiato, 0
        je noeshiato
        imprimir esHiato,0Fh
        call impsalto
        cmp flagsimple,0
        je esAcentual
        imprimir esSimple, 0BH
        call impsalto
        jmp finalhia
        esAcentual:
            cmp flagacentual,0
            je finalhia
            imprimir esAcentu, 0Bh
            call impsalto
            jmp finalhia
        noeshiato:
            imprimir noes, 0Fh
            call impsalto
        finalhia:
        call impsalto
    endm
    
    clasificarDiptongoPrint macro
        local esHomog,noesdipton,finaldip,esDecrec
        cmp flagDiptongo, 0
        je noesdipton
        imprimir esdipt,0Fh
        call impsalto
        cmp flagcreciente,0
        je esDecrec
        imprimir esCreciente, 0Bh
        call impsalto
        jmp finaldip
        esDecrec:
            cmp flagdecreciente,0
            je esHomog
            imprimir esDecreciente, 0Bh
            call impsalto
            jmp finaldip
        esHomog:
            cmp flaghomogeneo,0
            je finaldip
            imprimir esHomogeneo, 0Bh
            call impsalto
            jmp finaldip
        noesdipton:
            imprimir noes, 0Fh
            call impsalto
        finaldip:
        call impsalto
    endm

    clasificarTriptongoPrint macro
        local esHomog,noestrip,finaltrip
        cmp flagTriptongo, 0
        je noestrip
        imprimir estript,0Fh
        call impsalto
        jmp finaltrip
        noestrip:
            imprimir noes, 0Fh
            call impsalto
        finaltrip:
        call impsalto
    endm


    contarPalabras macro
        local contarchar,charcontados,noCRLF, noSpace,noTab,noLF
        xor si,si
        mov counterwords,1
        contarchar:
        cmp leido[si],"$"
        je charcontados
        cmp leido[si]," "
        jne noSpace
        cmp leido[si+1]," "
        je noSpace
        cmp leido[si+1],9
        je noSpace
        cmp leido[si+1],13
        je noSpace
        add counterwords,1
        noSpace:
            cmp leido[si],9
            jne noTab
            cmp leido[si+1],9
            je noTab
            cmp leido[si+1]," "
            je noTab
            cmp leido[si+1],13
            je noTab
            add counterwords,1
            noTab:
                cmp leido[si],13
                jne noCRLF
                cmp leido[si+1],9
                je noCRLF
                cmp leido[si+1]," "
                je noCRLF
                cmp leido[si+1],13
                je noCRLF
                cmp leido[si+1],10
                je noCRLF
                add counterwords,1
                noCRLF:
                    cmp leido[si],10
                    jne noLF
                    cmp leido[si+1],9
                    je noLF
                    cmp leido[si+1]," "
                    je noLF
                    cmp leido[si+1],13
                    je noLF
                    add counterwords,1
                    noLF:
                    inc si
                    jmp contarchar
        charcontados:
    xor si,si
    endm

    contarPalabrasPrint macro
        xor ax,ax
        mov al,counterwords
        call PRINT
        imprime palabrapala
        call impsalto
    endm

    printReporte macro 
        contarPalabras
        imprimir msjDipt, 10
        call impsalto
            imprimir msjCanti, 0Fh
            clasificarDiptongo leido  
            ;cantidad: 
            xor ax,ax
            mov al, flagDiptongo
            CALL PRINT
            call impsalto
            imprimir msjProp, 0Fh
            ;proporcion
            xor ax,ax
            mov ax,100
            mul flagDiptongo
            div counterwords
            mov propdiptongo,al
            xor ax,ax
            mov al,propdiptongo
            call PRINT
            imprime percent
            call impsalto
        imprimir msjHiato, 12
        call impsalto
            imprimir msjCanti, 0Fh
            clasificarHiato leido
            ;cantidad:
            xor ax,ax
            mov al, flagHiato
            call PRINT
            call impsalto
            imprimir msjProp, 0Fh
            ;proporcion 
            xor ax,ax
            mov ax,100
            mul flagHiato
            div counterwords
            mov prophiato,al
            xor ax,ax
            mov al,prophiato
            call PRINT
            imprime percent
            call impsalto
        imprimir msjTript, 14
        call impsalto
            imprimir msjCanti, 0Fh
            clasificarTriptongo leido
            ;cantidad:
            xor ax,ax
            mov al, flagTriptongo
            call PRINT
            call impsalto
            imprimir msjProp, 0Fh
            ;proporcion 
            xor ax,ax
            mov ax,100
            mul flagTriptongo
            div counterwords
            mov proptriptongo,al
            xor ax,ax
            mov al,proptriptongo
            call PRINT
            imprime percent
            call impsalto
        contarPalabrasPrint
        call impsalto

    endm 


    writeReporte macro 
        contarPalabras
            clasificarDiptongo leido  
            ;;;;;diptongo
            ;cantidad: 
            xor ax,ax
            mov al, flagDiptongo
            CALL NOPRINT
            mov al, numero[1]
            mov textoreporte[24],al 
            mov al, numero[2]
            mov textoreporte[25],al 
            ;proporcion
            xor ax,ax
            mov ax,100
            mul flagDiptongo
            div counterwords
            mov propdiptongo,al
            xor ax,ax
            mov al,propdiptongo
            call NOPRINT
            mov al, numero[1]
            mov textoreporte[44],al 
            mov al, numero[2]
            mov textoreporte[45],al 
            ;;;;;diptongo
            clasificarHiato leido
           ;cantidad:
            xor ax,ax
            mov al, flagHiato
            call NOPRINT
            mov al, numero[1]
            mov textoreporte[70],al 
            mov al, numero[2]
            mov textoreporte[71],al 
            ;proporcion 
            xor ax,ax
            mov ax,100
            mul flagHiato
            div counterwords
            mov prophiato,al
            xor ax,ax
            mov al,prophiato
            call NOPRINT
            mov al, numero[1]
            mov textoreporte[90],al 
            mov al, numero[2]
            mov textoreporte[91],al 
            ;;;;;triptongo
            clasificarTriptongo leido
            ;cantidad:
            xor ax,ax
            mov al, flagTriptongo
            call NOPRINT
            mov al, numero[1]
            mov textoreporte[120],al 
            mov al, numero[2]
            mov textoreporte[121],al 
            ;proporcion 
            xor ax,ax
            mov ax,100
            mul flagTriptongo
            div counterwords
            mov proptriptongo,al
            xor ax,ax
            mov al,proptriptongo
            call NOPRINT
            mov al, numero[1]
            mov textoreporte[140],al 
            mov al, numero[2]
            mov textoreporte[141],al 
            call impsalto
    endm 