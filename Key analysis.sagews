︠bd22f61d-68ef-49a0-bded-a456944a0a1fs︠
key=[]
for i in range (66):
    key.append('A')
len(key)
︡a3e46aae-a919-4078-b256-a8649f75fb12︡{"stdout":"66\n"}︡{"done":true}
︠2f393493-ddf9-4651-8529-05dbae09d88es︠
#step 1
def shift(key,array):
    return array[key:]+array[:key]
︡9dddcf4a-581d-41e5-b33d-4ec9ad128c6d︡{"done":true}
︠a39f7a3b-de8f-4016-a9d7-4c0a0e59295cs︠
shift(53,key)
︡493408ef-dadb-4619-bc30-ad92c0d29655︡{"stdout":"['A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A']\n"}︡{"done":true}
︠f9ffc639-f2aa-4b55-a2c9-1d22496ea24fs︠
︡06753295-6b6c-45ef-9ba2-ee1a7856feb9︡{"done":true}
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
︡e6cd67bf-f4d6-4ce1-9c85-c0045d9308cc︡{"done":true}
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

︡6acb96ea-fc58-4b0f-b7d4-81c64dad11e4︡{"done":true}
︠105a3c94-7ab4-49e6-b48e-4ef17907d222︠

︡2ca36b04-d05e-48ab-a8e3-b915192de771︡
︠82faadd9-043c-4b14-a023-f7b5392542abs︠
#step2
SB([key[0],key[1],key[2]])
︡bc7ef74f-172c-45b7-9a7c-3946909cf537︡{"stdout":"['A', 'A', 'A']\n"}︡{"done":true}
︠316ec15d-72cc-4340-b5e7-3ae286587b59︠









