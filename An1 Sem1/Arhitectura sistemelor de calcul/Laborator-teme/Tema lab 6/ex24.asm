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
    sir DD 10,10,11,11,11,10,3  ; sirul de dublucuvinte
    len equ ($-sir)/4       ; lungimea sirului
    rez times len DD 0  ; sirul rezultat

; Sabo Andrei Claudiu
; Dandu-se un sir de dublucuvinte, sa se obtina un alt sir de dublucuvinte in care se vor pastra doar dublucuvintele din primul sir care au un numar par de biti cu valoare 1.
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, len        ; loop ul se executa de len ori
        jecxz end_program
        
        mov esi, sir        ; setam sirul sursa
        mov edi, rez        ; setam sirul destinatie
        
        mov edx, 0
        cld
        repeta:
            lodsd       ; avem nr in eax
            mov ebx, eax    ; punem numarul in ebx, sa nu modificam eax cand facem operatiile
            
            push ecx        ; punem ecx pe stiva sa nu il modificam
            
            mov ecx, 32       ; o sa facem shr de 32 de ori, fiecare bit merge in CF si in edx contorizam cati biti de 1 sunt
            mov edx, 0
            nr_biti:
                shr ebx, 1
                adc edx, 0
            loop nr_biti
            
            pop ecx         ; luam ecx de pe stiva
            
            test edx, 1     
            
            jnz nr_impar_de_biti    ; daca nr are nr impar de biti 1 nu il punem in rezultat
                
            stosd
            
            nr_impar_de_biti:
            
        loop repeta
        
        end_program:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
