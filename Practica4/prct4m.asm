abrirArchivo macro nombre 
    local error, noError
    mov ax, @data 
    mov ds, ax
    mov dx,offset nombre
    mov ah,3dh
    mov al,0 ;0h solo lectura, 1h solo escritura, 2 lectura y escritura
    int 21h
    jnc noError
    imprime msjerrorabrir
    call impsalto
    jc error
    noError:
    imprime msjabierto
    call impsalto
    mov handle, ax
    mov bx, handle
    mov cx, 255
    mov dx,offset leido
    mov ah,3fh
    int 21h

    mov dx, offset leido
    mov ah, 9
    int 21h 
    call impsalto

    error:
endm
abrirArchivo2 macro  nombre
    local error, noError,noabierto
    cmp handle,0
    je noabierto
    cerrarArchivo
    noabierto:
    borrarLeido
    ; mov handle,0
    mov dx,offset nombre
    mov ah,3dh
    mov al, 0; mov al,2 ;0h solo lectura, 1h solo escritura, 2 lectura y escritura
    int 21h
    jnc noError
    imprimir msjerrorabrir,05H
    call impsalto
    jmp error
    noError:
    mov handle, ax
    mov bx, handle
    mov cx, 1023
    mov dx,offset leido
    mov ah,3fh
    int 21h

    ; mov dx, offset leido
    ; mov ah, 9
    ; int 21h 
    ; call impsalto
    imprimir msjabierto,06H
    imprimir path, 0AH
    call impsalto
    error:
 endm

borrarLeido macro
    local borrado,borrar
    xor si,si
    borrar:
    cmp leido[si],"$"
    je borrado
    mov leido[si],24H
    inc si
    jmp borrar
    borrado:
xor si,si
endm
cerrarArchivo macro 
    local salircerr
    mov ah,3eh 
    mov bx,handle
    int 21h
    jnc salircerr
    imprimir msjerrorcerrar,05H
    salircerr:
endm
contarPalabras macro
    local contarchar,charcontados,noCRLF, noSpace
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
        call impsalto
        xor ax,ax
        mov al,counterwords
        call PRINT
        call impsalto
xor si,si
endm

crearArchivo macro nombre
local salir
mov ah,3ch
mov cx,0
mov dx,offset nombre
int 21h
jnc salir ;si se pudo crear
imprime random
salir:
imprimir msjcrear, 02H
mov bx,ax
mov ah,3eh ;cierra el archivo
int 21h
endm


encabezado macro
    local bucle, bucle2
    call impsalto
    mov cx, lengthof headACE1+4
    bucle:
        mov counter, cx
        mov bl,signos[0]
        mov nochar[0],bl
        imprimir nochar, 8Fh
        mov cx, counter
        loop bucle
    call impsalto
    mov bl,signos[1]
    mov nochar[0],bl
    imprimir nochar, 8Fh
    imprimir headuniversidad,0Fh
    imprimeespacios headuniversidad,headACE1
    imprimir nochar, 8Fh
    call impsalto
    imprimir nochar, 8Fh
    imprimir headACE1,0Fh
    imprimeespacios headACE1,headACE1
    imprimir nochar, 8Fh
    call impsalto
    imprimir nochar, 8Fh
    imprimir headnombrecarne,0Fh
    imprimeespacios headnombrecarne,headACE1
    imprimir nochar, 8Fh
    call impsalto
    imprimir nochar, 8Fh
    imprimir headprct4,0Fh
    imprimeespacios headprct4 ,headACE1
    imprimir nochar, 8Fh
    call impsalto
    imprimir nochar, 8Fh
    imprime blankspace,0Fh
    imprimeespacios blankspace ,headACE1
    imprimir nochar, 8Fh
    call impsalto
    imprimir nochar, 8Fh
    imprimir headcerrar,0Fh
    imprimeespacios headcerrar,headACE1
    imprimir nochar, 8Fh
    call impsalto
    mov cx, lengthof headACE1+4
    bucle2:
        mov counter, cx
        mov bl,signos[0]
        mov nochar[0],bl
        imprimir nochar, 8Fh
        mov cx, counter
        loop bucle2
    call impsalto
endm
impchar macro char
    mov ah,02h
    mov dl,char 
    int 21h
    ret
endm

imprimeespacios macro cadena,cadena2 
    local bucle
    mov ax, lengthof cadena2+3
    mov bx, lengthof cadena
    sub ax,bx
    mov cx,ax
    bucle:
        imprime blankspace
        loop bucle
endm

imprime macro cadena
  mov ah,09
  lea dx, cadena
  int 21h
endm

imprimir2 macro cadena, color
    mov ah, 09h ;Tipo de operacion de 21h muestra caracteres, basicamente print
    mov bl, color ;Color del texto de salida
    mov cx, lengthof cadena - 1 ;Pintar el texto en su totalidad
    int 10h ;Interrupcion para dar color
    lea dx, cadena ;Mostrando la cadena
    int 21h ;Interrupcion para mostrar
endm

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

