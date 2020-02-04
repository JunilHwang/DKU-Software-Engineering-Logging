import entropy
import trees
import misc

def createDataSet():
	# glasses
	# man
	# 170
    dataSet = [
    		   [1, 1, 1, 'yes'],
    		   [1, 1, 1, 'yes'],
    		   [1, 1, 1, 'yes'],
    		   [1, 1, 1, 'yes'],
    		   [1, 1, 1, 'yes'],
    		   [1, 1, 0, 'yes'],
    		   [1, 0, 0, 'yes'],
    		   [1, 0, 0, 'yes'],
    		   [1, 0, 0, 'yes'],
    		   [0, 1, 1, 'yes'],
    		   [0, 1, 1, 'yes'],
    		   [0, 1, 1, 'yes'],
    		   [0, 0, 0, 'yes'],
    		   [0, 0, 0, 'yes'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 1, 1, 'no'],
    		   [1, 0, 0, 'no'],
    		   [0, 1, 1, 'no'],
    		   [0, 1, 1, 'no'],
    		   [0, 1, 0, 'no']
              ]
    labels = ['glasses','man','170']
    return dataSet, labels

dataSet, labels = misc.loadLensesData("test")

print entropy.calcShannonEnt(dataSet)

# print trees.chooseBestFeatureToSplit(dataSet)

myTree = trees.createTree(dataSet,labels)

print myTree

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import treePlotter
treePlotter.createPlot(myTree)

# misc.storeTree(myTree, 'lenses_tree.txt')
# tree2 = misc.grabTree('classifierStorage.txt')
# treePlotter.createPlot(tree2)