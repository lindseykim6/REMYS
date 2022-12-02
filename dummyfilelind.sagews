︠ce54700b-d0b7-47ee-ab3e-046d3037e402s︠
def pLayer(PT):
    k=len(PT)
    print(k)
    Q=''
    for j in range(k):
         Q = Q + PT[(31*(j-3)) % k]
    return(Q)
pLayer('ICBICBIAHGHCBADAGBEBIBGHHAIAGBEABCFBDABAIBBCDBADEIGIDH')


# def pLayer2(TP):
#     PTLen = len(TP)
#     newPLDict = {}
#     for pos in range(PTLen):
#         char = TP[pos]
#        newPos = (pos * 7 + 3) % 54   7 --> 31
#         newPLDict[newPos] = char
#     newPT = ""
#     for key in newPLDict:
#         newPT = newPT + newPLDict[key]
#     return newPT
# 
# pLayer2('ICBICBIAHGHCBADAGBEBIBGHHAIAGBEABCFBDABAIBBCDBADEIGIDH')
︡d3af261c-3b3e-42c7-8866-c1d09fbd5b3b︡{"stdout":"54\n'AAHIAHAGDHCBGIBEABCHBEIIIFCBBGACBBCIIGBDADBDBIADBGHEAB'\n"}︡{"done":true}
︠687cee68-13bf-4716-8a77-e1236bf9d2e5s︠


def pLayer2(PT):
    k=len(PT)
    print(k)
    Q=''
    for j in range(k):
         Q = Q + PT[(7*j + 3)%k]
    return(Q)

pLayer2('AAHIAHAGDHCBGIBEABCHBEIIIFCBBGACBBCIIGBDADBDBIADBGHEAB')
︡4cae6321-d09c-488c-9679-382353ab844b︡{"stdout":"54\n'ICBICBIAHGHCBADAGBEBIBGHHAIAGBEABCFBDABAIBBCDBADEIGIDH'\n"}︡{"done":true}
︠98c89afc-0699-43ba-b210-9aceb614f430s︠


K.<x> = GF(3);
KT.<x> = K.extension(2)
#for i in range(3^2):
#    print(KT.fetch_int(i))
SBox =[KT.fetch_int(4),KT.fetch_int(1),KT.fetch_int(3),KT.fetch_int(0),KT.fetch_int(5),KT.fetch_int(8),KT.fetch_int(2),KT.fetch_int(6),KT.fetch_int(7)]
# for i,x in enumerate(KT):  print("{} {}".format(i, x))


# Tribits in alphabet A, B, C, D, E, F, G, H. I are strings of length 3, and apply the SBox to it. Note that there are 729 such triples. The result is again strings of length 3
def TranslateFromAlphabet(y):
    if (y=='A'):
        return(0)
    elif (y=='B'):
        return(1)
    elif(y=='C'):
        return(2)
    elif(y=='D'):
        return(x)
    elif(y=='E'):
        return(x+1)
    elif(y=='F'):
        return(x+2)
    elif(y=='G'):
        return(2*x)
    elif(y=='H'):
        return(2*x+1)
    else:
        return(2*x+2)

def TranslateToAlphabet(y):
    if (y==0):
        return('A')
    elif (y==1):
        return('B')
    elif(y==2):
        return('C')
    elif(y==x):
        return('D')
    elif(y==(x+1)):
        return('E')
    elif(y==x+2):
        return('F')
    elif(y==2*x):
        return('G')
    elif(y==2*x+1):
        return('H')
    else:
        return('I')

def SB(Z):
    W = ''
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(SBox[0]*Q+SBox[1]*R+SBox[2]*S)
    W = W+T
    U = TranslateToAlphabet(SBox[3]*Q+SBox[4]*R+SBox[5]*S)
    W = W+U
    V = TranslateToAlphabet(SBox[6]*Q+SBox[7]*R+SBox[8]*S)
    W = W+V
    return(W)

