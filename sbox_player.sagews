︠80617944-1491-4f7e-8c9c-be71af4dbfdfs︠
#####################################################
# 1) FIELD ARITHMETIC                              ###
######################################################
############################################################
# Alphabet                                                 #
# A B C D E     F     G  H      I                          #
# 0 1 2 x x + 1 x + 2 2x 2x + 1 2x + 2                     #
############################################################

K.<x> = GF(3);
KT.<x> = K.extension(2)
#######################################################
## 2) TROIKA SUBSTITUTION BOXES                     ###
#######################################################

SBox = [x + 1, 1, x, 0, x + 2, 1, 2, 2*x, 2*x + 1]

InverseSBox=[2*x + 2, 2*x + 1, 0, x + 2, 0, x, x + 1, 1, 2]

#SBox = [["E","B","D"],["A","F","B"],["C","G","H"]]
#INVERSE IS [["I", "H", "A"],["F", "A", "D"], ["E", "B", "C"]]

#######################################################
## 3) TRANSLATE BETWEEN ALPHABET AND GF(3^2)        ###
#######################################################

def TranslateFromAlphabet(y):
    # INPUT: TROIKA CHAR || OUTPUT: POLYNOMIAL
    if (y == 'A'):
        return(0)
    elif (y == 'B'):
        return(1)
    elif(y == 'C'):
        return(2)
    elif(y == 'D'):
        return(x)
    elif(y == 'E'):
        return(x + 1)
    elif(y == 'F'):
        return(x + 2)
    elif(y=='G'):
        return(2*x)
    elif(y=='H'):
        return(2*x + 1)
    elif(y=='I'):
        return(2*x + 2)

def TranslateToAlphabet(y):
    # INPUT: POLYNOMIAL OR INTEGER || OUTPUT: TROIKA CHAR
    if (y == 0):
        return('A')
    elif (y == 1 or y == -8):
        return('B')
    elif(y == 2 or y == -7):
        return('C')
    elif(y == x or y == 3 or y == -6):
        return('D')
    elif(y == x + 1 or y == 4 or y == -5):
        return('E')
    elif(y == x + 2 or y == 5 or y == -4):
        return('F')
    elif(y == 2 * x or y == 6 or y == -3):
        return('G')
    elif(y == 2 * x + 1 or y == 7 or y == -2):
        return('H')
    elif(y == 2 * x + 2 or y == 8 or y == -1):
        return('I')
    else:
        print(y, "Invalid.")



#######################################################
## 5) S-BOX                                         ###
#######################################################

def split(phrase):
    # INPUT: STRING || OUTPUT: ARRAY OF CHARS
    phraseArray = []
    for i in range(len(phrase)):
        phraseArray.append(phrase[i])
    return phraseArray

    #######################################################
    ## A. ENCRYPTION                                    ###
    #######################################################

def SB(Z):
    # INPUT: ARRAY OF 3 TROIKA CHARS || OUTPUT: ARRAY OF 3 TROIKA CHARS
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(SBox[0]*Q + SBox[1]*R + SBox[2]*S)
    U = TranslateToAlphabet(SBox[3]*Q + SBox[4]*R + SBox[5]*S)
    V = TranslateToAlphabet(SBox[6]*Q + SBox[7]*R + SBox[8]*S)
    return([T, U, V])

def SBText(plaintext):
    # INPUT: STRING OF 54 TROIKA CHARS || OUTPUT: STRING OF 54 TROIKA CHARS
    if (len(plaintext) != 54):
        print("Please input a plaintext of length 54.")
    else:
        SBoxedTextArray = []
        SBoxedText = "";
        plaintextArray = split(plaintext)
        for i in range(0, 52, 3):
            trit = [plaintext[i], plaintext[i+1], plaintext[i+2]]
            SBTrit = SB(trit)
            for i in range(0, 3):
                SBoxedTextArray.append(SBTrit[i])
        for i in range(0, 54):
            SBoxedText = SBoxedText + SBoxedTextArray[i]
    return SBoxedText

    #######################################################
    ## B. DECRYPTION                                    ###
    #######################################################

def invSB(Z):
    # INPUT: ARRAY OF 3 TROIKA CHARS || OUTPUT: ARRAY OF 3 TROIKA CHARS
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(InverseSBox[0]*Q+InverseSBox[1]*R+InverseSBox[2]*S)
    U = TranslateToAlphabet(InverseSBox[3]*Q+InverseSBox[4]*R+InverseSBox[5]*S)
    V = TranslateToAlphabet(InverseSBox[6]*Q+InverseSBox[7]*R+InverseSBox[8]*S)
    return([T,U,V])

