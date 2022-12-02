︠67fbc10d-cda0-4a7e-b002-e0b1c4876133s︠
a = bin(11)
b = bin(10)


def convert_to_bin(string):
    n = len(string) #length of string
    binary_string = string[2:n]
    return binary_string;

# This program makes n-bit string
def make_k_bit_str(string,k):
    n = len(string)
    set = []
    dif = k-n
    if k == n:
        return string;
    else:
        for i in range(dif):
            set.append("0")
        temp = ''.join(set) + string
        return temp;



def xor(string1,string2):
    n = len(string1)
    temp_1_2 = []
    #
    # case by case scenario
    #
    for a in range(n):
        Case1 = string1[a] == '0' and string2[a] == '0'
        Case2 = string1[a] == '1' and string2[a] == '0'
        Case3 = string1[a] == '0' and string2[a] == '1'
        Case4 = string1[a] == '1' and string2[a] == '1'
        if Case1:
            temp_1_2.append('0')
        if Case2:
            temp_1_2.append('1')
        if Case3:
            temp_1_2.append('1')
        if Case4:
            temp_1_2.append('0')
    xor_string = ''.join(temp_1_2)
    return xor_string;



    

# This program performs xor between
# any two binary strings
#def xor_any_two_strings(string1,string2):
    n = len(string1)
    m = len(string2)
    if n == m:
        return xor(string1,string2);
    else:
        if n < m:
            new_string1 = make_k_bit_str(string1,m)
            return xor(new_string1,string2);
        else:
            new_string2 = make_k_bit_str(string2,n)
            return xor(new_string2,string1);

#def addroundkey(k,STATE):
    bob=xor_any_two_strings(k,STATE)
    return bob;
x= convert_to_bin(a)
x
y= convert_to_bin(b)
y
#addroundkey(a,b)
  
xor(x,y)

︡479f8185-8651-482b-9519-5055eac3e90e︡{"stdout":"'1011'\n"}︡{"stdout":"'1010'\n"}︡{"stdout":"'0001'\n"}︡{"done":true}
︠b13743c9-8a78-4fe4-820f-a0d214dfe694︠









