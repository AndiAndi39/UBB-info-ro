import datetime

y = input("Introduceti anul: ")
m = input("Introduceti luna: ")
d = input("Introduceti ziua: ")

y = int(y)
m = int(m)
d = int(d)

res = (datetime.datetime.now()-datetime.datetime(y,m,d)).days

if res > 0:
    print("Ai trait",res,"zile")
    print("Felicitari")
else:
    print("Mai ai pana te nasti")


