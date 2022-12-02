︠1ce84c2c-fdd4-4209-9b48-f8b4c50e388ds︠
IP = 'III'
B  = IP
for j in range(100):
    B = SB(B)
    C = Join(B)
    if (C==IP):
        print(j+1,C)

array5=[] #every possible tribit
alphabet1=['A','B','C','D','E','F','G','H','I']
alphabet2=['A','B','C','D','E','F','G','H','I']
alphabet3=['A','B','C','D','E','F','G','H','I']
for k in range(len(alphabet1)):
    for j in range(len(alphabet2)):
        for i in range(len(alphabet3)):
            P=[alphabet1[k],alphabet2[j],alphabet3[i]];
            array5.append(P);

# array5
# for i in range(len(array5)):
#     print (i,array5[i])

EverythingArray=[]; #everything in cycle of [AAA],[BBB],[CCC],[DDD],[EEE],[FFF],[GGG],[HHH],[III]
alphabet=['B','C','D','E','F','G','H','I']
for char in alphabet:
    IP = [char,char,char]
    B  = IP
    for j in range(40):
        B = SB(B)
        #IP = SB(IP)?
        EverythingArray.append(B); #EverythingArray.append(IP)
# for i in range(len(EverythingArray)):
#     print (i,EverythingArray[i])

everythingelse=[] #everything not in cycle of [AAA],[BBB],[CCC],[DDD],[EEE],[FFF],[GGG],[HHH],[III]
for item in array5:
    for ite in EverythingArray:
        if item==ite:
            break
    else:
        everythingelse.append(item)

# everythingelse
# len(everythingelse)

rounds=[] #number of rounds for everythingelse
for others in everythingelse:
    IP = others
    B  = IP
    for j in range(100):
        B = SB(B);
        # for i in range(50):
        if (B==IP):
            rounds.append([others,j+1])
            break
# rounds
# len(rounds)

print(rounds)

for item in rounds:
    if item[1]!=80:
        print item


# 1 + 8 = 9. 729-9 = 720. 720/80 = 9.
# One 1-cycle
# Four 2-cycles
# Nine 80-cycles
# SBox is odd permutation.
︡250bcb46-c9df-44a0-872d-423ffa76c3bb︡{"stderr":"Error in lines 3-7\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1234, in execute\n    flags=compile_flags), namespace, locals)\n  File \"\", line 2, in <module>\nNameError: name 'SB' is not defined\n"}︡{"done":true}









