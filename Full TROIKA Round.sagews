︠8f3eba4a-066c-46ad-971f-a4c7759f01a9s︠
######################################################
# 1) Establish the field arithmetic.               ###
######################################################
############################################################
# Alphabet                                                 #
# A B C D E     F     G  H      I                          #
# 0 1 2 x x + 1 x + 2 2x 2x + 1 2x + 2                     #
############################################################

K.<x> = GF(3);
KT.<x> = K.extension(2)

#######################################################
## 2) The TROIKA substitution boxes                 ###
#######################################################

SBox = [x + 1, 1, x, 0, x + 2, 1, 2, 2*x, 2*x + 1]

InverseSBox=[2*x + 2, 2*x + 1, 0, x + 2, 0, x, x + 1, 1, 2]

#SBox = [["E","B","D"],["A","F","B"],["C","G","H"]]
#INVERSE IS [["I", "H", "A"],["F", "A", "D"], ["E", "B", "C"]]

#######################################################
## 3) Translate between alphabet and GF(3^2)        ###
#######################################################

def TranslateFromAlphabet(y):
    if (y == 'A'):
        #print('From TranslateFromAlphabet, for A',y)
        return(0)
    elif (y == 'B'):
        #print('From TranslateFromAlphabet, for B',y)
        return(1)
    elif(y == 'C'):
        #print('From TranslateFromAlphabet, for C',y)
        return(2)
    elif(y == 'D'):
        #print('From TranslateFromAlphabet, for D',y)
        return(x)
    elif(y == 'E'):
        #print('From TranslateFromAlphabet, for E',y)
        return(x + 1)
    elif(y == 'F'):
        #print('From TranslateFromAlphabet, for F',y)
        return(x + 2)
    elif(y=='G'):
        #print('From TranslateFromAlphabet, for G',y)
        return(2*x)
    elif(y=='H'):
        #print('From TranslateFromAlphabet, for H',y)
        return(2*x + 1)
    elif(y=='I'):
        #print('From TranslateFromAlphabet, for I',y)
        return(2*x + 2)

def TranslateToAlphabet(y):
    if (y == 0):
        return('A')
    elif (y == 1):
        return('B')
    elif(y == 2):
        return('C')
    elif(y == x or y == 3):
        return('D')
    elif(y == x + 1 or y == 4):
        return('E')
    elif(y == x + 2 or y == 5):
        return('F')
    elif(y == 2 * x or y == 6):
        return('G')
    elif(y == 2 * x + 1 or y == 7):
        return('H')
    elif(y == 2 * x + 2 or y == 8):
        return('I')

#######################################################
## 4) SBOX                                          ###
#######################################################

def SB(Z):
    Q = TranslateFromAlphabet(Z[0])
    R = TranslateFromAlphabet(Z[1])
    S = TranslateFromAlphabet(Z[2])
    T = TranslateToAlphabet(SBox[0]*Q + SBox[1]*R + SBox[2]*S)
    U = TranslateToAlphabet(SBox[3]*Q + SBox[4]*R + SBox[5]*S)
    V = TranslateToAlphabet(SBox[6]*Q + SBox[7]*R + SBox[8]*S)
    return([T, U, V])

def SBKey(key):
    Z = [key[0], key[1], key[2]]
    Y = SB(Z)
    return Y + key[3:]

##########################################################
## 4) P-LAYER                                          ###
##########################################################

def pLayer(PT):
    k=len(PT)
    Q=''
    for j in range(k): #(k/3):
        Q = Q + PT[(7*j+3) % k]
    return(Q)

#######################################################
## 5) KEY UPDATE                                    ###
#######################################################

    #######################################################
    ## 5a) Key Generation                               ###
    #######################################################

def generateKeyA():
    key = []
    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
    for i in range(66):
        #key.append(alphabet[randint(0,8)])
        key.append(alphabet[0])
    return key

    #######################################################
    ## 5b) Key Chop                                     ###
    #######################################################

def chopKey(key):
    firstpart = key[:53]
    middlepart = key[53:]
    newkey = middlepart + firstpart
    return newkey

    #######################################################
    ## 5c) RoundCounter                                 ###
    #######################################################

