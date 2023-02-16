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
    b DW 20
    c DD 30
    d DQ 40
    rez RESQ 1
; our code starts here
; Sabo Andrei Claudiu
; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; a-d+b+b+c
segment code use32 class=code
    start:
        ; ...
        mov al, [a]
        cbw
        cwde
        cdq         ; edx:eax = a

        add eax, dword[d]
        adc edx, dword[d+4] ; edx:eax = a-d
        
        mov ebx, eax
        mov ecx, edx        ; ecx:ebx = a-d
        
        mov ax,[b]
        cwde
        cdq
        
        add ebx, eax    
        adc ecx, edx    ; ecx:ebx = a-d+b
        
        add ebx, eax
        adc ecx, edx    ; ecx:ebx = a-d+b+b
        
        mov eax,[c]
        cdq
        
        add ebx, eax
        adc ecx, edx    ; ecx:ebx = a-d+b+b+c
        
        mov dword[rez], ebx
        mov dword[rez+4], ecx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
