"""
Creați o aplicație pentru gestiunea cheltuielilor lunare de la apartamentele unui
bloc de locuințe. Aplicația stochează cheltuielile pentru fiecare apartament:
suma și tipul cheltuielii (tip poate fi una dintre: apa, canal, încălzire, gaz, altele).
"""

from termcolor import colored
import datetime

class ExpenseError(Exception):
    pass

def generate_expenses():
    """
    Functia genereaza cheltuieli
    """
    return  [[9,"gaz",125,datetime.date(2020,1,5)],[12,"gaz",100,datetime.date(2019,1,5)],
    [12,"apa",200,datetime.date(2018,1,5)],[11,"apa",150,datetime.date(2020,10,5)],
    [11,"canalizare",50,datetime.date(2004,2,10)],
    [11,"gaz",400,datetime.date(2021,10,10)],[13,"apa",500,datetime.date(2019,5,10)]] 

def print_main():
    """
    Funcitia de printare a meniului principal
    """
    print("\n1 - Adaugare")
    print("2 - Stergere")
    print("3 - Cautari")
    print("4 - Rapoarte")
    print("5 - Flitru")
    print("6 - Undo")
    print("0 - Iesire din aplicatie")

def print_menu_1():
    """
    Functie de printare pentru meniul de adaugare
    """
    print("\n1 - Adauga cheltuiala pentru un apartament")
    print("2 - Modifica cheltuiala")
    print("0 - Inapoi")

def print_menu_2():
    """
    Functie de printare pentru meniul de stergere
    """
    print("\n1 - Stergeti toate cheltuielile a unui apartament")
    print("2 - Stergeti cheltuielile de la apartamente consecutive")
    print("3 - Stergetu cheltuielile de un anumit tip")
    print("0 - Inapoi")

def print_menu_3():
    """
    Functie de printare pentru meniul de cautari
    """
    print("\n1 - Tipareste toate apartamentele care au cheltuieli mai mari decat o suma")
    print("2 - Tipareste cheltuielile de un anumit tip de la toate apartamentele")
    print("3 - Tipareste toate cheltuielile efectuate inainte de o zi si mai mari decat o suma")
    print("0 - Inapoi")

def print_menu_4():
    """
    Functie de printare pentru meniul de rapoarte
    """
    print("\n1 - Tipareste suma totala pentru un tip de cheltuiala")
    print("2 - Tipareste toate apartamentele sortate dupa un tip de cheltuiala")
    print("3 - Tipareste totatul de cheltuieli pentru un apartament dat")
    print("0 - Inapoi")

def print_menu_5():
    """
    Functie de printare pentru meniul de filtru
    """
    print("\n1 - Elimina toate cheltuielile de un anumit tip")
    print("2 - Elimina toate cheltuielile mai mici decat o suma data")
    print("0 - Inapoi")

def print_menu_6():
    """
    Functie de printare pentru meniul undo
    """
    print("\n1 - Reface ultima operatie din lista")
    print("0 - Inapoi")

def read_option_UI():
    """
    Functie pentru citirea optiunii
    """
    while True:
        option = input("Introduceti o optiune: ")
        try:
            option = int(option)
            return option
        except ValueError:
            print(colored("Va rugam sa introduceti o optiune valida","yellow"))

def get_apartment(expense):
    """
    Functia returneaza numarului apartamentului a unei cheltuieli specificie
    """
    return expense[0]

def get_type(expense):
    """
    Functia returneaza tipul cheltuielii
    """
    return expense[1]

def get_amount(expense):
    """
    Functia returneaza suma cheltuielii
    """
    return expense[2]

def get_date(expense):
    """
    Functia returneaza data cheltuielii
    """
    return expense[3]

#--------------------Adaugare---------------
def verify_expense(e_list,expense):
    """
    Functia verifica daca exista cheltuiala in lista
    """
    for el in e_list:
        if get_type(expense) == get_type(el) and get_apartment(expense) == get_apartment(el):
            raise ExpenseError

def validate_type(e_type):
    """
    Functia datele introduse pentru cheltuiala sunt valide
    """
    if e_type != "gaz" and e_type != "incalzire" and e_type != "apa" and e_type != "canalizare":
        raise ValueError

