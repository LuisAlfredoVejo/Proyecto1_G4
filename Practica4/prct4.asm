include prct4m.asm
include prct4m2.asm
.model small
.stack 128
.data
    ap dw 0 ;apuntador de palabra de leido
    ap1 dw  0 ;apuntador de palabra de string
    banderaactivo dw 0
    blankspace db " ",'$'
    counter dw 0
    counterwords db 0
    entradasTeclado db  ?
    entradasTeclad2 db  100 dup('$')
    errorComand db "Error al ingresar comando",'$'
    errorarch db "Error al crear archivo",'$'
    filename db "Prueba.txt",0

    flagDiptongo db 0
    flagcreciente db 0
    flagdecreciente db 0
    flaghomogeneo db 0
    flagHiato db 0
    flagacentual db 0
    flagsimple db 0
    flagTriptongo db 0
    handle dw 0
    handlerep dw 0
    headuniversidad db "    Universidad de San Carlos de Guatemala",'$'
    headACE1 db "    Arquitectura de computadores y ensambladores 1",'$'
    headnombrecarne db "    Josu",82h," Daniel Caal Torres 201408473",'$'
    headprct4 db "    Pr",0A0h,"ctica 4",'$'
    headcerrar db "    Ingrese x si desea cerrar el programa",'$'
    leido db 1023 dup("$"),'$'
    leidorep db 1023 dup("$"),'$'
    msjcrear db "Archivo creado",'$'
    msjerrorabrir db "Error al abrir ", '$'
    msjerrorcerrar db "Error al cerrar archivo", '$'
    msjabierto db "Archivo abierto:  ", '$'
    msjNoTXT db "No es .txt, la extensi",0A2h,"n es: ",'$'
    msjCanti db "    Cantidad: ",'$'
    msjDipt db "Diptongo: ", '$'
    msjHiato db "Hiato: ",'$'
    msjTript db "Triptongo: ", '$'
    msjProp db "    Proporci",0A2H,"n: ",'$'
    msjRept db "Generando reporte",'$'
    nochar db " ",'$'
    numero db 0,0,0,'$'
    numeros db "123456789",'$'
    pedircom db "Ingrese comando: ",'$'
    random db "^",'$'
    reportname db "reporte.txt",0
    palabra db 64 dup("$")
    palabrapala db " palabras",'$'
    path db 64 dup(0) 
    percent db "%",'$'
    propdiptongo db 0
    prophiato db 0
    proptriptongo db 0
    signos db "=|-#",'$'
    textosalir db "Termin",0A2h," la ejecuci",0A2h,"n",'$'
    textoreporte db "Diptongo",13,10,"    Cantidad:    ",13,10,"    Proporcion:  %",13,10,"Hiato",13,10,"    Cantidad:    ",13,10,"    Proporcion:  %",13,10,"Triptongo",13,10,"    Cantidad:    ",13,10,"    Proporcion:  %",'$' 
    diptongo db "ia ie io ua ue uo ai au ei eu oi ou iu ui",'$'
    hiato db "aí aú eí eú oí oú ía íe ío úa úe úo aa ee ii oo uu ae ao ea eo oa oe",'$'
    triptongo db "iai ieu iei ieu ioi iou uai uau uei ueu uoi uou",'$'
    esdipt db "es diptongo",'$'
    esDecreciente db "es decreciente",'$'
    esCreciente db "es creciente",'$'
    esHomogeneo db "es homogeneo",'$'
    estript db "es triptongo",'$'
    esHiato db "es hiato",'$'
    esSimple db "es simple",'$'
    esAcentu db "es asentual",'$'
    noes db "No es ",'$'


.code

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

    NOPRINT PROC             
        ;initialize count
        mov numero[1], 0
        mov numero[1], 0
        mov cx,0
        mov dx,0
        NOlabel1:
            cmp ax,0
            je NOprint1                
            mov bx,10                  
            div bx                         
            push dx                       
            inc cx                       
            xor dx,dx
            jmp NOlabel1
        NOprint1:
            cmp cx,0
            je exitN     
            mov bx,3 
            sub bx,cx    
            pop dx
            add dx,48    
            mov numero[bx] , dl          
            dec cx
            jmp NOprint1
        exitN:
        ret
    NOPRINT ENDP

    impsalto proc

        mov ah,02h
        mov dl,0dh ;retorno de carro
        int 21h
        mov ah,02h
        mov dl,0ah ;salto de línea
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