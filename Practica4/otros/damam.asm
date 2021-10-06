asignarCoordenada macro index, valor
mov bl, valor
mov proxcasilla[index], bl
endm

cerrarfich macro name
    mov ah,3eh   
    int 21h
endm

crearfich macro name, handle
    mov ah,3ch
    mov cx,00
    lea dx,name
    int 21h
    mov handle,ax
endm

dibujarTablero macro 
    local cabecerascolumnasloop,cabecerasfilasloop,casillasloop, lineasinicio, separadorfilasloop,finalfila,endloop
    mov indexI,0
    mov indexJ,0
    xor si, si
    imprimir space,0 ;Para  los espacios que separan la cabecera
    ;estos se pueden quitar si no queremos lineas al inicio
    imprimir space,0 
    imprimir space,0 
    imprimir space,0 
    ;estos se pueden quitar si no queremos lineas al inicio
    cabecerascolumnasloop:
        mov bl, cabecerasCol[si] ;
        mov nochar[0],bl ; este para asigna a nochar el valor de la cabecera en la posicion del contador
        imprimir nochar, 15   
        imprimir space,0
        imprimir space,0
        imprimir space,0
        inc si
        cmp si, 8d
        jnz cabecerascolumnasloop
        ;estos se pueden quitar si no queremos lineas al inicio
        call impsalto
        imprimir space,0
        imprimir space,0
        lineasinicio:
        mov bl,lineas[1]
        mov nochar[0],bl
        imprimir nochar,15
        inc indexI
        cmp indexI,33
        jnz lineasinicio
        ;estos se pueden quitar si no queremos lineas al inicio
        call impsalto
        xor si, si
        mov indexJ, 0
    cabecerasfilasloop:
        mov bl, cabecerasFil[si]
        mov nochar[0],bl  ; este para asigna a nochar el valor de la cabecera en la posicion del contador
        imprimir nochar,15
        imprimir space,0
        mov indexI, 0
        
        ;estos se pueden quitar si no queremos lineas al inicio
        mov bl,lineas[0]
        mov nochar[0],bl ; este para asigna a nochar | 
        imprimir nochar,15
        imprimir space,0
        ;estos se pueden quitar si no queremos lineas al inicio

        casillasloop:
            mov di, indexJ
            verificarValor tablero[di]
            inc indexJ
            imprimir nochar,color
            inc indexI
            cmp indexI, 8
            jz finalfila

            imprimir space, 0
            mov bl,lineas[0]
            mov nochar[0],bl
            imprimir nochar,15
            imprimir space,0
            jmp casillasloop
    finalfila:
        ;estos se pueden quitar si no queremos lineas al inicio
        imprimir space, 0
        mov bl,lineas[0]
        mov nochar[0],bl
        imprimir nochar,15
        ;estos se pueden quitar si no queremos lineas al inicio
        cmp si, 8  ;7 si no queremos linea abajo
        jz endloop
        mov indexI, 0
        call impsalto
        imprimir space,0
        imprimir space,0
    separadorfilasloop:
        mov bl,lineas[1]
        mov nochar[0],bl
        imprimir nochar,15
        inc indexI
        cmp indexI,33
        jnz separadorfilasloop
    endloop:
        call impsalto
        inc si 
        cmp si, 8
        jnz cabecerasfilasloop
endm

 escribirfich  macro name,  text, handle
    local nuevo, salir
    mov cx,1
    nuevo:  
        push cx
        mov ah,40h
        mov bx,handle
        mov cx,25
        lea dx,text
        int 21h
        pop cx
        loop nuevo
        mov ah,3eh
        mov bx,handle
        int 21h
    salir:  
endm

impchar macro char
    mov ah,02h
    mov dl,char 
    int 21h
    ret
endm
imprimir macro cadena, color
    mov ah, 09h ;Tipo de operacion de 21h muestra caracteres, basicamente print
    mov bl, color ;Color del texto de salida
    mov cx, lengthof cadena - 1 ;Pintar el texto en su totalidad
    int 10h ;Interrupcion para dar color
    lea dx, cadena ;Mostrando la cadena
    int 21h ;Interrupcion para mostrar
endm

imprimirnocolor macro cadena
    mov ah, 09h ;Tipo de operacion de 21h muestra caracteres, basicamente print
    lea dx, cadena ;Mostrando la cadena
    int 21h ;Interrupcion para mostrar
endm

iniciarjuego macro
    local menutag, fin
    mov nombre1, "#"
    menutag:
    inicio
    cmp nombre1[0], "#"
    jne fin
    call limpiarTerminal
    imprimir nonames,14
    call impsalto
    jmp menutag
    fin:
endm

inicio macro 
    local entrar, salir
    entrar:
    imprimirnocolor menu
    leerHastaEnter entradasTeclado
    cmp entradasTeclado[0],"1"
    jnz salir
    pedirnombres
    jmp entrar
    salir:
endm