def add_expense_UI(expenses_list):
    """
    Functia are rolul de a adauga o cheltuiala
    """
    apartment_number = input("Introduceti numarul apartamentului: ")
    type = input("Introduceti tipul cheltuielii(gaz,apa,canalizare,incalzire): ")
    amount = input("Introduceti suma cheltuielii: ")

    try:
        apartment_number = int(apartment_number)
        amount = int(amount)
        validate_type(type)
        
        x = datetime.datetime.now().date()
        expense = create_expense(apartment_number, type, amount, x)
        add_expense(expenses_list, expense)
          
    except ValueError:
        print(colored("Datele introduse nu sunt valide","yellow"))
    except ExpenseError:
        print(colored("Exista deja o cheltuiala","yellow"))    

    print(colored("Cheltuiala adaugata cu succes","green"))

def create_expense(ap_nr, e_type, amount, e_date):
    """
    Functia returneaza cheltuiala sub forma de lista(o creeaza)
    """
    return [ap_nr, e_type, amount, e_date]

def add_expense(e_list, expense):
    """
    Functia adauga in lista cheltuiala
    """
    verify_expense(e_list,expense)
    e_list.append(expense)

def modify_expense(e_list, expense):
    """
    Functia schimba in lista suma unei cheltuieli
    """
    for el in e_list:
        if get_type(expense) == get_type(el) and get_apartment(expense) == get_apartment(el):
            el[2] = get_amount(expense)
            return
    raise ExpenseError

def modify_expense_UI(expenses_list):
    """
    Funcitia modifica o cheltuiala existenta
    """
    apartment_number = input("Introduceti numarul apartamentului: ")
    type = input("Introduceti tipul cheltuielii(gaz,apa,canalizare,incalzire): ")
    amount = input("Introduceti suma noua a cheltuielii: ")
    try:
        apartment_number = int(apartment_number)
        amount = int(amount)
        validate_type(type)

        x = datetime.datetime.now().date()
        new_expense = create_expense(apartment_number, type, amount, x) 
        modify_expense(expenses_list, new_expense)
    except ValueError:
        print(colored("Datele introduse nu sunt vlaide","yellow"))
    except ExpenseError:
        print(colored("Cheltuiala este inexistenta","yellow"))
    
def menu_1(expenses_list):
    """
    Functia principala meniului de adaugare
    """
    while True:
        print_menu_1()
        option = read_option_UI()
        if option == 1:
            add_expense_UI(expenses_list)
            return 
        elif option == 2:
            modify_expense_UI(expenses_list)
            return 
        elif option == 0:
            return
        else:
            print(colored("Optiunea nu este valida","yellow"))

#-------------------Stergere----------
def delete_expenses_by_ap(e_list, ap_nr):
    """
    Functia elimina cheltuielile din lista 
    """
    ok = True
    while ok:
        ok = False
        for el in e_list:
            if get_apartment(el) == ap_nr:
                e_list.remove(el)
                ok = True

def delete_expenses_by_ap_UI(expenses_list):
    """
    Funcia sterge toate cheltuielile de la un apartament
    """
    number = input("Introduceti numarul apartamentului: ")

    try:
        number = int(number)
        delete_expenses_by_ap(expenses_list,number)
        print(colored("Stergere efectuata cu succes","green"))
    except ValueError:
        print(colored("Introduceti un numar valid","yellow"))

def delete_expenses_by_aps(e_list, nr1, nr2):
    """
    Functia elimina din lista toate cheltuilile de la apartamentele care se incadreaza
    in intervalul nr1 si nr2
    """

    ok = True
    while ok:
        ok = False
        for el in e_list:
            if get_apartment(el) >=nr1 and get_apartment(el)<=nr2:
                e_list.remove(el)
                ok = True