def invSBText(plaintext):
    # INPUT: STRING OF 54 TROIKA CHARS || OUTPUT: STRING OF 54 TROIKA CHARS
    if (len(plaintext) != 54):
        print("Please input a plaintext of length 54.")
    else:
        InvSBoxedTextArray = []
        InvSBoxedText = "";
        plaintextArray = split(plaintext)
        for i in range(0, 52, 3):
            trit = [plaintext[i], plaintext[i+1], plaintext[i+2]]
            invSBTrit = invSB(trit)
            for i in range(0, 3):
                InvSBoxedTextArray.append(invSBTrit[i])
        for i in range(0, 54):
            InvSBoxedText = InvSBoxedText + InvSBoxedTextArray[i]
    return InvSBoxedText

###########################################
                  # Look I can add#########
###########################################
def addr(string1, string2):
    s10 = TranslateFromAlphabet(string1[0])
    s11 = TranslateFromAlphabet(string1[1])
    s12 = TranslateFromAlphabet(string1[2])
    s20 = TranslateFromAlphabet(string2[0])
    s21 = TranslateFromAlphabet(string2[1])
    s22 = TranslateFromAlphabet(string2[2])
    sum0 = TranslateToAlphabet(s10 + s20)
    sum1 = TranslateToAlphabet(s11 + s21)
    sum2 = TranslateToAlphabet(s12 + s22)
    finalSum = [sum0, sum1, sum2]
    return  finalSum

def subr(string1, string2):
    s10 = TranslateFromAlphabet(string1[0])
    s11 = TranslateFromAlphabet(string1[1])
    s12 = TranslateFromAlphabet(string1[2])
    s20 = TranslateFromAlphabet(string2[0])
    s21 = TranslateFromAlphabet(string2[1])
    s22 = TranslateFromAlphabet(string2[2])
    sum0 = s10 - s20
    sum1 = s11 - s21
    sum2 = s12 - s22
    finalSum = [TranslateToAlphabet(sum0), TranslateToAlphabet(sum1), TranslateToAlphabet(sum2)]
    return  finalSum