def TribitSBOX(PlTxt):
    k = len(PlTxt)
    if (k!=54):
        return("Not valid plaintext for REMYS PRESENT")
    else:
        SB1='';
        P=[]
        for j in range(k):
            #print(SB1)
            #print(j)
            if (j%3 == 0):
                Q = P + [PlTxt[j]]
                #print(Q)
                R = Q + [PlTxt[j+1]]
                #print(R)
                S = R + [PlTxt[j+2]]
                #print(S)
                W = SB(S)
                #print(W)
                SB1 = SB1+W[0]
                SB1 = SB1+W[1]
                SB1 = SB1+W[2]
                #print(SB1)
        return(SB1)

TribitSBOX('BBBBBBCCFFEHIHIGIHCBEFEBDHIGIHBHIGDBFBHIGIHIGIHIGIBFIC')
︡c46debda-25a2-4f0a-b238-5bf942bcc95d︡{"stdout":"'IBDIBDIEIGGIBDIAAGEDEBCHHDBAAGEDDCGGDIAABCBEBBDIEFIIBH'\n"}︡{"done":true}
︠ab92b1cf-11ed-406c-8658-13d7d8162914s︠

︡d6a2f315-2387-4ea1-a153-d434cefd5e91︡{"done":true}
︠e6d23743-d6d4-495c-b159-a13a002515f1s︠

︡878956be-551e-4a4c-861e-c509f69a7813︡{"done":true}
︠89a7c83b-3cf8-4397-bafd-77e41042cfb9s︠
K.<x> = GF(3);
KT.<x> = K.extension(2)
# for i in range(3^2):
#     print(KT.fetch_int(i))
SBox3 =[KT.fetch_int(5),KT.fetch_int(2),KT.fetch_int(0),KT.fetch_int(5),KT.fetch_int(8),KT.fetch_int(1),KT.fetch_int(8),KT.fetch_int(5),KT.fetch_int(3)]
# for i,x in enumerate(KT):  print("{} {}".format(i, x))
# AD=[x+2, 2, 0, x + 2, 2*x + 2, 1, 2*x + 2, x + 2, x]
# TranslateToAlphabet(AD[0])
# TranslateToAlphabet(AD[1])
# TranslateToAlphabet(AD[2])
# TranslateToAlphabet(AD[3])
# TranslateToAlphabet(AD[4])
# TranslateToAlphabet(AD[5])
# TranslateToAlphabet(AD[6])
# TranslateToAlphabet(AD[7])
# TranslateToAlphabet(AD[8])
︡f590e4b9-42d3-4ace-8618-2a96625d2dc3︡{"done":true}
︠9b5d0bdd-7c3f-4a21-b684-25aefd03cf99s︠
def SB2(Z):
    W = ''
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet((SBox3[0]*Q)+(SBox3[1]*R)+(SBox3[2]*S))
    W = W+T
    U = TranslateToAlphabet(SBox3[3]*Q+SBox3[4]*R+SBox3[5]*S)
    W = W+U
    V = TranslateToAlphabet(SBox3[6]*Q+SBox3[7]*R+SBox3[8]*S)
    W = W+V
    return(T)


def invTribitSBOX(PlTxt):
    k = len(PlTxt)
    if (k!=54):
        return("Not valid plaintext for REMYS PRESENT")
    else:
        SB1='';
        P=[]
        for j in range(k):
            print(SB1)
            print(j)
            if (j%3 == 0):
                Q = P + [PlTxt[j]]
                # print(Q)
                R = Q + [PlTxt[j+1]]
                # print(R)
                S = R + [PlTxt[j+2]]
                # print(S)
                W = SB2(S)
                # print(W)
                SB1 = SB1+W[0]
                SB1 = SB1+W[1]
                SB1 = SB1+W[2]
                #print(SB1)
        return(SB1)
︡adee803b-8ad5-481e-8398-7f9979abf45e︡{"done":true}
︠980815dc-f7de-4de4-9c20-7abfb7f7d0b4s︠
invTribitSBOX('IBDIBDIEIGGIBDIAAGEDEBCHHDBAAGEDDCGGDIAABCBEBBDIEFIIBH')
︡99098d28-8432-4307-ab04-f59644d32c8d︡{"stdout":"\n0\n"}︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1188, in execute\n    flags=compile_flags), namespace, locals)\n  File \"\", line 1, in <module>\n  File \"\", line 17, in invTribitSBOX\nIndexError: string index out of range\n"}︡{"done":true}
︠cee69eca-f402-465d-8181-69d61798b8afs︠
SB2('IBD')
#RSBox = [["E","B","D"],["A","F","I"],["C","G","H"]]
#InverseSBox = ?? Recall from board = [["F", "C", "A"], ["F", "I", "B"], ["I", "F", "D"]]

