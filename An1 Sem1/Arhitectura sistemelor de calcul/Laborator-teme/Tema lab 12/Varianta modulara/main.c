/*++
Se cere un program C care apeleaza functia sumaNumere scrisa in limbaj de asamblare. Aceasta functie primeste
ca parametri doua numere naturale citite in programul C, calculeaza suma lor si transmite aceasta valoare ca rezultat.
Programul C va afisa suma calculata de functia sumaNumere
--*/


#include <stdio.h>

int valoare_minima(int sir[], int a);

int main()
{
    
    int sir[1000];
    int count = 0;
    int x=1;
    int m;
    while(x!=0)
    {
        printf("Introduceti un numar(0 pentru stop): ");
        scanf("%d",&x);
        sir[count] = x;
        count++;
    }
    count--;
    m = valoare_minima(sir, count);

    printf("%d", m);
    FILE *fptr = fopen("min.txt", "w");
    if (fptr == NULL)
    {
        printf("Nu s-a putut deschide");
        return 0;
    }
    fprintf(fptr, "%d", m);
    fclose(fptr);

    return 0;
}