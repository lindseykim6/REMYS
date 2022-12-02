︠7885cc89-ace5-4732-bc89-9c9686fc993bs︠

######################################################
# 1) Establish the field arithmetic.               ###
######################################################
############################################################
# Alphabet                                                 #
# A B C D E   F   G  H    I                                #
# 0 1 2 x x+1 x+2 2x 2x+1 2x+2                             #
############################################################
K.<x> = GF(3);
KT.<x> = K.extension(2)
#for i in range(3^2):
#    print(KT.fetch_int(i))

#######################################################
## 2) The TROIKA substitution boxes                 ###
#######################################################
SBox = [x+1,1,x,0,x+2,1,2,2*x,2*x+1]
InverseSBox=[2*x+2,2*x+1,0,x+2,0,x,x+1,1,2]
#SBox = [["E","B","D"],["A","F","B"],["C","G","H"]] a.k.a
#INVERSE IS [["I", "H", "A"],["F", "A", "D"], ["E", "B", "C"]]

#######################################################
## 3) Between alphabet and GF(3^2)                  ###
#######################################################

def TranslateFromAlphabet(y):
    if (y=='A'):
        #print('From TranslateFromAlphabet, for A',y)
        return(0)
    elif (y=='B'):
        #print('From TranslateFromAlphabet, for B',y)
        return(1)
    elif(y=='C'):
        #print('From TranslateFromAlphabet, for C',y)
        return(2)
    elif(y=='D'):
        #print('From TranslateFromAlphabet, for D',y)
        return(x)
    elif(y=='E'):
        #print('From TranslateFromAlphabet, for E',y)
        return(x+1)
    elif(y=='F'):
        #print('From TranslateFromAlphabet, for F',y)
        return(x+2)
    elif(y=='G'):
        #print('From TranslateFromAlphabet, for G',y)
        return(2*x)
    elif(y=='H'):
        #print('From TranslateFromAlphabet, for H',y)
        return(2*x+1)
    elif(y=='I'):
        #print('From TranslateFromAlphabet, for I',y)
        return(2*x+2)
︡2a0682fc-4da1-4fd6-8804-9942cdfca9f9︡{"done":true}
︠de9aa5c9-4505-4c79-bd90-774c0407640ds︠
def TranslateToAlphabet(y):
    if (y==0):
        return('A')
    elif (y==1):
        return('B')
    elif(y==2):
        return('C')
    elif(y==x):
        return('D')
    elif(y==x+1):
        return('E')
    elif(y==x+2):
        return('F')
    elif(y==2*x):
        return('G')
    elif(y==2*x+1):
        return('H')
    elif(y==2*x+2):
        return('I')

#######################################################
## 4) SBox applied to Tribits                       ###
#######################################################


def SB(Z):
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(SBox[0]*Q+SBox[1]*R+SBox[2]*S)
    U = TranslateToAlphabet(SBox[3]*Q+SBox[4]*R+SBox[5]*S)
    V = TranslateToAlphabet(SBox[6]*Q+SBox[7]*R+SBox[8]*S)
    return([T,U,V])

#Take Plaintext of correct length, and alphabet, and subdivide into tribits
#Apply SBox to the tribits
#Convert the tribit list back into a 54 character text

def TribitSBOX(PlTxt):
    k = len(PlTxt)
    if (k!=54):
        return("Not valid plaintext for REMYS PRESENT")
    else:
        SB1='';
        P=[]
        for j in range(k):
            if (j%3 == 0):
                Q = P + [PlTxt[j]]
                R = Q + [PlTxt[j+1]]
                S = R + [PlTxt[j+2]]
                W = SB(S)
                SB1 = SB1+W[0]
                SB1 = SB1+W[1]
                SB1 = SB1+W[2]
        return(SB1)

#######################################################
## 5) InverseSBox applied to Tribits                ###
#######################################################

def InvSB(Z):
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(InverseSBox[0]*Q+InverseSBox[1]*R+InverseSBox[2]*S)
    U = TranslateToAlphabet(InverseSBox[3]*Q+InverseSBox[4]*R+InverseSBox[5]*S)
    V = TranslateToAlphabet(InverseSBox[6]*Q+InverseSBox[7]*R+InverseSBox[8]*S)
    return([T,U,V])

def TribitInverseSBOX(CTxt):
    k = len(CTxt)
    if (k!=54):
        return("Not valid ciphertext for REMYS PRESENT")
    else:
        SB1='';
        P=[]
        for j in range(k):
            if (j%3 == 0):
                Q = P + [CTxt[j]]
                R = Q + [CTxt[j+1]]
                S = R + [CTxt[j+2]]
                W = InvSB(S)
                SB1 = SB1+W[0]
                SB1 = SB1+W[1]
                SB1 = SB1+W[2]
        return(SB1)

#######################################################
##  6) Vectors of length 3 to strings of length 3   ###
#######################################################

def Join(M):
    N = M[0]
    N = N+M[1]
    N=N+M[2]
    return(N)

#######################################################
## 7) Round key and Key register functions          ###
#######################################################