def delete_expenses_by_aps_UI(expenses_list):
    """
    Functia sterge cheltuielile de la apartamente consecutive
    """
    ap_nr_1 = input("Introduceti numarul primului apartament: ")
    ap_nr_2 = input("Introduceti numarul celui de al doilea apartament: ")

    try:
        ap_nr_1 = int(ap_nr_1)
        ap_nr_2 = int(ap_nr_2)
        delete_expenses_by_aps(expenses_list,ap_nr_1,ap_nr_2)
        print(colored("Stergere efectuata cu succes","green"))
    except ValueError:
        print(colored("Numerele nu sunt valide","yellow"))

def delete_expenses_by_type(e_list, ap_type):
    """
    Functia elimina din lista toate cheltuielile de un anumit tip   
    """
    ok = True
    while ok:
        ok = False
        for el in e_list:
            if get_type(el) == ap_type:
                e_list.remove(el)
                ok = True

def delete_expenses_by_type_UI(expenses_list):  
    """
    Functia sterge cheltuielile de un anumit tip de la toate apartamentele
    """
    try:
        ap_type = input("Introduceti tipul cheltuielii(gaz, incalzire, apa, canalizare): ")
        
        validate_type(ap_type) 

        delete_expenses_by_type(expenses_list,ap_type)

        print(colored("Stergere efectuata cu succes","green"))
    except ValueError:
        print(colored("Tipul nu este vaild","yellow"))

def menu_2(expenses_list):
    """
    Functia principala meniului de stergere
    """
    while True:
        print_menu_2()
        option = read_option_UI()
        if option ==1:
            delete_expenses_by_ap_UI(expenses_list)
            return
        elif option == 2:
            delete_expenses_by_aps_UI(expenses_list)
            return
        elif option == 3:
            delete_expenses_by_type_UI(expenses_list)
            return
        elif option == 0:
            return 
        else:
            print(colored("Optiunea nu este valida","yellow"))

#------------------Cautare----------
def all_expenses_by_type(e_list, ap_type):
    """
    Functia returneaza toate cheltuielile care au un anumit tip
    """
    new_list = []
    for el in e_list:
        if get_type(el) == ap_type:
            new_list.append(el)

    return new_list

def all_expenses_by_type_UI(expenses_list):
    """
    Functia tipareste toate cheltuielile de un anumit tip
    """
    ap_type = input("Introduceti tipul cheltuielii(gaz,apa,incalzire,canalizare): ")
    try:
        validate_type(ap_type)
        new_list = all_expenses_by_type(expenses_list, ap_type)
        print(new_list)
    except ValueError:
        print(colored("Tipul nu este valid","yellow"))

def aps_w_expenses(e_list):
    """
    Functia returneaza apartamentele care au cheltuieli
    """
    new_list = []
    for el in e_list:
        add = True
        for i in new_list:
            if get_apartment(el) == i:
                add = False
                break
        if add == True:
            new_list.append(get_apartment(el))

    return new_list

def aps_by_summ(e_list, aps_w_expenses_list, summ):
    """
    Functia returneaza apartamentele care au cheltuieli mai mari decat o suma data
    """
    new_list = []
    for el in aps_w_expenses_list:
        if total_expense_for_ap(e_list,el) > summ:
            new_list.append(el)

    return new_list

def aps_by_summ_UI(expenses_list):
    """
    Functia tipareste apartamentele care au cheltuieli mai mari decat o suma data
    """
    summ = input("Introduceti suma: ")

    try:
        summ = int(summ)
        aps_w_expenses_list = aps_w_expenses(expenses_list)
        aps_by_summ_list = aps_by_summ(expenses_list, aps_w_expenses_list, summ)
        print(aps_by_summ_list)
    except ValueError:
        print(colored("Suma introdusa nu este valida","yellow"))

def all_expenses_by_date_UI(expenses_list):
    """
    Functia tipareste cheltuielile efectuate inainte de o zi si mai mari decat o suma data
    """
    

def menu_3(expenses_list):
    """
    Functia principala a meniului de cautare
    """
    while True:
        print_menu_3()
        option = read_option_UI()
        if option == 1:
            aps_by_summ_UI(expenses_list)
            return
        elif option == 2:
            all_expenses_by_type_UI(expenses_list)
            return 
        elif option == 3:
            return 
        elif option == 0:
            return 
        else:
            print(colored("Optiunea nu este valida","yellow"))
        
