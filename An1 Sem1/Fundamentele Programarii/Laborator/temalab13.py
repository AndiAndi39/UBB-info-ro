def isSet(the_list):
    the_list2 = set(the_list)
    if len(the_list) != len(the_list2):
        return False
    if len(the_list) > 1:
        for i in range(1, len(the_list)):
            ok = False
            for j in range(0, i):
                if abs(the_list[i]-the_list[j]) == 1:
                    ok = True
            if ok == False:
                return False
    return True
 
def f_recursiv(the_list, n):
    if len(the_list) == n:
        print (the_list)
        return
    the_list.append(0)
    for i in range(1,n+1):
        the_list[-1] = i
        if isSet(the_list):
            f_recursiv(the_list, n)
    the_list.pop()

def f_iterativ(the_list, n):
    the_list = [0]
    while len(the_list) > 0:
        choosed = False
        while not choosed and the_list[-1]<=n:
            the_list[-1] = the_list[-1]+1
            if the_list[-1] <= n and isSet(the_list):
                choosed = True
        if choosed:
            if isSet(the_list) and len(the_list) == n:
                print (the_list)
            the_list.append(0)
        else:
            the_list = the_list[:-1]

def main():
    n = int(input("Introduceti un numar: "))
    #f_recursiv([],n)
    f_iterativ([],n)

main()
