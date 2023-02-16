bits 32

global get_len, sufix_comun

segment code use32 class=code
    get_len:
    
        mov eax, [esp+4]
        mov edx, 0
        
        .bucla
            cmp byte[eax], 0
            je .final
            mov bx, [eax]
            inc eax
            inc edx
        loop .bucla
        
        .final:
        
        ret 4*1
        
    sufix_comun:
        ; Stiva:
        ; esp - revenire
        ; esp + 4 - [len2]
        ; esp + 8 - [len1]
        ; esp + 12 - sir2
        ; esp + 16 - sir1
        ; esp + 20 - s12
        
        mov esi, [esp+16]   ; in ESI punem offsetul sirului 1 
        mov edi, [esp+12]   ; in EDI punem offsetul sirului 2
        mov eax, [esp+8]    ; in eax punem valoarea variabilei len1
        mov ebx, [esp+4]    ; in ebx punem valoarea variabilei len2
        
        
        .bucla:                         ; Facem o bucla in care o sa luam in ordine inversa elementele celor 2 siruri si o se le comparam
            mov ch, [esi+eax-1]         ; salvam in ch ultimul element al sirului 1
            mov cl, [edi+ebx-1]         ; salvam in cl ultimul element al sirului 2
            
            cmp ch,cl                   ; comparam elementele
            jne .final                  ; daca nu sunt egale putem iesi din bucla
            cmp eax, 0                  ; daca un sir ramane fara elemente ne oprim
            je .final
            cmp ebx, 0
            je .final
            
            dec eax                     ; decrementam eax si ebx
            dec ebx
        loop .bucla
                                        ; in eax si ebx ne raman pozitiitle de unde incepe cel mai lung subsir comun
        ;mov ebx, eax                    ; in ebx stocam punem pozitia de unde incepe sufixul
        .final:
         mov ecx, [esp+8]          
         mov edi, [esp+20]              ; punem in edi offsetul s12, acolo pastram sufixul
         add esi, eax                   ; in esi adaugam eax, astfel sirul incepe chiar de unde incepe cel mai lung suufix
         cld
        .loop:
            movsb                       ; mutam sufixul in sirul corespunzator
        loop .loop
        
        ret 4*5
        