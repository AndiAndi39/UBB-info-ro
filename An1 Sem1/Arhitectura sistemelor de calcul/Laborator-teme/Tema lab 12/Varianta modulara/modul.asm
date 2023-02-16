bits 32

global _valoare_minima

segment data public data use32
    adresaSir dd 0
    minim dd -1
    format dd "%d",0
    
segment code public code use32

;int valoare_minima(int[], int)

_valoare_minima:
    ;creare cadru de stiva pentru programul  apelat
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov [adresaSir], eax    ; incarcam in [adresaSir] adresa sirului de numere
    
    mov ecx, [ebp + 12]     ; ecx va contine numarul de numere
    jecxz final
    
    cld
    mov esi, [adresaSir]    ; esi va contine adresa sirului de numere
    
    ; in bucla vom compara pe rand minimul si fiecare numarx
    bucla:
        lodsd
        
        cmp [minim], eax
        jb nr_nu_e_mai_mic
        
        mov [minim],eax
        
        nr_nu_e_mai_mic:
    loop bucla
    
    
    final:
    
    ; refacem cadrul de stiva pentru programul apelant
    mov esp, ebp
    pop ebp
    
    mov eax, [minim]
    
    ret