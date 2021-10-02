include prct4m.asm
.model small
.stack 128
.data
    banderaactivo dw 0
    blankspace db " ",'$'
    counter dw 0
    entradasTeclado db  ?
    entradasTeclad2 db  100 dup('$')
    errorComand db "Error al ingresar comando",'$'
    headuniversidad db "    Universidad de San Carlos de Guatemala",'$'
    headACE1 db "    Arquitectura de computadores y ensambladores 1",'$'
    headnombrecarne db "    Josu",82h," Daniel Caal Torres 201408473",'$'
    headprct4 db "    Pr",0A0h,"ctica 4",'$'
    headcerrar db "    Ingrese x si desea cerrar el programa",'$'
    msjcrear db "Archivo creado",'$'
    nochar db " ",'$'
    numeros db "123456789",'$'
    pedircom db "Ingrese comando: ",'$'
    random db "^",'$'
    path db 64 dup(0) 
    signos db "=|-#",'$'
    textosalir db "Termin",0A2h," la ejecuci",0A2h,"n",'$'
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

    programa proc
        mov banderaactivo, 1
        ciclogeneral:
        call limpiarTerminal
        encabezado
        call impsalto
        pedircomando
        cmp banderaactivo, 1
        je ciclogeneral
        imprimir textosalir,04H
        ret
    programa endp

    start:        
        mov ax, @data 
        mov ds, ax
        call limpiarTerminal
        call programa
        mov ax,4C00h
        INT 21H
    end  start