#-----------Rapoarte------------------
def total_expense_for_ap(e_list, nr_ap):
    """
    Functia returnea totalul de cheltuieli pentru un apartament dat
    """
    summ = 0
    for el in e_list:
        if get_apartment(el) == nr_ap:
            summ += get_amount(el)

    return summ

def total_expense_for_ap_UI(expenses_list):
    """
    Functia tipareste totalul de cheltuieli pentru un apartament dat
    """
    nr_ap = input("Introduceti numarul apartamentului: ")
    
    try:
        nr_ap = int(nr_ap)
        total_expense = total_expense_for_ap(expenses_list, nr_ap)
        print(colored("Cheltuielile totale sunt de: ","green"),total_expense,"lei")
    except ValueError:
        print(colored("Introduceti un numar valid","yellow"))

def total_expense_for_type(e_list, ap_type):
    """
    Functia returneaza suma totala pentru un anumit tip de cheltuiala
    """
    summ = 0
    for el in e_list:
        if get_type(el) == ap_type:
            summ += get_amount(el)
    
    return summ

def total_expense_for_type_UI(expenses_list):
    """
    Functia tipareste suma totala pentru un anumit tip de cheltuiala
    """
    ap_type = input("Introduceti tipul cheltuielii(gaz,apa,incalzire,canalizare): ")

    try:
        validate_type(ap_type)
        total_expense = total_expense_for_type(expenses_list, ap_type)
        print(colored("Suma totala este de: ","green"),total_expense," lei")
    except ValueError:
        print(colored("Tipul nu este valid","yellow"))

def aps_sorted_by_type(e_list, ap_type):
    """
    Functia returneaza apartamentele care au cheltuieli de un anumit tip
    """ 
    new_list = []
    for el in e_list:
        if get_type(el) == ap_type:
            new_list.append(get_apartment(el))

    return new_list

def sort_aps_by_type_UI(expenses_list):
    """
    Functia tipareste apartamentele sortate dupa un tip de cheltuiala
    """

    ap_type = input("Introduceti tipul: ")

    try:
        validate_type(ap_type)
        aps_list = aps_sorted_by_type(expenses_list, ap_type)
        print(aps_list)
    except ValueError:
        print(colored("Tipul nu este valid","yellow"))

def menu_4(expenses_list):
    """
    Functia principala a meniului de rapoarte
    """
    while True:
        print_menu_4()
        option = read_option_UI()
        if option == 1:
            total_expense_for_type_UI(expenses_list)
            return
        elif option == 2:
            sort_aps_by_type_UI(expenses_list)
            return
        elif option == 3:
            total_expense_for_ap_UI(expenses_list)
            return
        elif option == 0:
            return 
        else:
             print(colored("Optiunea nu este valida","yellow"))

#------------------Filtru------------
def eliminate_expenses_by_type(e_list, ap_type):
    """
    Functia returneaza o lista fara cheltuielile de un anumit tip
    """
    new_list = []
    for el in e_list:
        if get_type(el) != ap_type:
            new_list.append(el)
    
    return new_list

def eliminate_expenses_by_type_UI(expenses_list):
    """
    Functia elimina cheltuielile de un anumit tip
    """
    ap_type = input("Introduceti tipul cheltuielii(gaz,apa,incalzire,canalizare): ")
    try:
        validate_type(ap_type)
        new_list = eliminate_expenses_by_type(expenses_list,ap_type)
        return new_list
    except ValueError:
        print(colored("Tipul nu este valid","yellow"))
        return -1

def eliminate_expenses_by_summ(e_list, summ):
    """
    Functia returneaza o lista cu cheltuielile care sunt mai mici decat o suma
    """
    new_list = []
    for el in e_list:
        if get_amount(el) >= summ:
            new_list.append(el)
    
    return new_list

def eliminate_expenses_by_summ_UI(expenses_list):
    """
    Functia elimina cheltuielile mai mici deca o suma data
    """
    summ = input("Introduceti o suma: ")

    try:
        summ = int(summ)
        new_list = eliminate_expenses_by_summ(expenses_list, summ)
        return new_list
    except ValueError:
        print(colored("Suma introdusa nu este valida","yellow"))
        return -1

