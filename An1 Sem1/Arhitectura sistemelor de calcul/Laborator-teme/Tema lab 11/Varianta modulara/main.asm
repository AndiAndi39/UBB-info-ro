bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf 
extern get_len, sufix_comun              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mesaj db "Introduceti un sir de caractere: ", 0  ; mesaj
    format_sir db "%s",0    ; format pentru sir
    format_afisare db "%s",10,13,0    ; format de afisare cu '\n'
    f db "%d", 0                            ; format pentru numar
    
    max equ 100                             ; lungimea maxima a unui sir
    sir1 times max db 0
    sir2 times max db 0
    sir3 times max db 0
    
    len1 dd 0                               ; variabile in care memoram lungimea fiecarui sir
    len2 dd 0
    len3 dd 0
    
    s12 times max db 0
    s23 times max db 0
    s31 times max db 0
    
    ; ...

; our code starts here
; Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
; Sabo Andrei Claudiu
segment code use32 class=code
    start:
        ; ...
        push dword mesaj
        push dword format_sir
        call [printf]
        add esp, 4*2
        
        push dword sir1                         ; Citim sirul 1 
        push dword format_sir
        call [scanf]
        add esp, 4*2
        
        push dword mesaj
        push dword format_sir
        call [printf]
        add esp, 4*2
        
        push dword sir2                        ; Citim sirul 2
        push dword format_sir
        call [scanf]
        add esp, 4*2
        
        push dword mesaj
        push dword format_sir
        call [printf]
        add esp, 4*2
        
        push dword sir3                        ; Citim sirul 3
        push dword format_sir
        call [scanf]
        add esp, 4*2
        
        push dword sir1
        call get_len
        mov [len1], edx
        
        push dword sir2
        call get_len
        mov [len2], edx
        
        push dword sir3                     ; Aflam lungimea fiecarui sir, iar rezultatele se pastreaza in varibilele len
        call get_len
        mov [len3], edx
        
        push dword s12                      ; Pentru fiecare pereche de siruri se apeleaza functia si se scrie apoi rezultatul
        push dword sir1
        push dword sir2
        push dword [len1]
        push dword [len2]
        call sufix_comun
        
        push dword s12
        push dword format_afisare
        call [printf]
        add esp, 4*2
        
        push dword s23
        push dword sir2
        push dword sir3
        push dword [len2]
        push dword [len3]
        call sufix_comun
        
        push dword s23
        push dword format_afisare
        call [printf]
        add esp, 4*2
        
        push dword s31
        push dword sir3
        push dword sir1
        push dword [len3]
        push dword [len1]
        call sufix_comun
        
        push dword s31
        push dword format_afisare
        call [printf]
        add esp, 4*2
        
        ; sufixele se afiseaza fiecare pe alt rand pentru perechile (sir1,sir2),(sir2,sir3),(sir3,sir1)
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
