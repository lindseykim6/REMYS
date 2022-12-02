︠62bcf933-ffde-4f09-aafa-b5dfbe329f97s︠
#RSBox = [["E","B","D"],["A","F","I"],["C","G","H"]]
K.<x> = GF(3);
KT.<x> = K.extension(2)
#for i in range(3^2):
#    print(KT.fetch_int(i))
SBox =[KT.fetch_int(4),KT.fetch_int(1),KT.fetch_int(3),KT.fetch_int(0),KT.fetch_int(5),KT.fetch_int(8),KT.fetch_int(2),KT.fetch_int(6),KT.fetch_int(7)]
# for i,x in enumerate(KT):  print("{} {}".format(i, x))
SBox

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
︡b2b3eb33-e07b-4b9b-ad80-afd31b928862︡{"stdout":"[x + 1, 1, x, 0, x + 2, 2*x + 2, 2, 2*x, 2*x + 1]\n"}︡{"done":true}
︠7dc98868-834f-4c86-bd5b-4e75ef038c9bs︠

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
    elif(y==(2*x+1)):
        return('H')
    elif(y==(2*x+2)):
        return('I')
    else:
        return('not valid')
# Plaintext length: Old PRESENT: 64 bits (GF(2)^64) REMYS PRESENT: 18 tribits = 54 characters.
# Key length: Old PRESENT: 80 bits (2^4*5 = 2^3*10 = 2^2*20) REMYS PRESENT: 22 tribits = 66 characters


# AddRoundKey:
# Takes Plaintext of correct length, and alphabet, and round key of correct length, and add characterwise.

def AddRoundKey(PlTxt,Roundkey):
    k = len(PlTxt)
    m = len(Roundkey)
    if(k!=54):
        return("Not valid plaintext for REMYS PRESENT")
    elif(m!=54):
        return("Not valid round key for REMYS PRESENT")
    else:
        P=''
        for j in range(k):
            Q = TranslateFromAlphabet(PlTxt[j])
            R = TranslateFromAlphabet(Roundkey[j])
            S = TranslateToAlphabet(Q+R)
            P = P + S
        return(P)


# We think of triples in alphabet A, B, C, D, E, F, G, H. I as vectors of length 3, and apply the SBox to it. Note that there are 729 such triples. The result is again vectors of length 3
def SB(Z):
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet((SBox[0]*Q)+(SBox[1]*R)+(SBox[2]*S))
    U = TranslateToAlphabet((SBox[3]*Q)+(SBox[4]*R)+(SBox[5]*S))
    V = TranslateToAlphabet((SBox[6]*Q) +(SBox[7]*R) +(SBox[8]*S))
    return([T,U,V])
︡e31c89c5-0635-4cdc-b598-1e9cd151c0c0︡{"done":true}
︠91eb4493-856f-4daf-af9d-e2cfaf7e94aes︠

#Examples.
SB(['A','B','C'])
SB(['H','G','I'])
SB(['I','I','C'])
SB(['D','D','E'])
SB(['A', 'A', 'A'])
SB(['I', 'I', 'I'])
︡daf8702d-4906-4875-9c29-405bcaa53ea4︡{"stdout":"['H', 'G', 'C']\n"}︡{"stdout":"['I', 'B', 'A']\n"}︡{"stdout":"['D', 'B', 'E']\n"}︡{"stdout":"['I', 'C', 'C']\n"}︡{"stdout":"['A', 'A', 'A']\n"}︡{"stdout":"['C', 'I', 'F']\n"}︡{"done":true}
︠6cea78d1-e1ce-43f3-b498-a7b9fc4d95abs︠

︡e7c20643-8aad-482f-907f-60194bd6d688︡{"done":true}
︠9eafce36-df9a-42c7-8ea4-261d77ae7eb5s︠

# SBox is a permutation of 729 (=9^3) items.
# To find the cycle lengths of SBox we can do the following.
# For ['A','A','A'] the cycle length is 1
# For each other ['X','X','X'] the cycle length is 40. This accounts for 321 elements of SBox.
# What about the other cycles?
IP =  ['B', 'F', 'D']
B  = IP
for j in range(50):
    B= SB(B)
    if (B==IP):
         print(j+1,B)
    # print(j+1,B)

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
        EverythingArray.append(B);
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
    for j in range(60):
        B = SB(B);
        # for i in range(50):
        if (B==IP):
            rounds.append([others,j+1])
            break
# rounds
# len(rounds)

for item in rounds:
    if item[1]!=80:
        print item


