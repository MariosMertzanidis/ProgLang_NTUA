#initial περιέχει τον αρχικό πίνακα όπως είναι
#waters, cats (list) περιέχει τα νερά/γατες και τα εμπόδια
#time_water, time_cat (list) περιέχει τους χρόνους στους οποίους φτάνει το νερό σε κάθε θέση
#water_queue, cat_queue (queue) είναι η ουρά με τα νερά/γατα
#m (integer) είναι οι στήλες του αρχικού πίνακα
#n (integer) είναι οι γραμμές τους αρχικού πίνακα
#best (list) 2 θέσεων, στην 1η είναι η καλύτρη θέση και στη 2η ο καλύτερος χρόνος
#path (list) θα με βοηθησει να βρω την διαδρομή

def process(f):
    C = list(map(str, f.read().split()))
    n = len(C)
    m = len(C[0])
    initial = list()
    waters = list()
    cats = list()
    time_water = list()
    time_cat = list()
    water_queue = queue.Queue()
    cat_queue = queue.Queue()
    best = [None]*2
    path = [None]*(n*m)
    cat_is_dead = [None]*1
    cat_is_dead[0]=0
    cat_position = 0
    for i in range(0,n):
        line = C[i]
        for j in range(0,m):
            initial.append(line[j])
    for x in range(0,len(initial)):
        waters.append(initial[x])
        cats.append(initial[x])
        time_cat.append(0)
        if initial[x] == "W":
            time_water.append(0)
            water_queue.put(x)
        elif initial[x] == "A":
            cat_queue.put(x)
            cat_position = x
            time_water.append(n*m+1)
        else:
            time_water.append(n*m+1)

    water_flood(water_queue, time_water, waters, cat_is_dead, m, n, cat_position)
    cat_flood(cat_is_dead, best, cat_queue, time_cat, cats, time_water, path, m, n, cat_position)
    result(cat_is_dead, best, cat_position,path, m, n)


import queue

def water_flood(water_queue, time_water, waters, cat_is_dead, m, n, cat_position):
    while water_queue.empty() == False:
        curr = water_queue.get()
        counter = time_water[curr]
        if (curr-m) >= 0:
            if (waters[curr-m] != "X") and (waters[curr-m] != "W"):
                water_queue.put(curr-m)
                time_water[curr-m] = counter+1
                waters[curr-m] = "W"
        if (curr+m) <= n*m-1:
            if (waters[curr+m] != "X") and (waters[curr+m] != "W"):
                water_queue.put(curr+m)
                time_water[curr+m] = counter+1
                waters[curr+m] = "W"
        if (curr%m) != 0:
            if (waters[curr-1] != "X") and (waters[curr-1] != "W"):
                water_queue.put(curr-1)
                time_water[curr-1] = counter+1
                waters[curr-1] = "W"
        if (curr%m) != m-1:
            if (waters[curr+1] != "X") and (waters[curr+1] != "W"):
                water_queue.put(curr+1)
                time_water[curr+1] = counter+1
                waters[curr+1] = "W"
    if waters[cat_position] == "W":
        cat_is_dead[0] = 1

#δεν πρεπει να ξεχασω να βαλώ στο best το αντιστοιχο coordinates.posission
#και επειδή δεν μπορώ να το κάνω εδώ θα το κάνω όταν γίνεται το διαβασμα
#δεν ξεχναω πρεπει να το περασω σαν input

#στον πινακα path πρεπει να βαλω στην αρχικη θεση της γατας μια αρνητικη τιμη

#επίσης να μην ξεχασω να αρχικοποιήσω την πρώτη θέση της γάτας
#κραταω αυτη την τιμη και στο best και στο cat_position

def cat_flood(cat_is_dead, best, cat_queue, time_cat, cats, time_water, path, m, n, cat_position):
    if cat_is_dead[0] == 0:
        best[1] = n*m
    else:
        best[1] = 0
    best[0] = cat_position
    path[cat_position] = -m-1
    while cat_queue.empty() == False:
        curr = cat_queue.get()
        counter = time_cat[curr]
        if curr+m <= n*m-1:
            if (cats[curr+m] != "X") and (cats[curr+m] != "A") and (counter+1 < time_water[curr+m]):
                path[curr+m] = curr
                cats[curr+m] = "A"
                cat_queue.put(curr+m)
                time_cat[curr+m] = counter+1
                if best[1] < time_water[curr+m]-1:
                    best[1] = time_water[curr+m]-1
                    best[0] = curr+m
                elif best[1] == time_water[curr+m]-1:
                    if (curr+m) < best[0]:
                        best[0] = curr+m
        if curr%m != 0:
            if (cats[curr-1] != "X") and (cats[curr-1] != "A") and (counter+1 < time_water[curr-1]):
                path[curr-1] = curr
                cats[curr-1] = "A"
                cat_queue.put(curr-1)
                time_cat[curr-1] = counter+1
                if best[1] < time_water[curr-1]-1:
                    best[1] = time_water[curr-1]-1
                    best[0] = curr-1
                elif best[1] == time_water[curr-1] - 1:
                    if (curr-1) < best[0]:
                        best[0] = curr-1
        if curr%m != m-1:
            if (cats[curr+1] != "X") and (cats[curr+1] != "A") and (counter+1 < time_water[curr+1]):
                path[curr+1] = curr
                cats[curr+1] = "A"
                cat_queue.put(curr+1)
                time_cat[curr+1] = counter+1
                if best[1] < time_water[curr+1]-1:
                    best[1] = time_water[curr+1]-1
                    best[0] = curr+1
                elif best[1] == time_water[curr+1]-1:
                    if (curr+1) < best[0]:
                        best[0] = curr+1
        if curr-m >= 0:
            if (cats[curr-m] != "X") and (cats[curr-m] != "A") and (counter+1 < time_water[curr-m]):
                path[curr-m] = curr
                cats[curr-m] = "A"
                cat_queue.put(curr-m)
                time_cat[curr-m] = counter+1
                if best[1] < time_water[curr-m]-1:
                    best[1] = time_water[curr-m]-1
                    best[0] = curr-m
                elif best[1] == time_water[curr-m]-1:
                    if (curr-m) < best[0]:
                        best[0] = curr-m

def result(cat_is_dead, best, cat_position, path, m, n):
    output = list()
    length = 0
    if cat_is_dead[0] == 1:
        print(best[1])
    else: print("infinity")
    first = best[0]
    if cat_position == first:
        print("stay")
    while True:
        if(path[first] == first-m):
            output.append("D")
            length = length+1
        elif (path[first] == first+m):
            output.append("U")
            length = length+1
        elif (path[first] == first-1):
            output.append("R")
            length = length+1
        elif (path[first] == first+1):
            output.append("L")
            length = length+1
        else: break
        first = path[first]
    if length > 0:
        for i in range(length-1, 0,-1):
            print(output[i], end="")
        print(output[0])

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        with open(sys.argv[1], "rt") as f:
            process(f)
    else:
        process(sys.stdin)