︡a412e1dd-60aa-4443-adfe-b305155bb171︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1188, in execute\n    flags=compile_flags), namespace, locals)\n  File \"\", line 1, in <module>\n  File \"\", line 6, in SB2\nNameError: global name 'SBox3' is not defined\n"}︡{"done":true}︡
︠5715310f-638e-442a-a1cb-a2cf66f2bfd1︠

︡f540d235-91f0-4d49-91a8-53aaddbf16b3︡
︠b48ee784-5a13-4192-977b-7dac5ea2c088s︠

(2*x+2)*(x+2)
︡b4e9bd24-764b-48f2-9c85-788ce7d1e3dc︡{"stdout":"2*x\n"}︡{"done":true}
︠1f76dc05-a02e-4cc9-9237-142301d8ad92s︠
# returns an array with 0,...,n
# integers
def list_num(n):
    temp = []
    for i in range(n):
        temp.append(i)
    return temp;

# we can modify a*j+b mod k
def pLayer(PT):
    k=len(PT)
    Q=[]
    for j in range(k):
         Q.append( (13*j+4) % k)
    return(Q)

# takes in two arrays
# arr1 is array with n-integers
# arr2 is array that was rearranged (aka permutation)
# returns a array with cycles
def cycles(arr1,arr2):
    list1 = arr1 # array with 54 ints
    list2 = arr2 # sigma
    list4 = []   # array will soon carry cycles
    while list1 != []:
        list3 = []
        inp = list1[0]
        j = inp
        # print list1
        list1.remove(j)
        list3.append(j)
        while list2[j] != inp:
            j = list2[j]
            list1.remove(j)
            list3.append(j)
        list4.append(list3)
    return list4;



def cycles_length(arr):
    n = len(arr)
    for i in range(n):
        j = len(arr[i])
        print arr[i], "has length: ", j


#*****************************************
#     Implementation
#
#*****************************************

# Defines our array with 54 integers
# along with sigma our permutation
fifty_four = list_num(54)
fifty_four
sigma = pLayer(fifty_four)
sigma
# This is an array with our cycles 
# see "cycles" definition
arrwith_cycles = cycles(fifty_four,sigma)
arrwith_cycles

# Gives a clear visual of our cycles and their
# cycle lengths
# print "EXAMPLE OF CYCLE LENGTHS:\n"
# cycles_length(arrwith_cycles)
︡5b771765-6bb5-4641-a0b3-7bfaa0d2c14a︡{"stdout":"[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53]\n"}︡{"stdout":"[4, 17, 30, 43, 2, 15, 28, 41, 0, 13, 26, 39, 52, 11, 24, 37, 50, 9, 22, 35, 48, 7, 20, 33, 46, 5, 18, 31, 44, 3, 16, 29, 42, 1, 14, 27, 40, 53, 12, 25, 38, 51, 10, 23, 36, 49, 8, 21, 34, 47, 6, 19, 32, 45]\n"}︡{"stdout":"[[0, 4, 2, 30, 16, 50, 6, 28, 44, 36, 40, 38, 12, 52, 32, 42, 10, 26, 18, 22, 20, 48, 34, 14, 24, 46, 8], [1, 17, 9, 13, 11, 39, 25, 5, 15, 37, 53, 45, 49, 47, 21, 7, 41, 51, 19, 35, 27, 31, 29, 3, 43, 23, 33]]\n"}︡{"done":true}
︠b7b4f47d-9ac2-4974-a689-14e47664a727s︠
posarray=array[:]
posarray

︡f168bf24-a990-41a1-a90e-a2bcd118e2d6︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1188, in execute\n    flags=compile_flags), namespace, locals)\n  File \"\", line 1, in <module>\nNameError: name 'array' is not defined\n"}︡{"done":true}