imprimirvalores macro cadena 
    local salto, fin
    xor bx, bx ;Limpiando el registro
    salto:
        cmp bx, lengthof cadena-1 ;Verificar si es un salto de linea lo que se esta leyendo ya que la funcion que llama asigna el valor a al
        je fin
        esCero:
            cmp cadena[bx], 0
            jne esUno
            impchar numeros[0]
            inc bx 
            jmp salto
        esUno: 
            cmp cadena[bx], 1
            jne esDos
            impchar numeros[1]
            inc bx 
            jmp salto
        esDos:               
            cmp cadena[bx], 2
            jne esTres
            impchar numeros[2]
            inc bx 
            jmp salto
        esTres:  
            cmp cadena[bx], 3
            jne esCuatro
            impchar numeros[3]
            inc bx 
            jmp salto
        esCuatro: 
            cmp cadena[bx], 4
            jne esCinco
            impchar numeros[4]
            inc bx 
            jmp salto
        esCinco: 
            cmp cadena[bx], 5
            jne esSeis
            impchar numeros[5]
            inc bx 
            jmp salto
        esSeis: 
             cmp cadena[bx], 6
            jne esSiete
            impchar numeros[6]
            inc bx 
            jmp salto
        esSiete: 
            cmp cadena[bx], 7
            jne esOcho
            impchar numeros[7]
            inc bx 
            jmp salto
        esOcho: 
            cmp cadena[bx], 8
            jne esNueve
            impchar numeros[8]
            inc bx 
            jmp salto
        esNueve:
            cmp cadena[bx], 9
            jne esOtro
            impchar numeros[9]
            inc bx 
            jmp salto
        esOtro:
            impchar random[0]
            inc bx 
            jmp salto                                                        
    fin:
endm

leerHastaEnter macro entrada
    local salto, fin
    xor bx, bx ;Limpiando el registro
    salto:
        mov ah, 01h  ;La 01 es la funcion de entrada con caracter al asignar este valor a ah y ejecutar la interrupcion 21H
        int 21h
        cmp al, 0dh ;Verificar si es un salto de linea lo que se esta leyendo ya que la funcion que llama asigna el valor a al
        je fin
        mov entrada[bx], al
        inc bx
        jmp salto
    fin:
        mov al, 24h ;Agregando un signo de dolar para eliminar el salto de linea
        mov entrada[bx], al
endm

