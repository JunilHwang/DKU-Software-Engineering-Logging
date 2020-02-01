from numpy import *
import random as rd
import operator

path = "./datingTestSet.txt"
f = open(path)
lines = f.readlines();
line_size = len(lines)
mat = zeros((line_size,3))
vector = []
idx = 0
for line in lines :
	line = line.strip()
	lists = line.split()
	mat[idx] = lists[1:3] # include : exclude
	vector.append(lists[0])
	idx += 1

rand1 = rd.randrange(1,100000)
rand2 = rd.random()*10
rand3 = rd.random()*10
firstDataArray = array([rand1,rand2,rand3]);
diffMat = tile(firstDataArray,(line_size,1)) - mat;
sqd = diffMat**2
sqd = sqd.sum(axis=1)
sortIdx = sqd.argsort()

print sqd
print sqd[sortIdx[0]]

classCount = {}
for i in range(20) :
	label = vector[sortIdx[i]]
	print i, label
	classCount[label] = classCount.get(label,0)+1

print classCount
print classCount.items()
sortedClass = sorted(classCount.items(), key=operator.itemgetter(1), reverse=True)
print sortedClass
print sortedClass[0][0]

# print lines
# print returnMat


f.close()

