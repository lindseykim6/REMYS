︠154be179-b16b-45a0-83cb-3b5ae09442f1︠

︡a9aad363-8b2a-48a9-baa6-1fb931667a07︡
︠9151b72f-90cd-4c27-86fa-a2f499d1e7cfs︠
######################################################
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
    else:
        print(y, "Invalid.")


#######################################################
## 4) ADD ROUND KEY                                 ###
#######################################################

    #######################################################
    ## A. ENCRYPTION                                    ###
    #######################################################

def addRoundKey(plaintext, roundKey):
    # INPUT: PLAINTEXT STRING OF 54 TROIKA CHARS & KEY STRING OF 54 TROIKA CHARS || OUTPUT: TRO-ED STRING OF 54 TROIKA CHARS
    if ((len(plaintext) != 54) or (len(roundKey) != 54)):
        print("Please input a plaintext and round key of length 54.")
    else:
        troText = ""
        for i in range(54):
            charSum = TranslateToAlphabet(TranslateFromAlphabet(plaintext[i]) + TranslateFromAlphabet(roundKey[i]))
            troText = troText + charSum
        return troText

    #######################################################
    ## A. DECRYPTION                                    ###
    #######################################################

def subtractRoundKey(troText, roundKey):
    # INPUT: TRO-ED STRING OF 54 TROIKA CHARS & KEY STRING OF 54 TROIKA CHARS || OUTPUT: PLAINTEXT STRING OF 54 TROIKA CHARS
    if ((len(troText) != 54) or (len(roundKey) != 54)):
        print("Please input a text and round key of length 54.")
    else:
        revTroText = ""
        print(troText)
        for i in range(54):
            print(TranslateFromAlphabet(troText[i]))
            print(TranslateFromAlphabet(roundKey[i]))
            charDiff = TranslateFromAlphabet(troText[i]) - TranslateFromAlphabet(roundKey[i]
            if(charDiff == -2):
                 charDiff = 6 #!!!!!!!!!!!!!!!
            charDiffT = TranslateToAlphabet(charDiff)
            print(i, charDiffT)
            revTroText = revTroText + charDiffT
        return revTroText

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


##########################################################
## 6) P-LAYER                                          ###
##########################################################

    #######################################################
    ## A. ENCRYPTION                                    ###
    #######################################################

def pLayer(plaintext):
    # INPUT: STRING OF LENGTH 54 || OUTPUT: STRING OF LENGTH 54
    k = len(plaintext)
    Q = ''
    for j in range(k):
        Q = Q + plaintext[(7 * j + 3) % k]
    return(Q)

    #######################################################
    ## B. DECRYPTION                                    ###
    #######################################################

def pdeLayer(plaintext):
    # INPUT: STRING OF LENGTH 54 || OUTPUT: STRING OF LENGTH 54
    k = len(plaintext)
    Q = ''
    for j in range(k):
        Q = Q + plaintext[((1 / 7) * (j - 3)) % k]
    return(Q)

#######################################################
## 7) S BOX & P LAYER || PERMUTATION                ###
#######################################################

    #######################################################
    ## A. ENCRYPTION                                    ###
    #######################################################

def SBoxPLayer(plaintext):
    # INPUT: STRING OF LENGTH 54 || OUTPUT: STRING OF LENGTH 54
    sBoxed = SBText(plaintext)
    pLayered = pLayer(plaintext)
    return pLayered

    #######################################################
    ## B. DECRYPTION                                    ###
    #######################################################

def invSBoxPLayer(plaintext):
    invsBoxed = invSBText(plaintext)
    pdeLayered = pdeLayer(plaintext)
    return pdeLayered


#######################################################
## 8) KEY ANALYSIS                                  ###
#######################################################

# NOTE: Key is read in the form [k_65, k_64, k_63, ... , k_1, k_0].

    #######################################################
    ## A. GENERATION                                    ###
    #######################################################

def generateAKey():
    # OUTPUT: ARRAY OF 54 A'S
    key = []
    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'] # possibly create global variable for this.
    for i in range(66):
        key.append(alphabet[0])
    return key

def generateRandomKey():
    # OUTPUT: ARRAY OF 54 RANDOM TROIKA CHARS
    key = []
    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
    for i in range(66):
        key.append(alphabet[randint(0, 8)])
    return key

def generateRoundCounter(k):
    # INPUT: INTEGER (= ROUND NUMBER) || OUTPUT: ARRAY OF 3 TROIKA CHARS (= ROUND COUNTER)
    alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']
    roundCounter = []
    if (k < 9):
        roundCounter = ['A', 'A', alphabet[k]]
    elif (k < 81):
        second = int(k / 9)
        last = k % 9
        roundCounter = ['A', alphabet[second], alphabet[last]]
    else:
        print("The number of rounds exceeds 81 and is not suitable for TROIKA.")
    return roundCounter

    #######################################################
    ## B. KEY REGISTER UPDATE                           ###
    #######################################################

def SBKey(key):
    # INPUT: [K_65, K_64, ... , K_1, K_0] || OUTPUT: [SB(K_65), SB(K_64), ... , K_1, K_0]
    Z = [key[0], key[1], key[2]]
    Y = SB(Z)
    return Y + key[3:]

def addRoundCounter(key, roundCounter):
    # INPUT: [K_65, K_65, ... , K_1, K_0] || OUTPUT: [K_65, K_64, ... , (K_14 + RC_0), (K_13 + RC_1), (K_12 + RC_2), ... , K_1, K_0]
    k0 = TranslateFromAlphabet(key[51])
    k1 = TranslateFromAlphabet(key[52])
    k2 = TranslateFromAlphabet(key[53])
    rc0 = TranslateFromAlphabet(roundCounter[0])
    rc1 = TranslateFromAlphabet(roundCounter[1])
    rc2 = TranslateFromAlphabet(roundCounter[2])
    sum0 = TranslateToAlphabet(k0 + rc0)
    sum1 = TranslateToAlphabet(k1 + rc1)
    sum2 = TranslateToAlphabet(k2 + rc2)
    finalSum = [sum0, sum1, sum2]
    return key[:51] + finalSum + key[54:]

def permuteKey(key):
    # INPUT: [K_65, K_64, ... , K_1, K_0] || OUTPUT: [K_12, K_11, ... , K_14, K_13]
    firstPart = key[:54]
    lastPart = key[54:]
    newKey = lastPart + firstPart
    return newKey

def updateKeyRegister(key, round):
    # INPUT: LAST UPDATED KEY REGISTER [K_65, K_64, ... , K_1, K_0] & ROUND NUMBER (INT) || OUTPUT: UPDATED KEY REGISTER
    roundCounter = generateRoundCounter(round)
    sBoxed = SBKey(key)
    addedRound = addRoundCounter(sBoxed, roundCounter)
    permuted = permuteKey(addedRound)
    return permuted

def generateKeyRound(key, round):
    # INPUT: FIRST KEY OF 66 TROIKA CHARS & ROUND NUMBER (INT) || OUTPUT: ROUND KEY
    for i in range(1, (round + 1)):
        key = updateKeyRegister(key, i)
    return key

    #######################################################
    ## C. KEY REGISTER DE-UPDATE                        ###
    #######################################################

def invSBKey(key):
    # INPUT: [SB(K_65), SB(K_64), ... , K_1, K_0] || OUTPUT: [K_65, K_64, ... , K_1, K_0]
    Z = [key[0], key[1], key[2]]
    Y = invSB(Z)
    return Y + key[3:]

def subtractRoundCounter(key, roundCounter):
    # INPUT: [K_65, K_64, ... , (K_14 + RC_0), (K_13 + RC_1), (K_12 + RC_2), ... , K_1, K_0] || OUTPUT: [K_65, K_64, ... , K_14, K_13, K_12, ... , K_1, K_0]
    k0 = TranslateFromAlphabet(key[51])
    k1 = TranslateFromAlphabet(key[52])
    k2 = TranslateFromAlphabet(key[53])
    rc0 = TranslateFromAlphabet(roundCounter[0])
    rc1 = TranslateFromAlphabet(roundCounter[1])
    rc2 = TranslateFromAlphabet(roundCounter[2])
    diff0 = TranslateToAlphabet(k0 - rc0)
    diff1 = TranslateToAlphabet(k1 - rc1)
    diff2 = TranslateToAlphabet(k2 - rc2)
    finalDiff = [diff0, diff1, diff2]
    return key[:51] + finalDiff + key[54:]

def unpermuteKey(key):
    # INPUT: [K_12, K_11, ... , K_14, K_13] || OUTPUT: [K_65, K_64, ... , K_1, K_0]
    firstPart = key[:12]
    lastPart = key[12:]
    newKey = lastPart + firstPart
    return newKey

def deUpdateKeyRegister(key, round):
    # INPUT: LAST DE-UPDATED KEY REGISTER [K_65, K_64, ... , K_1, K_0] , ROUND NUMBER (INT) || OUTPUT: UPDATED KEY REGISTER
    unpermuted = unpermuteKey(key)
    roundCounter = generateRoundCounter(round)
    subtractedRound = subtractRoundCounter(unpermuted, roundCounter)
    invSBoxed = invSBKey(subtractedRound)
    return invSBoxed

#######################################################
## 9) 23-ROUND TROIKA                               ###
#######################################################

def encryptTROIKA(plaintext, key):
    # INPUT: PLAINTEXT STRING OF 54 TROIKA CHARS, KEY ARRAY OF 66 TROIKA CHARS
    # round 1
    plaintext = addRoundKey(plaintext, key[:54])
    #print(plaintext)
    # round 2-22
    for i in range(2, 23):
        key = updateKeyRegister(key, i)
        roundKey = key[:54]
        plaintext = SBoxPLayer(plaintext)
        plaintext = addRoundKey(plaintext, roundKey)
        #print(i, plaintext)
    # round 23
    lastKey = updateKeyRegister(key, 23)
    print(lastKey[:54])
    return addRoundKey(plaintext, lastKey[:54])

def decryptTROIKA(ciphertext, updatedKey): # keep this change in mind - feed in updatedKey (key updated after 23 rounds) || 9/19/2019
    # INPUT: CIPHERTEXT STRING OF 54 TROIKA CHARS, KEY ARRAY OF 66 TROIKA CHARS
    # round 23
    key = generateKeyRound(updatedKey, 23)
    roundKey = key[:54]
    print(roundKey)
    ciphertext = subtractRoundKey(ciphertext, roundKey) # Is this valid? Is subtractRoundKey valid?
    #print(ciphertext)
    # rounds 2-22
    for i in range(22, 1, -1):
        ciphertext = subtractRoundKey(ciphertext, roundKey)
        #print(i, ciphertext)
        ciphertext = invSBoxPLayer(ciphertext)
        roundKey = key[:54]
        key = deUpdateKeyRegister(key, i)
    # round 1
    return subtractRoundKey(ciphertext, key[:54])

#######################################################
## * TESTING                                        ###
#######################################################

plaintext = "ABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEFABCDEF"
plaintext2 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
key = generateAKey()

plaintext
encrypted = encryptTROIKA(plaintext, key)
encrypted

print("---")

plaintext2
encrypted2 = encryptTROIKA(plaintext2, key)
encrypted2

decrypted = decryptTROIKA(encrypted, key)

# On round 35, the subtractRoundKey function treats 0-2 as -2 instead of 6.

                                                                                 

︡9bac32a6-e637-4427-bb8f-c586614be823︡{"stderr":"Error in lines 54-69\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1191, in execute\n    flags=compile_flags), namespace, locals)\n  File \"<string>\", line 11\n    if(charDiff == -Integer(2)):\n                               ^\nSyntaxError: invalid syntax\n"}︡{"done":true}
︠8c8b16a3-52a5-49f1-8899-f332a5709a48s︠
                                                                               
︡b8c26b7a-ed0d-4d27-9dac-3dfcc8a584ca︡{"done":true}
︠9d916f57-48c3-4e03-a51b-58b43eaeba56s︠

︡b0d505ba-15c9-4aea-bd9a-a933c57de978︡{"done":true}
︠ffa9a20c-f90b-4bfc-b794-d319c16aa663s︠

︡72df079e-7e1a-4383-8fa0-2685c1a8309e︡{"done":true}
︠52a27796-a23d-4ddd-a036-936e0dba41bcs︠

︡50da8261-9443-4406-8a52-5e62dacd97d5︡{"done":true}
︠936bb3f2-a2e9-40d4-934a-9600ff61a50ds︠

︡e18c8358-4a41-4175-813c-75d951a96767︡{"done":true}
︠005eb460-80e3-466a-acda-2038109f63eas︠

︡d7412d7b-a9ac-4447-bd89-9f918eff09dd︡{"done":true}