iniciartablero macro
    mov tablero[0], 1 
    mov tablero[2], 1
    mov tablero[4], 1
    mov tablero[6], 1 
    mov tablero[9], 1
    mov tablero[11], 1
    mov tablero[13], 1
    mov tablero[15], 1
    mov tablero[16], 1
    mov tablero[18], 1
    mov tablero[20], 1
    mov tablero[22], 1
    mov tablero[41], 2 
    mov tablero[43], 2
    mov tablero[45], 2
    mov tablero[47], 2 
    mov tablero[48], 2
    mov tablero[50], 2
    mov tablero[52], 2
    mov tablero[54], 2
    mov tablero[57], 2
    mov tablero[59], 2
    mov tablero[61], 2
    mov tablero[63], 2
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

moverFicha macro
    mov di, proxcasillalin
    mov si, orgcasillalin
    mov al, tablero[si]
    mov tablero[di],al
    mov tablero[si],0
endm
pedirnombres macro
    call limpiarTerminal
    imprimirnocolor ingresenombre1
    leerHastaEnter nombre1
    imprimirnocolor  ingresenombre2
    leerHastaEnter nombre2
    call impsalto
    call impsalto
endm

pedirCoordenada macro
    local jugador2, pedircasilla, analizarEntrada, dospuntos, esB, esCe, esD, esE, esF, esG, esUno, esDos, esTres, esCuatro, esCinco, esSeis, esSiete, esOcho, esOtro, salirpedir
    xor si,si
    cmp banderajugador,1
    jne jugador2
    imprimirnocolor ingresecoor1
    jmp pedircasilla
    jugador2: 
    imprimirnocolor ingresecoor2
    pedircasilla:
        leerHastaEnter entradasTeclado
        analizarEntrada:
        cmp si, 5
        je salirpedir
        cmp si, 2
        jne dospuntos
        inc si
        je analizarEntrada
        dospuntos:
        cmp entradasTeclado[si], 41H ;Letra A
        jne esB
        asignarCoordenada si,0
        inc si
        jmp analizarEntrada
        esB:
            cmp entradasTeclado[si], 42H ;Letra B
            jne esCe
            asignarCoordenada si,1
            inc si
            jmp analizarEntrada 
        esCe: 
            cmp entradasTeclado[si], 43H ;Letra C
            jne esD
            asignarCoordenada si,2
            inc si
            jmp analizarEntrada 
        esD: 
            cmp entradasTeclado[si], 44H ;Letra D
            jne esE
            asignarCoordenada si,3
            inc si
            jmp analizarEntrada 
        esE: 
            cmp entradasTeclado[si], 45H ;Letra E
            jne esF
            asignarCoordenada si,4
            inc si
            jmp analizarEntrada 
        esF: 
            cmp entradasTeclado[si], 46H ;Letra F
            jne esG
            asignarCoordenada si,5
            inc si
            jmp analizarEntrada 
        esG: 
            cmp entradasTeclado[si], 47H ;Letra G
            jne esH
            asignarCoordenada si,6
            inc si
            jmp analizarEntrada 
        esH: 
            cmp entradasTeclado[si], 48H ;Letra H
            jne esUno
            asignarCoordenada si,7
            inc si
            jmp analizarEntrada 
        esUno: 
            cmp entradasTeclado[si], 31H ;1
            jne esDos
            asignarCoordenada si,0
            inc si
            jmp analizarEntrada 
        esDos: 
            cmp entradasTeclado[si], 32H ;2
            jne esTres
            asignarCoordenada si,1
            inc si
            jmp analizarEntrada 
        esTres: 
            cmp entradasTeclado[si], 33H ;3
            jne esCuatro
            asignarCoordenada si,2
            inc si
            jmp analizarEntrada 
        esCuatro: 
            cmp entradasTeclado[si], 34H ;4
            jne esCinco
            asignarCoordenada si,3
            inc si
            jmp analizarEntrada
            esCinco: 
            cmp entradasTeclado[si], 35H ;5
            jne esSeis
            asignarCoordenada si,4
            inc si
            jmp analizarEntrada 
        esSeis: 
            cmp entradasTeclado[si], 36H ;2
            jne esSiete
            asignarCoordenada si,5
            inc si
            jmp analizarEntrada 
        esSiete: 
            cmp entradasTeclado[si], 37H ;3
            jne esOcho
            asignarCoordenada si,6
            inc si
            jmp analizarEntrada 
        esOcho: 
            cmp entradasTeclado[si], 38H ;4
            jne esOtro
            asignarCoordenada si,7
            inc si
            jmp analizarEntrada  
        esOtro: 
            imprimirnocolor errorEnt
            xor si, si
            jmp pedircasilla
    salirpedir:
endm

verificarValor macro valor
    local cero, uno, dos, fin

    cmp valor, 0
    jz cero

    cmp valor, 1
    jz uno


    dos:
        mov color, 4
        mov nochar[0], "R"
        jmp fin

    uno:
        mov color, 15
        mov nochar[0], "B"
        jmp fin

    cero:
        mov color, 0d
        mov nochar[0], " "
    fin:
endm