bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a DB 10
    b DB 10
    c DW 20
    e DD 30
    x DQ 40 
    rez RESQ 1
; our code starts here
; Sabo Andrei Claudiu
; (a-b+c*128)/(a+b)+e-x; a,b-byte; c-word; e-doubleword; x-qword
segment code use32 class=code
    start:
        ; ...
        mov ax, [c]
        mov bx, 128
        mul bx      ; dx:ax = c*128
        
        mov cx, 0 
        mov cl, [a] ; cx = a
        
        add ax,cx
        adc dx,0    ; dx:ax = a+c*128
        
        mov cl,[b]  ; cx = b
        
        sub ax,cx
        sbb dx,0    ; dx:ax = a-b+c*128
        
        add cl,[a]  ; cx = a+b
        
        div cx      ; ax = (a-b+c*128)/(a+b)
        
        mov ebx, 0
        mov bx, ax   ; ebx = (a-b+c*128)/(a+b)
        
        add ebx,[e] ; ebx = (a-b+c*128)/(a+b)+e
        
        mov ecx,0   ; ecx:ebx = (a-b+c*128)/(a+b)+e
        
        sub ebx, dword[x]
        sbb ecx, dword[x+4] ; ecx:ebx = (a-b+c*128)/(a+b)+e-x ;????????
        
        mov dword[rez], ebx
        mov dword[rez+4], ecx   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
