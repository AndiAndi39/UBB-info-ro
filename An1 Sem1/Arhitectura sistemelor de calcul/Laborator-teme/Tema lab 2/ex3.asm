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
    a DW 20
    b DW 100
    c DW 10
    d DW 5
    rezultat RESW 1
; our code starts here
; Sabo Andrei Claudiu
; a,b,c,d - word
; (b-a)-(c+c+d) 
segment code use32 class=code
    start:
        ; ...
        mov AX,[b]
        sub AX,[a]
        sub AX,[c]
        sub AX,[c]
        sub AX,[d]
        mov [rezultat],AX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
