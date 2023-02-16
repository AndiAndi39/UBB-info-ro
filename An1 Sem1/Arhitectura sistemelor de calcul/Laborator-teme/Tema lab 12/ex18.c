///Se citeste de la tastatura un sir de numere in baza 10 fara semn.
///Sa se determine valoarea minima din sir si sa se afiseze in fisierul min.txt (fisierul va fi creat) valoarea minima, in baza 16

#include<stdio.h>
#include<limits.h>

int sir[1000];
int count = 0;
int main()
{
    int x=1,m=INT_MAX;
    while(x!=0)
    {
        printf("Introduceti un numar(0 pentru stop): ");
        scanf("%d",&x);
        sir[count] = x;
        count++;
    }
    count--;
    m = valoare_minima(sir,count);

    FILE *fptr = fopen("min.txt", "w");
    if (fptr == NULL)
    {
        printf("Nu s-a putut deschide");
        return 0;
    }
    fprintf(fptr, "%d", 1, m);
    fclose(fptr);

    return 0;
}

int valoare_minima(int a[],int count)
{
    int m = INT_MAX;
    for(int i=0;i<count;i++)
    {
        if(sir[i]<m)
        {
            m = sir[i];
        }
    }
    return m;
}
