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
    b DB 25
    c DB 5
    d DW 90
    rezultat RESB 1
; Sabo Andrei Claudiu
; a,b,c - byte, d - word
; [(10+d)-(a*a-2*b)]/c
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov DX,[d]
        add DX,10
        
        mov AL,[a]
        mov BL,[a]
        mul BL
        
        sub DX,AX
        
        mov AL,[b]
        mov BL, 2
        mul BL
        
        add DX,AX
        
        mov AX,DX
        mov BL,[c]
        div BL
        
        mov [rezultat],AL
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