pedirComando macro
    local colorear,contar,contHia,contPal,contTrip,leer,LeerRuta, esA,esar,esCe, esD,esH,esn,esPe,esR,esT,esX,esXmay,esDolar,esOtro,leerPalTrip, noEsTXT, salirLeerPalTrip, salirLeerRuta, salirpedir
    leer:
    imprimir pedircom,0EH
    call impsalto
        xor si,si
        leerHastaEnter entradasTeclado
        call impsalto
        analizarEntrada:
        cmp si,lengthof entradasTeclado
        je salirpedir
        esA:
            cmp entradasTeclado[si], "a" 
            jne esCe
            inc si         
            cmp entradasTeclado[si], "b" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "r" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "i" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "r" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "_" 
            jne esOtro
            inc si
            ; imprime entradasTeclado
            ; call impsalto
            LeerRuta:
            cmp entradasTeclado[si], 24H ;$
            je salirLeerRuta
            mov al , entradasTeclado[si]
            mov path[si-6],al
            inc si
            jmp LeerRuta
            salirLeerRuta:                                          
                mov al, 24H
                mov path[si-6],al
                cmp path[si-10], "."
                jne noEsTXT
                cmp path[si-9],"t"
                jne noEsTXT
                cmp path[si-8],"x"
                jne noEsTXT
                cmp path[si-7],"t"
                jne noEsTXT
                je esTXT
                noEsTXT:
                imprimir msjNoTXT,05H
                imprimir path[si-9],07H
                call impsalto
                jmp leer
                esTXT:
                ; imprimir path,03H  ;Este se puede quitar despues junto con el siguiente
                abrirArchivo2 path
            ;jmp salirpedir ;
            jmp leer
        esCe: 
            cmp entradasTeclado[si], "c" 
            jne esD
            inc si
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "l" 
            jne esn
            inc si
            cmp entradasTeclado[si], "o"
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "r"
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "e"
            jne esOtro
            inc si 
            jmp esar
            esn:
                cmp entradasTeclado[si], "n"
                jne esOtro
                inc si 
                cmp entradasTeclado[si], "t"
                jne esOtro
                inc si 
            esar:
                cmp entradasTeclado[si], "a"
                jne esOtro
                inc si 
                cmp entradasTeclado[si], "r"
                jne esOtro
                inc si 
                cmp entradasTeclado[si-4],"n"
                jne colorear
                cmp entradasTeclado[si], "_"
                jne esOtro
                inc si 
                contar:
                    cmp entradasTeclado[si], "d"
                    jne contHia
                    inc si 
                    cmp entradasTeclado[si], "i" 
                    jne esOtro
                    inc si
                    cmp entradasTeclado[si], "p" 
                    jne esOtro
                    inc si 
                    cmp entradasTeclado[si], "t" 
                    jne esn
                    inc si
                    cmp entradasTeclado[si], "o"
                    jne esOtro
                    inc si 
                    cmp entradasTeclado[si], "n"
                    jne esOtro
                    inc si 
                    cmp entradasTeclado[si], "g"
                    jne esOtro
                    inc si 
                    cmp entradasTeclado[si], "o"
                    jne esOtro
                    inc si    
                    clasificarDiptongo leido
                    xor ax,ax
                    mov al, flagDiptongo
                    CALL PRINT
                    call impsalto
                    jmp leer                     
                    contHia:
                        cmp entradasTeclado[si], "h" ;Letra h
                        jne contPal
                        inc si
                        cmp entradasTeclado[si], "i" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "a" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "t" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "o" 
                        jne esOtro
                        inc si 
                        clasificarHiato leido
                        xor ax,ax
                        mov al, flagHiato
                        CALL PRINT
                        call impsalto
                        jmp leer  
                    contPal:
                        cmp entradasTeclado[si], "p" 
                        jne contTrip
                        inc si
                        cmp entradasTeclado[si], "a" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "l" 
                        jne esn
                        inc si
                        cmp entradasTeclado[si], "a"
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "b"
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "r"
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "a"
                        jne esOtro
                        inc si                 
                        contarPalabras
                        call impsalto
                        jmp leer
                    contTrip:
                        cmp entradasTeclado[si], "t" ;Letra t
                        jne esOtro
                        inc si
                        cmp entradasTeclado[si], "r" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "i" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "p" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "t" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "o" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "n" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "g" 
                        jne esOtro
                        inc si 
                        cmp entradasTeclado[si], "o" 
                        jne esOtro
                        inc si 
                        clasificarTriptongo leido
                        xor ax,ax
                        mov al, flagTriptongo
                        CALL PRINT
                        call impsalto
                        jmp leer  
                colorear:
                    imprimir leido, 8FH
                    call impsalto
                    jmp leer
        esD: 
            cmp entradasTeclado[si], "d" 
            jne esH
            inc si
            cmp entradasTeclado[si], "i" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "p" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "t" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "n" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "g" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "_" 
            jne esOtro
            inc si
            leerPalDip:
            cmp entradasTeclado[si], 24H ;$
            je salirLeerPalDip
            mov al , entradasTeclado[si]
            mov palabra[si-9],al
            inc si
            jmp leerPalDip
            salirLeerPalDip:                                          
                mov al, 24H
                mov palabra[si-9],al
                imprimir palabra, 03H 
                call impsalto
                clasificarDiptongo palabra
                clasificarDiptongoPrint
                call impsalto
                jmp leer 
        esH: 
            cmp entradasTeclado[si], "h" ;Letra h
            jne esPe
            inc si
            cmp entradasTeclado[si], "i" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "a" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "t" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "_" 
            jne esOtro
            inc si
            leerPalHiato:
            cmp entradasTeclado[si], 24H ;$
            je salirLeerPalHiato
            mov al , entradasTeclado[si]
            mov palabra[si-6],al
            inc si
            jmp leerPalHiato
            salirLeerPalHiato:                                          
                mov al, 24H
                mov palabra[si-6],al
                imprimir palabra, 03H 
                call impsalto
                clasificarHiato palabra
                clasificarHiatoPrint
                jmp leer
        esPe: 
            cmp entradasTeclado[si], "p" 
            jne esR
            inc si
            cmp entradasTeclado[si], "r" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "p" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "_" 
            jne esOtro
            inc si
            imprime msjProp
            call impsalto
            jmp leer
        esR: 
            cmp entradasTeclado[si],"r"
            jne esT
            inc si
            cmp entradasTeclado[si], "e"  
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "p" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "r" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "t" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "e" 
            jne esOtro
            inc si 
            imprimir msjRept, 0BH
            call impsalto
            crearArchivo reportname
            call impsalto
            jmp leer
        esT: 
            cmp entradasTeclado[si], "t" ;Letra t
            jne esX
            inc si
            cmp entradasTeclado[si], "r" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "i" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "p" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "t" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "n" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "g" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "o" 
            jne esOtro
            inc si 
            cmp entradasTeclado[si], "_" 
            jne esOtro
            inc si
            leerPalTrip:
            cmp entradasTeclado[si], 24H ;$
            je salirLeerPalTrip
            mov al , entradasTeclado[si]
            mov palabra[si-10],al
            inc si
            jmp leerPalTrip
            salirLeerPalTrip:                                          
                mov al, 24H
                mov palabra[si-10],al
                clasificarTriptongo palabra
                clasificarTriptongoPrint

                jmp leer
        esX: 
            cmp entradasTeclado[si], 78H ;4
            jne esXmay
            mov banderaactivo, 0
            inc si
            jmp analizarEntrada
        esXmay: 
            cmp entradasTeclado[si], 58H ;4
            jne esDolar
            mov banderaactivo, 0
            inc si
            jmp analizarEntrada
        esDolar:
            cmp entradasTeclado[si], 24H ;$
            jne esOtro
            inc si
            je salirpedir; aqui debe ir lo demas 
        esOtro: 
            imprimir errorComand,0CH
            call impsalto
            jmp leer
        salirpedir:
endm

