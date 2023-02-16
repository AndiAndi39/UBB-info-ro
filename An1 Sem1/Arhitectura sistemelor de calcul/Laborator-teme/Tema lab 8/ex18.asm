bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    msg db "Introduceti un numar in baza 10:",0
    format1 db "%d",0
    n1 dd 0
    msg2 db "Introduceti un numar in baza 16:",0
    format2 db "%x",0
    n2 dd 0
    msg3 db "Rezultatul are %d biti",0
    
    ; Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
; a = 32 = 0010 0000b
; b = 1Ah = 0001 1010b
; 32 + 1Ah = 0011 1010b
; Se va afisa pe ecran valoarea 4.
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword msg  ; Afisam mesaj pentru citire
        call [printf]
        add esp, 4*1
        
        push dword n1       ; Se citeste n1 in baza 10
        push dword format1
        call [scanf]
        add esp, 4*2
        
        ; push dword [n1]     
        ; push dword format1
        ; call [printf]
        ; add esp, 4*2
        
        push dword msg2     ; Afisam mesaj pentru citire
        call [printf]
        add esp, 4*1
        
        push dword n2       ; Se citeste n2 in baza 16
        push dword format2
        call [scanf]
        add esp, 4*2
        
        mov eax, [n1]
        add eax, [n2]
        
        mov ecx, 32
        mov edx, 0
        nr_biti:
            push ecx
            
            mov cl, 1   
            shr eax, cl
            adc edx, 0
            pop ecx
        loop nr_biti
        
        
        push dword edx
        push dword msg3
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
