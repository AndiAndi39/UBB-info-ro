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
    a DW 0111011101010111b
    b DD 0
; our code starts here
; Se da cuvantul A. Sa se formeze doublewordul B in felul urmator:
; bitii 0-3 ai lui B sunt bitii 1-4 ai rezultatului A XOR 0Ah
; bitii 4-11 ai lui B sunt bitii 7-14 ai lui A
; bitii 12-19 ai lui B au valoarea 0
; bitii 20-25 ai lui B au valoarea 1
; bitii 26-31 ai lui C sunt bitii 3-8 ai lui A complementati    ???
segment code use32 class=code
    start:
        ; ...
        mov ebx,0   ; in registrul ebx punem rezultatul
        
        mov eax, 0
        mov ax, [a]
        mov cx, 0Ah
        xor eax, cx  ; in eax avem rezultatul dintre A XOR 0Ah 
                     ; => pozitiile 1-4 sunt 17-20
        
        mov cl,17
        rol eax cl  ; rotim spre stanga
        
        and eax, 11110000000000000000000000000000b  ; raman pastrati doar primii 4 biti
        
        or ebx,eax  ; punem biti in rezultat
        
        mov eax,0
        mov ax,[a]  ; stocam in eax A
                    ; => pozitiile 7-14 sunt 23-30
                    
        mov cl,19          
        rol eax,cl  ; rotim spre stanga
        
        and eax, 00001111111100000000000000000000b  ; raman pastrati doar bitii de pe pozitiile 4-11
        
        or ebx,eax ; punem bitii in rezultat
        
        or ebx, 00000000000000000000111111000000b  ; punem 1 pe bitii 20-25
        
        mov eax,0
        mov ax,[a]  ; stocam in eax A
                    ; => pozitiile 3-8 sunt 19-24
        
        not eax     ; inversam bitii din eax
        
        mov cl,23
        ror eax,cl    ; rotim spre dreapta
        
        and eax, 00000000000000000000000000111111b  ; raman pastrati doar bitii de pe pozitiile 26-31
        
        or ebx, eax ; punem bitii in rezultat
        
        mov [b],ebx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
    