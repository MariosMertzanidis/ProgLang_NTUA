
#node_list είναι η λίστα με τα nodes
#im πίνακας μιας θεσης που ειναι boolean και δειχνει αν πρεπει να τυπωθει impossible
#ans λιστα που εχει την συμβολοσειρα της απαντησης

import queue

class newNode:
def __init__(self, item1, item2, item3):
self.key1 = item1
self.key2 = item2
self.key3 = item3
self.parent = None

def process(f):
q = f.readline()
Q = int(q)
l = list(map(int, f.read().split()))
output = list()
for i in range(0,Q):
j = 4*i
Lin = l[j]
Rin = l[j+1]
Lout = l[j+2]
Rout = l[j+3]
if Lin >= Lout and Rin <= Rout:
  output.append("EMPTY")
elif Lout >= 500000 and ((Rout - Lout == 1 and Rout%3 == 0) or (Rout == Lout and Rout%3 != 1)):
  output.append("IMPOSSIBLE")
else:
  find_function(Lin, Rin, Lout, Rout, output)
for i in range(0,Q):
print(output[i])



def find_function(Lin, Rin, Lout, Rout, output):
counter = 0
seen = {}
node_queue = queue.Queue()
ans = list()
node1 = newNode('h', Lin//2, Rin//2)
if node1.key2 >= Lout and node1.key3 <= Rout:
output.append('h')
return
node_queue.put(node1)
node2 = newNode('t', (Lin*3)+1, (Rin*3)+1)
if node2.key2 >= Lout and node2.key3 <= Rout:
output.append('t')
return
node_queue.put(node2)
while(not node_queue.empty()):
curr = node_queue.get()
#counter = counter+1
#if counter == 666665: break

curr1= newNode('h', curr.key2//2, curr.key3//2)
cal = 1000000*curr1.key2 + curr1.key3
if curr1.key3 < 1000000 and cal not in seen:
  seen[cal] = 's'
  curr1.parent = curr
  node_queue.put(curr1)

if curr1.key2 >= Lout and curr1.key3 <= Rout:
  curr=curr1
  break

curr2 = newNode('t', (curr.key2*3)+1, (curr.key3*3)+1)
cal = 1000000*curr2.key2 + curr2.key3
if curr2.key3 < 1000000 and cal not in seen:
  seen[cal] = 's'
  curr2.parent = curr
  node_queue.put(curr2)

if curr2.key2 >= Lout and curr2.key3 <= Rout:
  curr=curr2
  break

#if counter == 666665:
#    output.append("IMPOSSIBLE")
while(curr != None):
ans.append(curr.key1)
curr = curr.parent
output.append("".join(ans[::-1]))


if __name__ == "__main__":
import sys
if len(sys.argv) > 1:
with open(sys.argv[1], "rt") as f:
  process(f)
else:
process(sys.stdin)
