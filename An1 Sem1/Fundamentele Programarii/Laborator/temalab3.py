import math

def print_menu():
    """
    Functie de printare meniu
    """
    print("\n1 - Citirea unei liste de numere intregi")
    print("2 - Gasirea secventei de lungime maxima care contine doar numere prime")
    print("3 - Gasirea secventei de lungime maxima care contine ... ")
    print("4 - Iesire")
    print("5 - Secventa de suma maxima \n")

def read_command():
    """
        Functia de citire a unei comenzi
    """
    return int(input("Introduceti o comanda: "))

def read_list():
    """
        Functia de citire a unei liste
    """
    the_initial_list = input("Introduceti o lista: ")
    list_of_string = the_initial_list.split(" ")
    the_final_list = [int(el.strip()) for el in list_of_string]

    return the_final_list
    
def prime(nr):
        """
            Aceasta functie verifica daca un numar este prim
        """
        div = 2
        while div < nr and nr%div > 0:
            div += 1
        return div >= nr

def sequence_prime(list):
    """
        Aceasta functie determina secventa maxima de numere prime
    """
    current_sequence = 0
    max_sequence = -1
    current_start = 0
    for el in range(0, len(list)):
        if prime(list[el]) == True:
            current_sequence += 1
        else:
            current_sequence = 0
            current_start = el
        if current_sequence > max_sequence:
            max_sequence = current_sequence
            start = current_start
            stop = el
    print("Lungimea maxima a unei secvente de numere prime este de: ", max_sequence)
    if max_sequence != 0:
        print("Incepe pe pozitia: ", start+1)
        print("Se termina pe pozitia: ", stop+1)

def compare(a,b):
    """
    Functie care compara 2 numere
    """
    if a >= b:
        return True
    return False
    # return a>=b

def second_sequence(list):
    """
        Se cauta secventa de lungime maximă cu proprietatea:
         p=1 sau diferentele (x[j+1] - x[j]) si (x[j+2] - x[j+1]) au semne contrare,
            pentru j=i..i+p-2.
    """
    previous_comparasion = compare(list[0],list[1])
    current_sequence = 1
    max_sequence = -1
    for el in range(2, len(list)):
        current_comparasion = compare(list[el-1],list[el])
        #print (current_comparasion, previous_comparasion)
        if previous_comparasion != current_comparasion:
            current_sequence += 1
        else:
            current_sequence = 1
        if current_sequence > max_sequence:
            max_sequence = current_sequence
        previous_comparasion = current_comparasion
    print("Secventa de lungime maxima care respecta proprietatea este de: ", max_sequence + (max_sequence != 1))

def sum_sequence(list):
    current_sum = 0
    max_sum = -1000
    current_start = 0
    for el in range(0,len(list)):
        if current_sum >= 0:
            current_sum += list[el]
        else:
            current_sum = list[el]
            current_start = el 
        if current_sum > max_sum:
            max_sum = current_sum
            start = current_start
            stop = el
    print("Subsecventa de suma maxima are suma: ", max_sum)
    print("Incepe pe pozitia: ", start+1)
    print("Se termina pe pozitia: ", stop+1)

def main():
    """
        Functia principala
    """
    while True:
        print_menu()
        option = read_command()
        if option == 1:
            list = read_list()
        elif option == 2:
            sequence_prime(list)
        elif option == 3:
            second_sequence(list)
        elif option == 4:
            print("Sfarsit")
            break
        elif option == 5:
            sum_sequence(list)

main()