def NumberToField(n):
    if (n==0):
        return(0)
    elif (n==1):
        return(1)
    elif (n==2):
        return(2)
    elif (n==3):
        return(x)
    elif (n==4):
        return(x+1)
    elif (n==5):
        return(x+2)
    elif (n==6):
        return(2*x)
    elif(n==7):
        return(2*x+1)
    else:
        return(2*x+2)

# SPAWNING ROUND KEY from the current key in the key register
# Return the first  54 of 66 characters
def RoundKey(KeyReg):
    k = len(KeyReg)
    if (k!=66):
        return('The key register does not contain a REMYS PRESENT key')
    else:
        return(KeyReg[0:54])


def AddRoundKey(PlTxt,Roundkey):
    k = len(PlTxt)
    m = len(Roundkey)
    if(k != 54):
        return("From AddRoundKey: Not valid plaintext for REMYS PRESENT")
    elif(m != 54):
        return("From AddRoundKey: Not valid round key for REMYS PRESENT")
    else:
        P=''
        for j in range(k):
            Q = TranslateFromAlphabet(PlTxt[j])
            R = TranslateFromAlphabet(Roundkey[j])
            if (Q==1 and R==2):
                S = 0
            elif (Q==2 and R==1):
                S = 0
            elif (Q==2 and R==2):
                S = 1
            else:
                S = Q + R
            T = str(TranslateToAlphabet(S))
            P = P + T
        return(P)

# For Decryption, use the opposite of AddRoundkey.
def SubtractRoundKey(CTxt,Roundkey):
    k = len(CTxt)
    m = len(Roundkey)
    if(k != 54):
        return("From SubtractRoundKey: Not valid plaintext for REMYS PRESENT")
    elif(m != 54):
        return("From SubtractRoundKey: Not valid round key for REMYS PRESENT")
    else:
        P=''
        for j in range(k):
            Q = TranslateFromAlphabet(CTxt[j])
            R = TranslateFromAlphabet(Roundkey[j])
            if (Q==0 and R==1):
                S = 2
            elif (Q==0 and R==2):
                S = 1
            elif (Q==1 and R==2):
                S = 2
            else:
                S = Q - R
            T = TranslateToAlphabet(S)
            P = P + T
        return(P)

#KeyRegister still in progress
def KeyRegister(Key,round):
    #First the SBOX updates to the key in the register
    SKey1 = Key[0:3]
    SKey2 = Key[3:6]
    SKey3 = Join(SB(SKey1))
    SKey4 = Join(SB(SKey2))
    SKeyL = SKey3 + SKey4
    # Then the round addition updates to the key in the key register.
    #Do round addtions to positions 14-12 from the right end.
    #July 18: 23 rounds. ?Positions 14-12??
    #CHANGE: <=8 rounds. Position 12 July 19, 2019 Change character 53
    #Isolate the segment carrying the round number influence
    PreR  = Key[6:52]
    RKey = Key[52]
    r = NumberToField(round)
    nKey = TranslateFromAlphabet(RKey)+r
    RKey2 = TranslateToAlphabet(nKey)
    PostR = Key[53:66]
    NewKey = PreR+RKey2
    NewKey = NewKey+PostR
    SKeyL1 = SKeyL + NewKey #Key[6:66]
    # Then the key shift
    RKey = SKeyL1[0:55]
    LKey = SKeyL1[55:66]
    FKey = LKey+RKey
    return(FKey)

︡11e6e66b-d514-4a4b-84d8-60d1b9381135︡{"done":true}
︠3cd960d1-ebe2-44be-b88e-d71a4b794738s︠
##########################################################
## 8) The diffusion provided by the permutation layer  ###
##########################################################

def pLayer(PT):
    k=len(PT)
    Q=''
    for j in range(k): #(k/3):
        Q = Q + PT[(7*j+3) % k]
    return(Q)

def pdeLayer(PT):
    k=len(PT)
    Q=''
    for j in range(k): #(k/3):
        Q = Q + PT[((1/7)*(j-3)) % k]
    return(Q)

##########################################################
## 9) From ASCII to TROIKA alphabet                    ###
##########################################################

def AlphabetToNumbers(Cc):
    if (Cc=='A'):
        return(0)
    elif (Cc=='B'):
        return(1)
    elif (Cc=='C'):
        return(2)
    elif (Cc=='D'):
        return(3)
    elif (Cc=='E'):
        return(4)
    elif (Cc=='F'):
        return(5)
    elif (Cc=='G'):
        return(6)
    elif (Cc=='H'):
        return(7)
    else:
        return(8)

︡61c2062b-c310-4138-b35f-b1ba7002c743︡{"done":true}
︠2dd30c53-73c3-457d-8e19-2057095e1f9cs︠
def NumbersToAlphabet(C):
    if (C== 0):
        return('A')
    elif (C== 1):
        return('B')
    elif (C== 2):
        return('C')
    elif (C== 3):
        return('D')
    elif (C== 4):
        return('E')
    elif (C== 5):
        return('F')
    elif (C== 6):
        return('G')
    elif (C== 7):
        return('H')
    elif(C==8):
        return('I')