def menu_5(expenses_list):
    """
    Functia principala a meniului de filtrare
    """
    while True:
        print_menu_5()
        option = read_option_UI()
        if option == 1:
            new_list = eliminate_expenses_by_type_UI(expenses_list)
            return new_list
        elif option == 2:
            new_list = eliminate_expenses_by_summ_UI(expenses_list)
            return new_list
        elif option == 0:
            return -1
        else:
            print(colored("Optiunea nu este valida","yellow"))

#----------------Undo----------------
def copy_list(list_a):
    """
    Functia returneaza o copie a listei a
    """
    new_list = []
    for el in list_a:
        new_list.append(el)

    return new_list

def add_in_undo_list(e_list, undo_list):
    """
    Functia adauga in undo_list o lista noua
    """
    new_list = copy_list(e_list)
    undo_list.append(new_list)

def update_undo(expenses_list, undo_list):
    """
    Functia modifica lista de undo, adaugand o lista nou
    """
    len_undo = len(undo_list)
    if expenses_list != undo_list[len_undo-1]:
        add_in_undo_list(expenses_list, undo_list)

def remove_from_undo_list(undo_list, l):
    """
    Functia sterge ultima lista din lista de undo
    """
    undo_list.remove(undo_list[l-1])

def make_undo(undo_list):
    """
    Functia returneaza 
    """
    len_undo = len(undo_list)
    if len_undo > 1:
        new_list = copy_list(undo_list[len_undo-2])
        remove_from_undo_list(undo_list, len_undo)
        return new_list
    else:
        print(colored("Nu se poate face undo","yellow"))
        return -1

def menu_6(expenses_list, undo_list):
    """
    Functia principala a meniului undo
    """
    while True:
        print_menu_6()
        option = read_option_UI()
        if option == 1:
            new_list = make_undo(undo_list)
            return new_list
        elif option == 0:
            return -1
        else:
            print(colored("Introduceti o optiune valida","yellow"))

#----------------Main-------------
def main():
    """
    Functia principala a programului
    """
    expenses_list = []
    expenses_list = generate_expenses()
    undo_list = [[]]
    while True:
        print_main()
        update_undo(expenses_list, undo_list)
        option = read_option_UI()
        if option == 1:
            menu_1(expenses_list)
        elif option == 2:
            menu_2(expenses_list)
        elif option == 3:
            menu_3(expenses_list)
        elif option == 4:
            menu_4(expenses_list)
        elif option == 5:
            new_list = menu_5(expenses_list)
            if new_list != -1:
                expenses_list = new_list
                print(colored("Eliminare realizata cu succes","green"))
        elif option == 6:
            new_list = menu_6(expenses_list, undo_list)
            if new_list != -1:
                expenses_list = new_list
                print(colored("Undo realizat cu succes","green"))
        elif option == 0:
            print("Pe data viitoare!")
            return 
        elif option == 9:
            print ("Lista curenta:", expenses_list)
            print ("Lista undo: ", undo_list)
        else:
            print(colored("Optiunea nu este valida","yellow"))

#----------------------Teste----------------
def test_create_expense():  
    expense = create_expense(12,"gaz",100,datetime.date(2020,1,1))

    assert(type(expense) == list)
    assert(get_apartment(expense) == 12)
    assert(get_type(expense) == "gaz")
    assert(get_amount(expense) == 100)
    assert(get_date(expense) == datetime.date(2020,1,1))

