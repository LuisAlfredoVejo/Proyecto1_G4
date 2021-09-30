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

imprimir macro cadena, color
    mov ah, 09h ;Tipo de operacion de 21h muestra caracteres, basicamente print
    mov bl, color ;Color del texto de salida
    mov cx, lengthof cadena - 1 ;Pintar el texto en su totalidad
    int 10h ;Interrupcion para dar color
    lea dx, cadena ;Mostrando la cadena
    int 21h ;Interrupcion para mostrar
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
    local leer,esA,esCe,esD,esH,esPe,esR,esT,esX,esXmay,esDolar,esOtro,salirpedir
    leer:
    imprimir pedircom,0EH
    call impsalto
        xor si,si
        leerHastaEnter entradasTeclado
        call impsalto
        analizarEntrada:
        cmp si,lengthof entradasTeclado
        esA:
            je salirpedir
            cmp entradasTeclado[si], 61H ;Letra a
            jne esCe
            inc si         
            cmp entradasTeclado[si], 62H ;Letra b
            jne esOtro
            inc si 
            cmp entradasTeclado[si], 72H ;Letra r
            jne esOtro
            inc si 
            cmp entradasTeclado[si], 69H ;Letra i
            jne esOtro
            inc si 
            cmp entradasTeclado[si], 72H ;Letra r
            jne esOtro
            inc si 
            cmp entradasTeclado[si], 5FH ;signo_
            jne esOtro
            mov cx, 5
            xor di,di
            ; mov si, 5
            bucleprueba:
                inc si
                imprime entradasTeclado
                ; mov al , entradasTeclado[si]
                mov al , "p"
                mov path[si],al
                call impsalto
                imprime path
                call impsalto
                loop bucleprueba
                call impsalto
                mov path[si],"$"
                imprime path
                call impsalto
                dec si
            ;jmp salirpedir ;
            jmp leer
        esCe: 
            cmp entradasTeclado[si], 63H ;Letra c
            jne esD
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
        esD: 
            cmp entradasTeclado[si], 64H ;Letra d
            jne esH
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
        esH: 
            cmp entradasTeclado[si], 68H ;Letra h
            jne esPe
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
        esPe: 
            cmp entradasTeclado[si], 66H ;Letra f
            jne esR
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
        esR: 
            cmp entradasTeclado[si], 72H ;Letra r
            jne esT
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
        esT: 
            cmp entradasTeclado[si], 74H ;Letra t
            jne esX
            je salirpedir; aqui debe ir lo demas 
            inc si
            jmp analizarEntrada 
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

