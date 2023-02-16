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
    b DW 30
    c DD 50
    d DQ 1000000
    rez RESQ 1

; our code starts here
; Sabo Andrei Claudiu
; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
; (d+d-b)+(c-a)+d
segment code use32 class=code
    start:
        ; ...
        mov eax, dword[d]
        mov edx, dword[d+4] ; edx:eax = d
        
        add eax, dword[d]
        adc edx, dword[d+4] ; edx:eax = d+d
        
        mov ebx, 0
        mov bx, [b]
        mov ecx, 0 ; ecx:ebx = b
        
        sub eax, ebx
        sbb edx, ecx ; edx:eax = d+d-b
        
        add eax, [c]
        adc edx, ecx ; edx:eax = d+d-b+c
        
        mov ebx, 0
        mov bl, [a] ; ecx:ebx = a
        
        sub eax, ebx
        sbb edx, ecx ; edx:eax = (d+d-b)+(c-a)+d
        
        add eax, dword[d]
        adc edx, dword[d+4]
        
        mov dword[rez], eax
        mov dword[rez+4], edx
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
