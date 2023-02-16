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
    A db 2,1,3,-3
    lenA equ $-A     ; lenA retine lungimea sirului A
    B db 4,5,-5,7
    lenB equ $-B    ; lenB retine lungimea sirului B
    R times lenA+lenB db 0  ; spatiu rezervat pentru rezultat   
    
; our code starts here
; Sabo Andrei Claudiu
; Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R care sa contina doar elementele impare si pozitive din cele 2 siruri.
; Exemplu:
; A: 2, 1, 3, -3
; B: 4, 5, -5, 7
; R: 1, 3, 5, 7
segment code use32 class=code
    start:
        ; ...
        mov ecx, lenA   ; Punem in ecx lungimea sirului A pentru a folosi loop
        mov esi, 0      ; Folosim esi pentru a stoca numerele in rezultat
        jecxz sirul_b   ; Daca primul sir are lungimea 0 se trece la sirul al doilea
        mov edi, 0      ; Folosim edi pentru a parcurge sirul
        repeta_a:
            mov al,[A+edi]
            
            test al, 1b             
            jz nr_nu_este_bun_a     ; Daca numarul este par atunci numarul nu este bun
            
            test al, 10000000b
            jnz nr_nu_este_bun_a     ; Daca numarul este negativ atunci numarul nu este bun
            
            mov [R+esi],al          ; Stocam in rezultat numarul daca indeplineste conditiile
            inc esi
            nr_nu_este_bun_a:
            inc edi
        loop repeta_a
        
        mov ecx, lenB           ; analog pentru al doilea sir ca si la primul sir
        jecxz end_program
        mov edi, 0
        sirul_b:
            repeta_b:
            mov al,[B+edi]
            
            test al,1b
            jz nr_nu_este_bun_b
            
            test al, 10000000b
            jnz nr_nu_este_bun_b
            
            mov [R+esi],al
            inc esi
            nr_nu_este_bun_b:
            inc edi
        
        loop repeta_b
        
    end_program:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
