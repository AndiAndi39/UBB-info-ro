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
    b DB 20 
    c DB 30
    d DB 40
    rezultat RESB 1
; our code starts here
; Sabo Andrei Claudiu
; a,b,c,d - byte
; (a+b+b)-(c+d)
segment code use32 class=code
    start:
        ; ...
        mov AL, [a]
        add AL, [b]
        add AL, [b]
        mov BL, [c]
        add BL, [d]
        sub AL,BL
        mov [rezultat], AL
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
