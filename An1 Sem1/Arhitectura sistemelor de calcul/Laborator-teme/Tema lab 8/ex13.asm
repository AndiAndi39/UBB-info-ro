bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf, fprintf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    nume_fisier db "text.txt", 0    ; numele fisierului
    descriptor dd -1
    mod_acces db "r", 0
    
    len equ 100
    text times len db 0         ; variabila pentru textul din fisier
    
    nume_fisier_scriere db "text2.txt" , 0  ;  numele fisierului de scriere a textului
    descriptor2 dd -1
    mod_acces2 db "w", 0
    
    format_afisare db "%s", 0   ; folosim pentru a verifica daca codul functioneaza
    
;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se transforme toate literele mici din textul dat in litere mari. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        push dword mod_acces            ; Deschidem fisierul pentru a citi textul din el
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax           ; Salvam valoare din eax (descriptorul fisierului)
        
        cmp eax, 0
        je final
        
        push dword [descriptor]         ; Citim sirul din fisier, si memoram sirul in 'text'
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        push dword [descriptor]         ; Inchidem fisierul
        call [fclose]
        add esp, 4*1
        
        ; push dword text                 ; Afisam textul pentru verificare
        ; push dword format_afisare
        ; call [printf]
        ; mov esp, 4*2
        
        mov ecx, len
        mov edx, 0
        parcurgere_caractere:           ; Facem un loop care parcurge toate caracterele din 'text'
        
            mov bl, [text+edx]
            cmp bl, 97
            jl caracterul_nu_e_litera_mica
            cmp bl, 122
            jg caracterul_nu_e_litera_mica
            
            sub bl, 32
            mov [text+edx], bl
            
            caracterul_nu_e_litera_mica:
            inc edx
        loop parcurgere_caractere
        
        ; push dword text                 ; Afisam textul pentru verificare
        ; push dword format_afisare
        ; call [printf]
        ; mov esp, 4*2
        
        push dword mod_acces2
        push dword nume_fisier_scriere
        call [fopen]
        add esp, 4*2
        
        mov [descriptor2], eax          ; Salvam valoarea din eax (descriptorul fisierului)
        
        cmp eax, 0
        je final
        
        push dword text
        push dword [descriptor2]
        call [fprintf]
        add esp, 4*2
        
        push dword [descriptor2]
        call [fclose]
        add esp, 4*1
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
