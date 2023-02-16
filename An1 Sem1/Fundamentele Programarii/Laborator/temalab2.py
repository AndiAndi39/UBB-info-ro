import math

ok = True
while ok == True:
    nr = input("Introduceti un numar: ")
    ok = False
    if nr[0] in ('-','+'):
        if not nr[1:].isdigit():
            ok = True
            print("Acesta nu este un numar valid. Va rugam introduceti un numar.")
    elif not nr.isdigit():
        ok = True
        print("Acesta nu este un numar valid. Va rugam introduceti un numar.")
            

nr = int(nr)

if nr < 2:
    print(2)
else:
    if nr%2==0:
        res = nr+1
    else:
        res = nr+2
    
    def prime(number):
        m = int(math.sqrt(number))
        for d in range(3,m,+2):
            if number%d == 0:
                return False
        return True

        
    ok = False
    while ok == False:
        if prime(res) == True:
               ok = True
        else:
            res += 2

    print(res)
