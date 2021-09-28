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
    xor si,si
    imprimir pedircom,0EH
    call impsalto
    pedircasilla:
        leerHastaEnter entradasTeclado
        analizarEntrada:
        cmp si, lengthof entradasTeclado
        je salirpedir
        cmp entradasTeclado[si], 61H ;Letra a
        je salirpedir
        jne esCe
        jmp analizarEntrada
        esCe: 
            cmp entradasTeclado[si], 63H ;Letra c
            jne esD
            inc si
            jmp analizarEntrada 
        esD: 
            cmp entradasTeclado[si], 64H ;Letra d
            jne esH
            inc si
            jmp analizarEntrada 
        esH: 
            cmp entradasTeclado[si], 68H ;Letra h
            jne esPe
            inc si
            jmp analizarEntrada 
        esPe: 
            cmp entradasTeclado[si], 46H ;Letra F
            jne esR
            inc si
            jmp analizarEntrada 
        esR: 
            cmp entradasTeclado[si], 47H ;Letra G
            jne esT
            inc si
            jmp analizarEntrada 
        esT: 
            cmp entradasTeclado[si], 48H ;Letra H
            jne esX
            inc si
            jmp analizarEntrada 
        esX: 
            cmp entradasTeclado[si], 78H ;4
            jne esOtro
            imprimir textosalir,04H
            mov banderaactivo, 0
            inc si
            jmp salirpedir
        esOtro: 
            imprimir errorComand,0CH
            call impsalto
            xor si, si
            jmp pedircasilla
    salirpedir:
endm
