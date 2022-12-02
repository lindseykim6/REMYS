︠9fdb1d83-d394-4a8a-bca2-b36f342a0a08s︠
k= "abcdabc"
︡650bc456-f0af-4093-826f-e414b2831614︡{"done":true}
︠dbd5c655-9d9e-4822-b929-c82f5e3c5003s︠
for i in range (7):
    #zfill() pads string on the left with zeros to fill width
    #use [2:] to erase the '0b'
    if k[i]=="a":
        print bin(10)[2:]
    if k[i]=="b":
        print bin(11)[2:]
    if k[i]=="c":
        print bin(12)[2:]
    if k[i]=="d":
        print bin(13)[2:]
︡fcbb2666-6aef-4b4d-a4b3-4819e42d1b26︡{"stdout":"1010\n1011\n1100\n1101\n1010\n1011\n1100\n"}︡{"done":true}
︠084edf1c-8f61-4d23-89fc-17cc20c06e05s︠
K = "1010101111001101101010111100"
def rotate(input,d): 
      # slice string in two parts for left and right 
    Lfirst = input[0 : d] 
    Lsecond = input[d :] 
    print "Left Rotation : ", (Lsecond + Lfirst)

rotate(K,5)
︡81f48be7-b485-4f50-b57d-f81c7331e4c6︡{"stdout":"Left Rotation :  0111100110110101011110010101\n"}︡{"done":true}
︠ac37ef92-9065-4ffd-b9bc-d11b8f3702f6s︠
startpos1=0
endpos1= 4
beforesbox= str(K[startpos1:endpos1])
beforesbox
︡2053ddeb-9ba8-4de1-a351-c941764a6ea3︡{"stdout":"'1010'\n"}︡{"done":true}
︠2da2c003-66d8-4708-91be-a1d14fb7348bs︠
#The int() method returns an integer object from any number or string.
h=hex(int(beforesbox, 2))[2:]
h
︡ad7040c1-c38c-4fe6-8150-bef52b5afd43︡{"stdout":"'a'\n"}︡{"done":true}
︠8d27f7e4-358b-42e3-9fe1-b255f413f6d5s︠
def convertToSBox2(hex):
    hexList = list(hex)
    SBoxList = []
    SBoxDict = {'0': 'c',
            '1': '5',
            '2': '6',
            '3': 'b',
            '4': '9',
            '5': '0',
            '6': 'a',
            '7': 'd',
            '8': '3',
            '9': 'e',
            'a': 'f',
            'b': '8',
            'c': '4',
            'd': '7',
            'e': '1',
            'f': '2'}
    for element in hexList:
        for item in SBoxDict:
            if (element == item):
                SBoxList += SBoxDict[element]
    newHex = ""
    for char in SBoxList:
        newHex = newHex + char
    return newHex

n= convertToSBox2(h)
n
︡267983cc-9525-427c-a138-861a717180b5︡{"stdout":"'f'\n"}︡{"done":true}
︠9e717704-d3f3-4ab0-b163-c9399e418614s︠
for i in range (1):
    #x=list_hex[i]
    #zfill() pads string on the left with zeros to fill width
    #use [2:] to erase the '0b'
    if n[i]=="0":
        print bin(0)[2:]
    if n[i]=="1":
        print bin(1)[2:]
    if n[i]=="2":
        print bin(2)[2:]
    if n[i]=="3":
        print bin(3)[2:]
    if n[i]=="4":
        print bin(4)[2:]
    if n[i]=="5":
        print bin(5)[2:]
    if n[i]=="6":
        print bin(6)[2:]
    if n[i]=="7":
        print bin(7)[2:]
    if n[i]=="8":
        print bin(8)[2:]
    if n[i]=="9":
        print bin(9)[2:]
    if n[i]=="a":
        print bin(10)[2:]
    if n[i]=="b":
        print bin(11)[2:]
    if n[i]=="c":
        print bin(12)[2:]
    if n[i]=="d":
        print bin(13)[2:]
    if n[i]=="e":
        print bin(14)[2:]
    if n[i]=="f":
        print bin(15)[2:]
︡a74bdf0b-ef17-4237-9a3d-a54cb403ed3c︡{"stdout":"1111\n"}︡{"done":true}
︠ab93d14d-5eb3-4020-9a66-af2169d0a603︠
changed1  = K[:0]+'1111'+K[4:]
print changed1
︡c9851f8c-dcd2-47c1-9fa5-cd33d55e479a︡{"stdout":"1111101111001101101010111100\n"}︡{"done":true}
︠ca38882b-0b3a-4ea6-92de-61d5d8564431s︠
def rotate(input,d): 
      # slice string in two parts for left and right 
    Lfirst = input[0 : d] 
    Lsecond = input[d :] 
    print "Left Rotation : ", (Lsecond + Lfirst)
︡4b54481c-9d92-41f0-85ad-173ce71e0dff︡{"done":true}
︠9b23e6e4-f942-4eb8-b908-7c191d62d7c4︠

︡47858695-a1ff-4d3f-86fe-99edcf684518︡
︠c9aec238-96be-492c-abdf-d86260d516c9s︠
rotate(changed,5)
︡8b7da89d-3ea0-4da3-8d7d-a0438d52e0dd︡{"stdout":"Left Rotation :  0111100110110101011110011111\n"}︡{"done":true}
︠0a386b8a-18db-4484-ae53-cf71e75ca446s︠
startpos2= 19
endpos2= 14
beforexor= str(K[-startpos2:-endpos2])
︡afe88e57-524a-4804-ac12-c485fd7a6a6c︡{"done":true}
︠6bbdd2b8-6705-4a00-87c2-7e1bfa57ca9as︠
print beforexor
︡6e9dfe18-7c5d-4364-a5f2-6119176b9bb2︡{"stdout":"10011\n"}︡{"done":true}
︠75072a3c-05d9-4339-b5ef-eef495a30e91s︠
round_counter = '00001'
def XOR(x,y):
    return  ( x + y) % 2
z=[]
for i in range(5):
       z.append(XOR(int(beforexor[i]),int(round_counter[i])))
str(z)
︡90d84491-e098-4049-9485-41fbd8d94f3a︡{"stdout":"'[1, 0, 0, 1, 0]'\n"}︡{"done":true}
︠54285b16-128d-4f0e-a158-346a8a4686f6s︠
︡f8b1ed61-081e-4379-bd8a-214ca2976774︡{"done":true}
︠4ecc1f5c-99a0-4d03-a1ef-57f813ed2dbc︠
︡dc332f39-6657-44d3-a3d7-049404353cc5︡
︠6a7a2ef0-1dd5-497f-abbc-5e19311f15fb︠
︡b5cf38cf-4332-4bdb-8dae-c00d59baff25︡
︠67fbbfc2-b7f2-42b3-b76f-eed2e3bbfc02︠
︡4b10d2b8-3431-4350-8394-8769968dac8c︡
︠5a6f9b80-81f4-4c3f-86ab-0b0b1aefcc74s︠
changed2  = K[:-19]+'z'+K[-14:]
print changed2
︡f86d8ccf-33ca-4ecc-a66f-365d6fdb27ab︡{"stdout":"101010111z01101010111100\n"}︡{"done":true}
︠b3c8bdcb-d4ff-4a30-a4c7-b95e8269f629s︠
︡514c4fb5-486e-45e6-9dce-acda18ea9661︡{"done":true}









