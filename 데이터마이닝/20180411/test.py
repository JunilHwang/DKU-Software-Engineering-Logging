from numpy import *
import operator

def createDataSet() :
	group = array([ [1.0, 1.1],
					[1.0,1.0],
					[0,0],
					[0,0.1]
				 ]);
	labels = ['A','A','B','B'];
	return group, labels

def classify(inX, dataSet, labels, k) :
	size = dataSet.shape[0]
	mat = tile(inX, (size,1)) - dataSet
	print mat

g, l = createDataSet()
a = tile([0.75,0.6], (4,1)) - g;
aa = a**2;
b = aa.sum(axis=1);
b = b**0.5
print aa;
print b
idx = b.argsort()
cc = {}
for i in range(3) :
	label = l[idx[i]];
	print b[idx[i]]
	cc[label] = cc.get(label,0)+1;
d = sorted(cc.items(), key=operator.itemgetter(1), reverse=False)
print cc
print d[0][0];