︡59593463-1f39-4b68-b63c-2efb1077151d︡{"stdout":"[['A', 'A', 'A'], 1]\n[['B', 'F', 'I'], 2]\n[['C', 'H', 'E'], 2]\n[['D', 'B', 'F'], 2]\n[['E', 'D', 'B'], 2]\n[['F', 'I', 'G'], 2]\n[['G', 'C', 'H'], 2]\n[['H', 'E', 'D'], 2]\n[['I', 'G', 'C'], 2]\n"}︡{"done":true}
︠9fb4cbfa-6ab4-4f9b-b8a3-919b928396c6s︠

# SBox manipulation

# Take Plaintext of correct length, and alphabet, and subdivide into tribits
# Apply SBox to the tribits
# Convert the tribit list back into a 54 character text

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


# pLayer permutation: 64 positions (GF(2)^64), 54 positions in (GF(2^3)^54).

# y = (7*x+3) mod 54 permutes the numbers 0, 1, 2, 3, ..., 53

# def pLayer(PT):
#     k=len(PT)
#     print(k)
#     Q=''
#     for j in range(k):
#          Q = Q + PT[(7*j+3) % k]
#     return(Q)

PT4=('AAAAAABBEEDGHGHIHGBADEDAFGHIHGAGHIFAEAGHIHGHIHGHIHAEHB')
RoundKey4=('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB')
PT5 = AddRoundKey(PT4, RoundKey4)
PT5
PT6=TribitSBOX(PT5)
PT6 
# PT7=pLayer(PT6)
# "PT7=" + PT7
len(PT6)
︡20766f41-c6e9-4e1e-b704-1222f22b36fb︡{"stdout":"'BBBBBBCCFFEHIHIGIHCBEFEBDHIGIHBHIGDBFBHIGIHIGIHIGIBFIC'\n"}︡{"stdout":"'IBDIBDIEIGGIBDIAAGEDEBCHHDBAAGEDDCGGDIAABCBEBBDIEFIIBH'\n"}︡{"stdout":"54\n"}︡{"done":true}
︠03fa395a-d642-4233-8fcb-4e413a0766d0s︠
def pLayer2(TP):
    PTLen = len(TP)
    newPLDict = {}
    for pos in range(PTLen):
        char = TP[pos]
        newPos = (pos * 7 + 3) % 54  # 7 --> 31
        newPLDict[newPos] = char
    newPT = ""
    for key in newPLDict:
        newPT = newPT + newPLDict[key]
    return newPT

PT9=pLayer2(PT6)
PT9

def pLayer3(PT):
    dict={};
    for i in range(len(PT)):
        char=PT[i]
        dict[31*(i-3)%54]=char;
    newPT=""
    for key in dict:
        newPT=newPT+dict[key]
    return newPT

pLayer3(PT9)
︡137731a4-ecc5-4fa7-a515-8841153578db︡{"stdout":"'ADHIDIAAIHBDGBGEDDCGCEFBIGIBDIABGBEEIADDDBBBGIIIBCHEEA'\n"}︡{"stdout":"'IBDIBDIEIGGIBDIAAGEDEBCHHDBAAGEDDCGGDIAABCBEBBDIEFIIBH'\n"}︡{"done":true}
︠1f405a58-dc10-4a04-a94b-80109c34ec90s︠
SB('ABC')
︡d8690179-5798-4052-aa91-699ad7a2fcc1︡{"stdout":"['H', 'G', 'C']\n"}︡{"done":true}
︠0a354c40-cfd1-41d2-9bb8-fb994d3d6fe5s︠
def invTribitSBOX(PlTxt):
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
︡6d99d61e-3656-4bd2-8976-ddbf8870f5a6︡{"done":true}
︠d5c34050-421f-443a-ac4a-570c92e02810s︠

︡5b9de926-a2d3-4b2b-8343-5bc27d3e17e2︡{"done":true}
︠6dd1e809-5939-4251-a0d3-449015d5dc6bs︠

︡3591bf1f-75c7-4523-ad61-32991892c1ef︡{"done":true}
︠66c2d177-8afe-46ad-a7e5-959b9cabd65e︠

IP =  ['B', 'F', 'D']
B  = IP
for j in range(10:
    B= SB(B)
    if (B==IP):
        print(j+1,B)
︡efc791b9-532a-467e-8109-2601a6cbb111︡{"stdout":"(80, ['B', 'F', 'D'])\n"}︡{"done":true}
︠97ac6c6c-6455-4690-821b-43de3e7e0f63s︠

SB(['E', 'D', 'B'])
︡90b598e6-4e43-4dcd-b3cc-cb969dd3898a︡{"stdout":"['I', 'G', 'C']\n"}︡{"done":true}