def chartotribit(C):
    a = ZZ(ord(C)).digits(9)
    #print(a)
    k = len(a)
    Z = ''
    if (k==1):
        a = a + [0,0]
    elif (k == 2):
        a = a +[0]
    Z = Z + NumbersToAlphabet(a[0])
    Z = Z + NumbersToAlphabet(a[1])
    Z = Z + NumbersToAlphabet(a[2])
    return(Z)


def ASCIItoTROIKA(Message):
    M = Message
    k = len(M)
    N=''
    for j in range(k):
        N = N + chartotribit(M[j])
    return(N)

##########################################################
## 11) From TROIKA alphabet to ASCII                   ###
##########################################################

def tribittochar(Codetext):
    C = Codetext
    N = [AlphabetToNumbers(C[0]),AlphabetToNumbers(C[1]),AlphabetToNumbers(C[2])]
    av = N[0]+9*N[1]+81*N[2]
    return(chr(av))


def TROIKAtoASCII(M):
    k=len(M)/3
    nn = ''
    for j in range(k):
        l = 3*j
        u = 3*j+3
        #print(l,u)
        #print(M[l:u])
        nn = nn + tribittochar(M[l:u])
    return(nn)






##########################################################
##  12) Encryption with TROIKA                         ###
##########################################################

# The Message is an ASCII string bordered by single quotes: For example 'abra kadabra ...'
# The current version requires 54 tribits. Upgrade to: append for short messages, split into packets for long messages.

def RoundEncrypt(Message,Key):
    A = ASCIItoTROIKA(Message)
    R1 = RoundKey(Key)
    E1 = AddRoundKey(A,R1)
    E2 = TribitSBOX(E1)
    E3 = pLayer(E2)
    return(E3)

def Encrypt(Message,Key,rounds):
    M = Message
    K = Key
    for j in range(rounds):
        M  = RoundEncrypt(M,K)
        PK = KeyRegister(K,j)
        K = PK
        print(j)
    return(M)
︡af10f898-0961-413c-b21f-51dfede06029︡{"done":true}
︠3b7ee1ec-3c38-47ce-a662-276904ec2c12s︠

##########################################################
## 13) Decryption with TROIKA                          ###
##########################################################

# Currently single round. Upgrade to handle multiple rounds.

def RoundDecrypt(CipherText,Key):
    E3 = pdeLayer(CipherText)
    E2 = TribitInverseSBOX(E3)
    R1 = RoundKey(Key)
    E1 = SubtractRoundKey(E2,R1)
    #A  = TROIKAtoASCII(E1) #Not included here when used in multiple round decryption
    #return(A)
    return(E1)



#######################################################
## 14) TROIKA substitution boxes analysis           ###
#######################################################

def generateEverythingArray(): #generates every possible tribit in our Galois Field
    everythingArray = []

    alphabet1 = ['A','B','C','D','E','F','G','H','I']
    alphabet2 = ['A','B','C','D','E','F','G','H','I']
    alphabet3 = ['A','B','C','D','E','F','G','H','I']

    for k in range(len(alphabet1)):
        for j in range(len(alphabet2)):
            for i in range(len(alphabet3)):
                P = [alphabet1[k], alphabet2[j], alphabet3[i]];
                everythingArray.append(P);

    return everythingArray

def generateCompleteCycleSBox(tribit): #generates a S-Box cycle for a given Tribit
    state = tribit
    reference = state

    completeCycle = []

    for j in range(729):
        completeCycle.append(state)
        state = SB(state)
        if (state == reference):
            break

    return completeCycle

def subtractArrayfromArray(smallArray, bigArray): #removes elements of one array for another
    for item in smallArray:
        bigArray.remove(item)
    return bigArray

def generateCycleLengths(array): #generates cycle lengths for all elements in an array
    cycleLengths = []

    while(len(array) != 0):

        for tribit in array:
            completeCycle = generateCompleteCycleSBox(tribit)
            cycleLengths.append([len(completeCycle), tribit])
            array = subtractArrayfromArray(completeCycle, everythingArray)

    return cycleLengths

everythingArray = generateEverythingArray() #generates an array of all possible tribits
cycleLengths = generateCycleLengths(everythingArray) # generates cycle lengths for all tribits
for item in cycleLengths:
    print(item[0], item[1])
︡ed80f43a-cc19-44a5-82a3-40ffbe3c7e53︡{"stdout":"(1, ['A', 'A', 'A'])\n(80, ['A', 'A', 'C'])\n(80, ['A', 'A', 'E'])\n(80, ['A', 'A', 'G'])\n(80, ['A', 'A', 'I'])\n(80, ['A', 'B', 'F'])\n(80, ['A', 'C', 'B'])\n(80, ['A', 'C', 'H'])\n(80, ['A', 'F', 'A'])\n(80, ['B', 'A', 'A'])\n(2, ['B', 'I', 'H'])\n(2, ['E', 'B', 'G'])\n(2, ['G', 'H', 'B'])\n(2, ['F', 'G', 'E'])\n"}︡{"done":true}
︠dd85ca1a-0138-4b0a-b687-749c36fb06e2s︠

︡62deb5d2-3dda-46bb-83be-6d82550fac3d︡{"done":true}