def test_add_expense():
    test_list = []
    e1 = create_expense(12,"gaz",100,datetime.date(2020,1,1))
    e2 = create_expense(12,"apa",200,datetime.date(2019,1,1))
    e3 = create_expense(9,"gaz",50,datetime.date(2018,1,1))

    add_expense(test_list,e1)
    assert(len(test_list)==1)
    assert(get_apartment(test_list[0]) == 12)
    assert(get_type(test_list[0]) == "gaz")
    assert(get_amount(test_list[0]) == 100)
    assert(get_date(test_list[0]) == datetime.date(2020,1,1))

    add_expense(test_list,e2)
    assert(len(test_list)==2)
    assert(get_apartment(test_list[0]) == 12)
    assert(get_type(test_list[0]) == "gaz")
    assert(get_amount(test_list[0]) == 100)
    assert(get_date(test_list[0]) == datetime.date(2020,1,1))
    assert(get_apartment(test_list[1]) == 12)
    assert(get_type(test_list[1]) == "apa")
    assert(get_amount(test_list[1]) == 200)
    assert(get_date(test_list[1]) == datetime.date(2019,1,1))

    add_expense(test_list,e3)
    assert(len(test_list)==3)
    assert(get_apartment(test_list[0]) == 12)
    assert(get_type(test_list[0]) == "gaz")
    assert(get_amount(test_list[0]) == 100)
    assert(get_apartment(test_list[2]) == 9)
    assert(get_type(test_list[2]) == "gaz")
    assert(get_amount(test_list[2]) == 50)
    assert(get_date(test_list[2]) == datetime.date(2018,1,1))

def test_modify_expense():
    test_list = []
    e1 = create_expense(12,"gaz",100,datetime.date(2020,1,1))
    e2 = create_expense(12,"apa",200,datetime.date(2019,1,1))
    e3 = create_expense(9,"gaz",50,datetime.date(2018,1,1))
    e4 = create_expense(12,"apa",50,datetime.date(2017,2,2))

    add_expense(test_list,e1)
    add_expense(test_list,e2)
    add_expense(test_list,e3)

    modify_expense(test_list, e4)

    assert(len(test_list) == 3)
    assert(get_amount(test_list[1]) == 50)
    assert(get_apartment(test_list[1]) == 12)
    assert(get_type(test_list[1]) == "apa")
    assert(get_date(test_list[1]) == datetime.date(2019,1,1))
    
def test_delete_expenses_by_ap():
    test_list = []
    e1 = create_expense(12,"gaz",100,datetime.date(2020,1,1))
    e2 = create_expense(12,"apa",200,datetime.date(2019,1,1))
    e3 = create_expense(9,"gaz",50,datetime.date(2018,1,1))

    add_expense(test_list,e1)
    add_expense(test_list,e2)
    add_expense(test_list,e3)

    delete_expenses_by_ap(test_list,12)

    assert(len(test_list) == 1)
    assert(get_amount(test_list[0]) == 50)

def test_delete_expenses_by_aps():
    test_list = generate_expenses()

    delete_expenses_by_aps(test_list,11,12)

    assert(len(test_list) == 2)
    assert(get_amount(test_list[0]) == 125)
    assert(get_apartment(test_list[0])  == 9)
    assert(get_apartment(test_list[1]) == 13)

def test_delete_expenses_by_type():
    test_list=generate_expenses()

    ap_type = "gaz"

    delete_expenses_by_type(test_list, ap_type)

    assert(len(test_list) == 4)
    assert(get_type(test_list[0]) == "apa")
    assert(get_type(test_list[2]) == "canalizare")
    assert(get_amount(test_list[1]) == 150)

def test_all_expenses_by_type():
    test_list = generate_expenses()
    test_list2 = all_expenses_by_type(test_list,"gaz")
    assert(len(test_list2) == 3)

def test_aps_w_espenses():
    test_list = generate_expenses()
    test_list2 = aps_w_expenses(test_list)
    assert(test_list2 == [9,12,11,13])

def test_aps_by_summ():
	test_list = generate_expenses()
    
def test_total_expenses_for_ap():
	test_list = generate_expenses()

def test_total_expenses_for_type():
	test_list = generate_expenses()

def test_eliminate_expenses_by_type():
	test_list = generate_expenses()
    
def test_eliminate_expenses_by_summ():
	test_list = generate_expenses()

def test_start():
    test_modify_expense()
    test_delete_expenses_by_type()
    test_delete_expenses_by_aps()
    test_delete_expenses_by_ap()
    test_create_expense()
    test_add_expense()
    test_all_expenses_by_type()
    test_aps_w_espenses()
    test_aps_by_summ()
    test_total_expenses_for_type()
    test_total_expenses_for_ap()
    test_eliminate_expenses_by_summ()
    test_eliminate_expenses_by_type()

test_start()

main()
