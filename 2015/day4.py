from hashlib import md5
init = 'yzbqklnj'
for i in range(1000000):
    h = md5((init + str(i)).encode()).hexdigest()
    if h[:5] == '00000':
        print(h)
        print(i)
        break