def printpreDDT(x1,x2,x3):
    deltaX = [TranslateToAlphabet(x1), TranslateToAlphabet(x2), TranslateToAlphabet(x3)]
    change_list = []
    for i in range(0,9):
        for n in range(0,9):
            for j in range(0,9):
                out = SB(addr(deltaX, [TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))
                change_list.append((subr(out, SB([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))))
                print('[' + 'deltaX is' + str(deltaX)+ 'initial is' +str([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)])+ 'output is' + str(SB([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))+ 'deltaY is' + str(subr(out, SB([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))) + 'new Y is' + str(SB([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)])))

def preDDT(x1,x2,x3):
    deltaX = [TranslateToAlphabet(x1), TranslateToAlphabet(x2), TranslateToAlphabet(x3)]
    change_list = []
    for i in range(0,9):
        for n in range(0,9):
            for j in range(0,9):
                out = SB(addr(deltaX, [TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))
                change_list.append((subr(out, SB([TranslateToAlphabet(i),TranslateToAlphabet(n),TranslateToAlphabet(j)]))))
    return change_list

def maxValue(x1,x2,x3):
    dels = preDDT(x1,x2,x3)
    numList =[]
    thatNum = 0
    for i in range(len(dels)):
        numList.append(dels.count(dels[i]))
    thatNum = dels[numList.index(max(numList))]
    return thatNum, max(numList)

for i in range(0,9):
    for n in range(0,9):
        for j in range(0,9):
            deltaX = [TranslateToAlphabet(i), TranslateToAlphabet(n), TranslateToAlphabet(j)]
            print(deltaX, maxValue(i,n,j))
︡8e81f1fc-b97a-4537-aeaf-fb0ab0d17789︡{"stdout":"(['A', 'A', 'A'], (['A', 'A', 'A'], 729))"}︡{"stdout":"\n(['A', 'A', 'B'], (['D', 'B', 'H'], 576))"}︡{"stdout":"\n(['A', 'A', 'C'], (['G', 'C', 'F'], 441))"}︡{"stdout":"\n(['A', 'A', 'D'], (['E', 'D', 'C'], 567))"}︡{"stdout":"\n(['A', 'A', 'E'], (['H', 'E', 'G'], 729))"}︡{"stdout":"\n(['A', 'A', 'F'], (['B', 'F', 'E'], 648))"}︡{"stdout":"\n(['A', 'A', 'G'], (['I', 'G', 'B'], 648))"}︡{"stdout":"\n(['A', 'A', 'H'], (['C', 'H', 'I'], 567))"}︡{"stdout":"\n(['A', 'A', 'I'], (['F', 'I', 'D'], 729))"}︡{"stdout":"\n(['A', 'B', 'A'], (['B', 'F', 'G'], 576))"}︡{"stdout":"\n(['A', 'B', 'B'], (['E', 'D', 'E'], 576))"}︡{"stdout":"\n(['A', 'B', 'C'], (['H', 'E', 'C'], 392))"}︡{"stdout":"\n(['A', 'B', 'D'], (['F', 'I', 'I'], 648))"}︡{"stdout":"\n(['A', 'B', 'E'], (['I', 'G', 'D'], 648))"}︡{"stdout":"\n(['A', 'B', 'F'], (['C', 'H', 'B'], 441))"}︡{"stdout":"\n(['A', 'B', 'G'], (['G', 'C', 'H'], 504))"}︡{"stdout":"\n(['A', 'B', 'H'], (['A', 'A', 'F'], 648))"}︡{"stdout":"\n(['A', 'B', 'I'], (['D', 'B', 'A'], 576))"}︡{"stdout":"\n(['A', 'C', 'A'], (['C', 'H', 'D'], 441))"}︡{"stdout":"\n(['A', 'C', 'B'], (['F', 'I', 'B'], 448))"}︡{"stdout":"\n(['A', 'C', 'C'], (['I', 'G', 'I'], 441))"}︡{"stdout":"\n(['A', 'C', 'D'], (['D', 'B', 'F'], 504))"}︡{"stdout":"\n(['A', 'C', 'E'], (['G', 'C', 'A'], 441))"}︡{"stdout":"\n(['A', 'C', 'F'], (['A', 'A', 'H'], 567))"}︡{"stdout":"\n(['A', 'C', 'G'], (['H', 'E', 'E'], 567))"}︡{"stdout":"\n(['A', 'C', 'H'], (['B', 'F', 'C'], 387))"}︡{"stdout":"\n(['A', 'C', 'I'], (['E', 'D', 'G'], 567))"}︡{"stdout":"\n(['A', 'D', 'A'], (['D', 'B', 'I'], 648))"}︡{"stdout":"\n(['A', 'D', 'B'], (['G', 'C', 'D'], 504))"}︡{"stdout":"\n(['A', 'D', 'C'], (['A', 'A', 'B'], 504))"}︡{"stdout":"\n(['A', 'D', 'D'], (['H', 'E', 'H'], 729))"}︡{"stdout":"\n(['A', 'D', 'E'], (['B', 'F', 'F'], 648))"}︡{"stdout":"\n(['A', 'D', 'F'], (['E', 'D', 'A'], 729))"}︡{"stdout":"\n(['A', 'D', 'G'], (['C', 'H', 'G'], 567))"}︡{"stdout":"\n(['A', 'D', 'H'], (['F', 'I', 'E'], 729))"}︡{"stdout":"\n(['A', 'D', 'I'], (['I', 'G', 'C'], 567))"}︡{"stdout":"\n(['A', 'E', 'A'], (['E', 'D', 'F'], 729))"}︡{"stdout":"\n(['A', 'E', 'B'], (['H', 'E', 'A'], 648))"}︡{"stdout":"\n(['A', 'E', 'C'], (['B', 'F', 'H'], 504))"}︡{"stdout":"\n(['A', 'E', 'D'], (['I', 'G', 'E'], 729))"}︡{"stdout":"\n(['A', 'E', 'E'], (['C', 'H', 'C'], 441))"}︡{"stdout":"\n(['A', 'E', 'F'], (['F', 'I', 'G'], 729))"}︡{"stdout":"\n(['A', 'E', 'G'], (['A', 'A', 'D'], 729))"}︡{"stdout":"\n(['A', 'E', 'H'], (['D', 'B', 'B'], 576))"}︡{"stdout":"\n(['A', 'E', 'I'], (['G', 'C', 'I'], 567))"}︡{"stdout":"\n(['A', 'F', 'A'], (['F', 'I', 'C'], 567))"}︡{"stdout":"\n(['A', 'F', 'B'], (['I', 'G', 'G'], 648))"}︡{"stdout":"\n(['A', 'F', 'C'], (['C', 'H', 'E'], 441))"}︡{"stdout":"\n(['A', 'F', 'D'], (['G', 'C', 'B'], 504))"}︡{"stdout":"\n(['A', 'F', 'E'], (['A', 'A', 'I'], 729))"}︡{"stdout":"\n(['A', 'F', 'F'], (['D', 'B', 'D'], 648))"}︡{"stdout":"\n(['A', 'F', 'G'], (['B', 'F', 'A'], 648))"}︡{"stdout":"\n(['A', 'F', 'H'], (['E', 'D', 'H'], 729))"}︡{"stdout":"\n(['A', 'F', 'I'], (['H', 'E', 'F'], 729))"}︡{"stdout":"\n(['A', 'G', 'A'], (['G', 'C', 'E'], 567))"}︡{"stdout":"\n(['A', 'G', 'B'], (['A', 'A', 'C'], 504))"}︡{"stdout":"\n(['A', 'G', 'C'], (['D', 'B', 'G'], 504))"}︡{"stdout":"\n(['A', 'G', 'D'], (['B', 'F', 'D'], 648))"}︡{"stdout":"\n(['A', 'G', 'E'], (['E', 'D', 'B'], 648))"}︡{"stdout":"\n(['A', 'G', 'F'], (['H', 'E', 'I'], 729))"}︡{"stdout":"\n(['A', 'G', 'G'], (['F', 'I', 'F'], 729))"}︡{"stdout":"\n(['A', 'G', 'H'], (['I', 'G', 'A'], 729))"}︡{"stdout":"\n(['A', 'G', 'I'], (['C', 'H', 'H'], 567))"}︡{"stdout":"\n(['A', 'H', 'A'], (['H', 'E', 'B'], 648))"}︡{"stdout":"\n(['A', 'H', 'B'], (['B', 'F', 'I'], 576))"}︡{"stdout":"\n(['A', 'H', 'C'], (['E', 'D', 'D'], 567))"}︡{"stdout":"\n(['A', 'H', 'D'], (['C', 'H', 'A'], 567))"}︡{"stdout":"\n(['A', 'H', 'E'], (['F', 'I', 'H'], 729))"}︡{"stdout":"\n(['A', 'H', 'F'], (['I', 'G', 'F'], 729))"}︡{"stdout":"\n(['A', 'H', 'G'], (['D', 'B', 'C'], 504))"}︡{"stdout":"\n(['A', 'H', 'H'], (['G', 'C', 'G'], 567))"}︡{"stdout":"\n(['A', 'H', 'I'], (['A', 'A', 'E'], 729))"}︡{"stdout":"\n(['A', 'I', 'A'], (['I', 'G', 'H'], 729))"}︡{"stdout":"\n(['A', 'I', 'B'], (['C', 'H', 'F'], 504))"}︡{"stdout":"\n(['A', 'I', 'C'], (['F', 'I', 'A'], 567))"}︡{"stdout":"\n(['A', 'I', 'D'], (['A', 'A', 'G'], 729))"}︡{"stdout":"\n(['A', 'I', 'E'], (['D', 'B', 'E'], 648))"}︡{"stdout":"\n(['A', 'I', 'F'], (['G', 'C', 'C'], 441))"}︡{"stdout":"\n(['A', 'I', 'G'], (['E', 'D', 'I'], 729))"}︡{"stdout":"\n(['A', 'I', 'H'], (['H', 'E', 'D'], 729))"}︡{"stdout":"\n(['A', 'I', 'I'], (['B', 'F', 'B'], 576))"}︡{"stdout":"\n(['B', 'A', 'A'], (['E', 'A', 'C'], 504))"}︡{"stdout":"\n(['B', 'A', 'B'], (['H', 'B', 'G'], 512))"}︡{"stdout":"\n(['B', 'A', 'C'], (['B', 'C', 'E'], 343))"}︡{"stdout":"\n(['B', 'A', 'D'], (['I', 'D', 'B'], 576))"}︡{"stdout":"\n(['B', 'A', 'E'], (['C', 'E', 'I'], 504))"}︡{"stdout":"\n(['B', 'A', 'F'], (['F', 'F', 'D'], 648))"}︡{"stdout":"\n(['B', 'A', 'G'], (['A', 'G', 'A'], 648))"}︡{"stdout":"\n(['B', 'A', 'H'], (['D', 'H', 'H'], 648))"}︡{"stdout":"\n(['B', 'A', 'I'], (['G', 'I', 'F'], 648))"}︡{"stdout":"\n(['B', 'B', 'A'], (['F', 'F', 'I'], 576))"}︡{"stdout":"\n(['B', 'B', 'B'], (['I', 'D', 'D'], 512))"}︡{"stdout":"\n(['B', 'B', 'C'], (['C', 'E', 'B'], 306))"}︡{"stdout":"\n(['B', 'B', 'D'], (['G', 'I', 'H'], 576))"}︡{"stdout":"\n(['B', 'B', 'E'], (['A', 'G', 'F'], 576))"}︡{"stdout":"\n(['B', 'B', 'F'], (['D', 'H', 'A'], 576))"}︡{"stdout":"\n(['B', 'B', 'G'], (['B', 'C', 'G'], 392))"}︡{"stdout":"\n(['B', 'B', 'H'], (['E', 'A', 'E'], 576))"}︡{"stdout":"\n(['B', 'B', 'I'], (['H', 'B', 'C'], 399))"}︡{"stdout":"\n(['B', 'C', 'A'], (['D', 'H', 'F'], 504))"}︡{"stdout":"\n(['B', 'C', 'B'], (['G', 'I', 'A'], 448))"}︡{"stdout":"\n(['B', 'C', 'C'], (['A', 'G', 'H'], 392))"}︡{"stdout":"\n(['B', 'C', 'D'], (['H', 'B', 'E'], 448))"}︡{"stdout":"\n(['B', 'C', 'E'], (['B', 'C', 'C'], 264))"}︡{"stdout":"\n(['B', 'C', 'F'], (['E', 'A', 'G'], 504))"}︡{"stdout":"\n(['B', 'C', 'G'], (['C', 'E', 'D'], 392))"}︡{"stdout":"\n(['B', 'C', 'H'], (['F', 'F', 'B'], 448))"}︡{"stdout":"\n(['B', 'C', 'I'], (['I', 'D', 'I'], 504))"}︡{"stdout":"\n(['B', 'D', 'A'], (['H', 'B', 'H'], 576))"}︡{"stdout":"\n(['B', 'D', 'B'], (['B', 'C', 'F'], 392))"}︡{"stdout":"\n(['B', 'D', 'C'], (['E', 'A', 'A'], 504))"}︡{"stdout":"\n(['B', 'D', 'D'], (['C', 'E', 'G'], 504))"}︡{"stdout":"\n(['B', 'D', 'E'], (['F', 'F', 'E'], 648))"}︡{"stdout":"\n(['B', 'D', 'F'], (['I', 'D', 'C'], 504))"}︡{"stdout":"\n(['B', 'D', 'G'], (['D', 'H', 'I'], 648))"}︡{"stdout":"\n(['B', 'D', 'H'], (['G', 'I', 'D'], 648))"}︡{"stdout":"\n(['B', 'D', 'I'], (['A', 'G', 'B'], 576))"}︡{"stdout":"\n(['B', 'E', 'A'], (['I', 'D', 'E'], 648))"}︡{"stdout":"\n(['B', 'E', 'B'], (['C', 'E', 'C'], 349))"}︡{"stdout":"\n(['B', 'E', 'C'], (['F', 'F', 'G'], 504))"}︡{"stdout":"\n(['B', 'E', 'D'], (['A', 'G', 'D'], 648))"}︡{"stdout":"\n(['B', 'E', 'E'], (['D', 'H', 'B'], 576))"}︡{"stdout":"\n(['B', 'E', 'F'], (['G', 'I', 'I'], 648))"}︡{"stdout":"\n(['B', 'E', 'G'], (['E', 'A', 'F'], 648))"}︡{"stdout":"\n(['B', 'E', 'H'], (['H', 'B', 'A'], 576))"}︡{"stdout":"\n(['B', 'E', 'I'], (['B', 'C', 'H'], 441))"}︡{"stdout":"\n(['B', 'F', 'A'], (['G', 'I', 'B'], 576))"}︡{"stdout":"\n(['B', 'F', 'B'], (['A', 'G', 'I'], 576))"}︡{"stdout":"\n(['B', 'F', 'C'], (['D', 'H', 'D'], 504))"}︡{"stdout":"\n(['B', 'F', 'D'], (['B', 'C', 'A'], 441))"}︡{"stdout":"\n(['B', 'F', 'E'], (['E', 'A', 'H'], 648))"}︡{"stdout":"\n(['B', 'F', 'F'], (['H', 'B', 'F'], 576))"}︡{"stdout":"\n(['B', 'F', 'G'], (['F', 'F', 'C'], 504))"}︡{"stdout":"\n(['B', 'F', 'H'], (['I', 'D', 'G'], 648))"}︡{"stdout":"\n(['B', 'F', 'I'], (['C', 'E', 'E'], 504))"}︡{"stdout":"\n(['B', 'G', 'A'], (['B', 'C', 'D'], 441))"}︡{"stdout":"\n(['B', 'G', 'B'], (['E', 'A', 'B'], 512))"}︡{"stdout":"\n(['B', 'G', 'C'], (['H', 'B', 'I'], 448))"}︡{"stdout":"\n(['B', 'G', 'D'], (['F', 'F', 'F'], 648))"}︡{"stdout":"\n(['B', 'G', 'E'], (['I', 'D', 'A'], 648))"}︡{"stdout":"\n(['B', 'G', 'F'], (['C', 'E', 'H'], 504))"}︡{"stdout":"\n(['B', 'G', 'G'], (['G', 'I', 'E'], 648))"}︡{"stdout":"\n(['B', 'G', 'H'], (['A', 'G', 'C'], 504))"}︡{"stdout":"\n(['B', 'G', 'I'], (['D', 'H', 'G'], 648))"}︡{"stdout":"\n(['B', 'H', 'A'], (['C', 'E', 'A'], 504))"}︡{"stdout":"\n(['B', 'H', 'B'], (['F', 'F', 'H'], 576))"}︡{"stdout":"\n(['B', 'H', 'C'], (['I', 'D', 'F'], 504))"}︡{"stdout":"\n(['B', 'H', 'D'], (['D', 'H', 'C'], 504))"}︡{"stdout":"\n(['B', 'H', 'E'], (['G', 'I', 'G'], 648))"}︡{"stdout":"\n(['B', 'H', 'F'], (['A', 'G', 'E'], 648))"}︡{"stdout":"\n(['B', 'H', 'G'], (['H', 'B', 'B'], 512))"}︡{"stdout":"\n(['B', 'H', 'H'], (['B', 'C', 'I'], 441))"}︡{"stdout":"\n(['B', 'H', 'I'], (['E', 'A', 'D'], 648))"}︡{"stdout":"\n(['B', 'I', 'A'], (['A', 'G', 'G'], 648))"}︡{"stdout":"\n(['B', 'I', 'B'], (['D', 'H', 'E'], 576))"}︡{"stdout":"\n(['B', 'I', 'C'], (['G', 'I', 'C'], 392))"}︡{"stdout":"\n(['B', 'I', 'D'], (['E', 'A', 'I'], 648))"}︡{"stdout":"\n(['B', 'I', 'E'], (['H', 'B', 'D'], 576))"}︡{"stdout":"\n(['B', 'I', 'F'], (['B', 'C', 'B'], 392))"}︡{"stdout":"\n(['B', 'I', 'G'], (['I', 'D', 'H'], 648))"}︡{"stdout":"\n(['B', 'I', 'H'], (['C', 'E', 'F'], 504))"}︡{"stdout":"\n(['B', 'I', 'I'], (['F', 'F', 'A'], 648))"}︡{"stdout":"\n(['C', 'A', 'A'], (['I', 'A', 'B'], 504))"}︡{"stdout":"\n(['C', 'A', 'B'], (['C', 'B', 'I'], 344))"}︡{"stdout":"\n(['C', 'A', 'C'], (['F', 'C', 'D'], 343))"}︡{"stdout":"\n(['C', 'A', 'D'], (['A', 'D', 'A'], 567))"}︡{"stdout":"\n(['C', 'A', 'E'], (['D', 'E', 'H'], 567))"}︡{"stdout":"\n(['C', 'A', 'F'], (['G', 'F', 'F'], 567))"}︡{"stdout":"\n(['C', 'A', 'G'], (['E', 'G', 'C'], 441))"}︡{"stdout":"\n(['C', 'A', 'H'], (['H', 'H', 'G'], 567))"}︡{"stdout":"\n(['C', 'A', 'I'], (['B', 'I', 'E'], 504))"}︡{"stdout":"\n(['C', 'B', 'A'], (['G', 'F', 'H'], 504))"}︡{"stdout":"\n(['C', 'B', 'B'], (['A', 'D', 'F'], 448))"}︡{"stdout":"\n(['C', 'B', 'C'], (['D', 'E', 'A'], 392))"}︡{"stdout":"\n(['C', 'B', 'D'], (['B', 'I', 'G'], 448))"}︡{"stdout":"\n(['C', 'B', 'E'], (['E', 'G', 'E'], 504))"}︡{"stdout":"\n(['C', 'B', 'F'], (['H', 'H', 'C'], 392))"}︡{"stdout":"\n(['C', 'B', 'G'], (['F', 'C', 'I'], 392))"}︡{"stdout":"\n(['C', 'B', 'H'], (['I', 'A', 'D'], 504))"}︡{"stdout":"\n(['C', 'B', 'I'], (['C', 'B', 'B'], 301))"}︡{"stdout":"\n(['C', 'C', 'A'], (['H', 'H', 'E'], 441))"}︡{"stdout":"\n(['C', 'C', 'B'], (['B', 'I', 'C'], 268))"}︡{"stdout":"\n(['C', 'C', 'C'], (['E', 'G', 'G'], 343))"}︡{"stdout":"\n(['C', 'C', 'D'], (['C', 'B', 'D'], 301))"}︡{"stdout":"\n(['C', 'C', 'E'], (['F', 'C', 'B'], 306))"}︡{"stdout":"\n(['C', 'C', 'F'], (['I', 'A', 'I'], 441))"}︡{"stdout":"\n(['C', 'C', 'G'], (['D', 'E', 'F'], 441))"}︡{"stdout":"\n(['C', 'C', 'H'], (['G', 'F', 'A'], 441))"}︡{"stdout":"\n(['C', 'C', 'I'], (['A', 'D', 'H'], 441))"}︡{"stdout":"\n(['C', 'D', 'A'], (['C', 'B', 'G'], 387))"}︡{"stdout":"\n(['C', 'D', 'B'], (['F', 'C', 'E'], 392))"}︡{"stdout":"\n(['C', 'D', 'C'], (['I', 'A', 'C'], 343))"}︡{"stdout":"\n(['C', 'D', 'D'], (['D', 'E', 'I'], 567))"}︡{"stdout":"\n(['C', 'D', 'E'], (['G', 'F', 'D'], 567))"}︡{"stdout":"\n(['C', 'D', 'F'], (['A', 'D', 'B'], 504))"}︡{"stdout":"\n(['C', 'D', 'G'], (['H', 'H', 'H'], 567))"}︡{"stdout":"\n(['C', 'D', 'H'], (['B', 'I', 'F'], 504))"}︡{"stdout":"\n(['C', 'D', 'I'], (['E', 'G', 'A'], 567))"}︡{"stdout":"\n(['C', 'E', 'A'], (['A', 'D', 'D'], 567))"}︡{"stdout":"\n(['C', 'E', 'B'], (['D', 'E', 'B'], 448))"}︡{"stdout":"\n(['C', 'E', 'C'], (['G', 'F', 'I'], 441))"}︡{"stdout":"\n(['C', 'E', 'D'], (['E', 'G', 'F'], 567))"}︡{"stdout":"\n(['C', 'E', 'E'], (['H', 'H', 'A'], 567))"}︡{"stdout":"\n(['C', 'E', 'F'], (['B', 'I', 'H'], 504))"}︡{"stdout":"\n(['C', 'E', 'G'], (['I', 'A', 'E'], 567))"}︡{"stdout":"\n(['C', 'E', 'H'], (['C', 'B', 'C'], 301))"}︡{"stdout":"\n(['C', 'E', 'I'], (['F', 'C', 'G'], 441))"}︡{"stdout":"\n(['C', 'F', 'A'], (['B', 'I', 'A'], 504))"}︡{"stdout":"\n(['C', 'F', 'B'], (['E', 'G', 'H'], 504))"}︡{"stdout":"\n(['C', 'F', 'C'], (['H', 'H', 'F'], 441))"}︡{"stdout":"\n(['C', 'F', 'D'], (['F', 'C', 'C'], 343))"}︡{"stdout":"\n(['C', 'F', 'E'], (['I', 'A', 'G'], 567))"}︡{"stdout":"\n(['C', 'F', 'F'], (['C', 'B', 'E'], 387))"}︡{"stdout":"\n(['C', 'F', 'G'], (['G', 'F', 'B'], 504))"}︡{"stdout":"\n(['C', 'F', 'H'], (['A', 'D', 'I'], 567))"}︡{"stdout":"\n(['C', 'F', 'I'], (['D', 'E', 'D'], 567))"}︡{"stdout":"\n(['C', 'G', 'A'], (['F', 'C', 'F'], 441))"}︡{"stdout":"\n(['C', 'G', 'B'], (['I', 'A', 'A'], 504))"}︡{"stdout":"\n(['C', 'G', 'C'], (['C', 'B', 'H'], 301))"}︡{"stdout":"\n(['C', 'G', 'D'], (['G', 'F', 'E'], 567))"}︡{"stdout":"\n(['C', 'G', 'E'], (['A', 'D', 'C'], 441))"}︡{"stdout":"\n(['C', 'G', 'F'], (['D', 'E', 'G'], 567))"}︡{"stdout":"\n(['C', 'G', 'G'], (['B', 'I', 'D'], 504))"}︡{"stdout":"\n(['C', 'G', 'H'], (['E', 'G', 'B'], 504))"}︡{"stdout":"\n(['C', 'G', 'I'], (['H', 'H', 'I'], 567))"}︡{"stdout":"\n(['C', 'H', 'A'], (['D', 'E', 'C'], 441))"}︡{"stdout":"\n(['C', 'H', 'B'], (['G', 'F', 'G'], 504))"}︡{"stdout":"\n(['C', 'H', 'C'], (['A', 'D', 'E'], 441))"}︡{"stdout":"\n(['C', 'H', 'D'], (['H', 'H', 'B'], 504))"}︡{"stdout":"\n(['C', 'H', 'E'], (['B', 'I', 'I'], 504))"}︡{"stdout":"\n(['C', 'H', 'F'], (['E', 'G', 'D'], 567))"}︡{"stdout":"\n(['C', 'H', 'G'], (['C', 'B', 'A'], 387))"}︡{"stdout":"\n(['C', 'H', 'H'], (['F', 'C', 'H'], 441))"}︡{"stdout":"\n(['C', 'H', 'I'], (['I', 'A', 'F'], 567))"}︡{"stdout":"\n(['C', 'I', 'A'], (['E', 'G', 'I'], 567))"}︡{"stdout":"\n(['C', 'I', 'B'], (['H', 'H', 'D'], 504))"}︡{"stdout":"\n(['C', 'I', 'C'], (['B', 'I', 'B'], 349))"}︡{"stdout":"\n(['C', 'I', 'D'], (['I', 'A', 'H'], 567))"}︡{"stdout":"\n(['C', 'I', 'E'], (['C', 'B', 'F'], 387))"}︡{"stdout":"\n(['C', 'I', 'F'], (['F', 'C', 'A'], 441))"}︡{"stdout":"\n(['C', 'I', 'G'], (['A', 'D', 'G'], 567))"}︡{"stdout":"\n(['C', 'I', 'H'], (['D', 'E', 'E'], 567))"}︡{"stdout":"\n(['C', 'I', 'I'], (['G', 'F', 'C'], 441))"}︡{"stdout":"\n(['D', 'A', 'A'], (['H', 'A', 'G'], 729))"}︡{"stdout":"\n(['D', 'A', 'B'], (['B', 'B', 'E'], 512))"}︡{"stdout":"\n(['D', 'A', 'C'], (['E', 'C', 'C'], 343))"}︡{"stdout":"\n(['D', 'A', 'D'], (['C', 'D', 'I'], 567))"}︡{"stdout":"\n(['D', 'A', 'E'], (['F', 'E', 'D'], 729))"}︡{"stdout":"\n(['D', 'A', 'F'], (['I', 'F', 'B'], 648))"}︡{"stdout":"\n(['D', 'A', 'G'], (['D', 'G', 'H'], 729))"}︡{"stdout":"\n(['D', 'A', 'H'], (['G', 'H', 'F'], 729))"}︡{"stdout":"\n(['D', 'A', 'I'], (['A', 'I', 'A'], 729))"}︡{"stdout":"\n(['D', 'B', 'A'], (['I', 'F', 'D'], 648))"}︡{"stdout":"\n(['D', 'B', 'B'], (['C', 'D', 'B'], 392))"}︡{"stdout":"\n(['D', 'B', 'C'], (['F', 'E', 'I'], 504))"}︡{"stdout":"\n(['D', 'B', 'D'], (['A', 'I', 'F'], 648))"}︡{"done":true,"once":false,"stderr":"\nToo many output messages: 257 (at most 256 per cell -- type 'smc?' to learn how to raise this limit): attempting to terminate..."}
︠15df6566-e12d-4090-b92e-622b7631e0e2s︠

︡94ee4475-956e-44dc-a0d1-c838666ce152︡{"done":true}
︠0f9c00f0-e2f7-4172-ab93-2a38c86f3ceas︠

︡8d6a8118-f062-485f-ab17-0a3c0b94caa3︡{"done":true}
︠19f92d0d-9d67-488d-872e-1acc8809896as︠

︡470d8fae-0ccd-4ba1-823c-9aad11248a58︡{"done":true}









