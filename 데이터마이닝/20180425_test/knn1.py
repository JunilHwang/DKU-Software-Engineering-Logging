from numpy import *
import random as rd
import operator

path = "./train.data"
f = open(path)
lines = f.readlines();
line_size = len(lines)
mat = zeros((line_size,3))
vector = []
idx = 0
for line in lines :
	line = line.strip()
	lists = line.split(",")
	mat[idx] = lists[1:4] # include : exclude
	vector.append(lists[0])
	idx += 1

f.close()


path2 = "./test.data"
f2 = open(path2)
lines2 = f2.readlines();
idx = 0
tableCount = {}
for line in lines2 : 
	line = line.strip()
	lists = line.split(",")
	point1 = int(lists[1])
	point2 = int(lists[2])
	point3 = int(lists[3])
	point_list = array([point1,point2,point3])
	diffMat = tile(point_list,(line_size,1)) - mat;
	sqd = diffMat**2
	sqd = sqd.sum(axis=1)
	sortIdx = sqd.argsort()
	classCount = {}
	for i in range(20) :
		label = vector[sortIdx[i]]
		classCount[label] = classCount.get(label,0)+1
	sortedClass = sorted(classCount.items(), key=operator.itemgetter(1), reverse=True)
	if sortedClass[0][0] == "Survived" :
		if sortedClass[0][0] == lists[0] :
			tableCount['True Negative'] = tableCount.get('True Negative',0)+1
		else :
			tableCount['True Positive'] = tableCount.get('True Positive',0)+1
	else :
		if sortedClass[0][0] == lists[0] :
			tableCount['false Negative'] = tableCount.get('false Negative',0)+1
		else :
			tableCount['false Positive'] = tableCount.get('false Positive',0)+1
	print sortedClass[0][0], lists[0]
print tableCount
max = tableCount.get('True Positive',0) + tableCount.get('false Positive',0) + tableCount.get('True Negative',0) + tableCount.get('false Negative',0)
per = (tableCount.get('True Positive',0) + tableCount.get('false Positive',0))
print (float(per) / float(max)) * 100 , " %"

path2 = "./real.data"
f2 = open(path2)
lines2 = f2.readlines();
idx = 0
tableCount = {}
for line in lines2 : 
	line = line.strip()
	lists = line.split(",")
	point1 = int(lists[1])
	point2 = int(lists[2])
	point3 = int(lists[3])
	point_list = array([point1,point2,point3])
	diffMat = tile(point_list,(line_size,1)) - mat;
	sqd = diffMat**2
	sqd = sqd.sum(axis=1)
	sortIdx = sqd.argsort()
	classCount = {}
	for i in range(20) :
		label = vector[sortIdx[i]]
		classCount[label] = classCount.get(label,0)+1
	sortedClass = sorted(classCount.items(), key=operator.itemgetter(1), reverse=True)
	tableCount[sortedClass[0][0]] = tableCount.get(sortedClass[0][0],0) + 1
	#print sortedClass[0][0], lists[0]
print tableCount
print (float(tableCount['Survived']) / float(tableCount['Survived'] + tableCount['Died'])) * 100 , " %"

# print lines
# print returnMat


f.close()

