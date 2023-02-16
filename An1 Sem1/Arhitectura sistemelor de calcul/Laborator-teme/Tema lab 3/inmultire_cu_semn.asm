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
    b DB 10
    c DW 20
    e DD 30
    x DQ 40
; our code starts here
; Sabo Andrei Claudiu
; (a-b+c*128)/(a+b)+e-x; a,b-byte; c-word; e-doubleword; x-qword

segment code use32 class=code
    start:
        ; ...
        mov ax, [c]
        mov bx, 128
        imul bx         ; dx:ax = c*128
        
        mov bx,ax
        mov cx,dx       ; cx:bx = c*128
        
        mov al,[a]
        cbw             ; ax = a
        
        add bx,ax
        adc cx,0        ; cx:bx = a+c*128
        
        mov dx,ax       ; dx = a
        
        mov al,[b]
        cbw             ; ax = b
        
        sub bx,ax
        sbb cx,0        ; cx:bx = a-b+c*128
        
        add dx,ax       ; dx = a+b
        
        mov ax,bx
        mov bx,dx       ; bx = a-b
        mov dx,cx       ; dx:ax = a-b+c*128
        
        idiv bx         ; ax = (a-b+c*128)/(a+b)
        
        cwde            ; eax = (a-b+c*128)/(a+b)
        
        add eax,[e]     ; eax = (a-b+c*128)/(a+b)+e
        
        cdq             ; edx:eax = (a-b+c*128)/(a+b)+e
        
        sub eax,dword[x]
        sbb edx,dword[x+4]  ;?????????
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