def incrementRoundCounter(k):
    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
    roundCounter = []
    if (k < 9):
        roundCounter = ['A', 'A', alphabet[k]]
    elif (k < 81):
        second = int(k / 9)
        last = k % 9
        roundCounter = ['A', alphabet[second], alphabet[last]]
    elif(k < 729):
        third = int(k / 81)
        second = int((k - (third * 81)) / 9)
        first = k % 9
        roundCounter = [alphabet[third], alphabet[second], alphabet[first]]
    else:
        print("The number of rounds exceeds 81 and is not suitable for TROIKA.")
    return roundCounter


    #######################################################
    ## 5d) Adds RoundCounter                            ###
    #######################################################

def addRoundCounter(key, roundCounter):
    a1 = TranslateFromAlphabet(key[51])
    b1 = TranslateFromAlphabet(key[52])
    c1 = TranslateFromAlphabet(key[53])
    a2 = TranslateFromAlphabet(roundCounter[0])
    b2 = TranslateFromAlphabet(roundCounter[1])
    c2 = TranslateFromAlphabet(roundCounter[2])
    sumA = TranslateToAlphabet(a1 + a2)
    sumB = TranslateToAlphabet(b1 + b2)
    sumC = TranslateToAlphabet(c1 + c2)
    summed = [sumA, sumB, sumC]
    return key[:51] + summed + key[54:]

    #######################################################
    ## 5e) Key Update                                   ###
    #######################################################

def roundKeyGenerator(key, round):
    roundCounter = incrementRoundCounter(round)
    sBoxedKey = SBKey(key)
    addedKey = addRoundCounter(sBoxedKey, roundCounter)
    choppedKey = chopKey(addedKey)
    return choppedKey

#######################################################
## 6) TROIKA ENCRYPTION FINAL SECTIONS              ###
#######################################################

plaintext = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB"
key = generateKeyA()

# plaintext

def split(phrase):
    phraseArray = []
    for i in range(len(phrase)):
        phraseArray.append(phrase[i])
    return phraseArray

def addRoundKey(plaintext, key):
    if ((len(plaintext) != 54) or (len(key) != 54)):
        print("Please input a plaintext and key of length 54.")
    else:
        finalText = ""
        for i in range(54):
            charSum = TranslateToAlphabet(TranslateFromAlphabet(plaintext[i]) + TranslateFromAlphabet(key[i]))
            finalText = finalText + charSum
        return finalText

# plaintext = feedIntoAddRoundKey(plaintext, key)
# plaintext

def feedIntoSBox(plaintext):
    if (len(plaintext) != 54):
        print("Please input a plaintext of length 54.")
    else:
        SBoxedTextArray = []
        SBoxedText = "";
        plaintextArray = split(plaintext)
        for i in range(0, 52, 3):
            trio = [plaintext[i], plaintext[i+1], plaintext[i+2]]
            SBoxedTrit = SB(trio)
            for i in range(0, 3):
                SBoxedTextArray.append(SBoxedTrit[i])
        for i in range(0, 54):
            SBoxedText = SBoxedText + SBoxedTextArray[i]
    return SBoxedText

# plaintext = feedIntoSBox(plaintext)
# plaintext

def feedIntoPLayer(plaintext):
    if (len(plaintext) != 54):
        print("Please input a plaintext of length 54.")
    else:
        return pLayer(plaintext)

# plaintext = feedIntoPLayer(plaintext)
# plaintext

def SBoxPLayer(plaintext):
    sBoxed = feedIntoSBox(plaintext)
    pLayered = feedIntoPLayer(plaintext)
    return pLayered


#######################################################
## 7) FULL TROIKA ENCRYPTION                        ###
#######################################################

def performTROIKA(plaintext, key):
    # round 1
    plaintext = addRoundKey(plaintext, key[:54])
    # round 2-22
    for i in range(2,23):
        key = 
        plaintext = SBoxPLayer(plaintext)
        roundKey = roundKeyGenerator(key, i)
        plaintext = addRoundKey(plaintext, roundKey[:54])
    # round 23
    lastKey = roundKeyGenerator(key, 23)
    encryptedText = addRoundKey(plaintext, lastKey[:54])
    return encryptedText

performTROIKA(plaintext, key)

︡64e2e0a3-7c85-478d-b8fe-f3b599bd2942︡{"stderr":"Error in lines 147-156\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1191, in execute\n    flags=compile_flags), namespace, locals)\n  File \"<string>\", line 4\n    key =\n         ^\nSyntaxError: invalid syntax\n"}︡{"done":true}









