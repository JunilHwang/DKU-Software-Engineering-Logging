# -*- coding: utf-8 -*-
import entropy
import trees
import misc
import operator

beforeData, labels = misc.loadLensesData("test.data")

labelsCount1 = {} # 나이대에 대한 레이블
labelsCount2 = {} # 종양 수에 대한 레이블
for line in beforeData :
    lists = line[0].split(",")
    newLists = []
    label1 = int(lists[1])/10           # 나이대를 구한다
    label2 = ((int(lists[3])/5))*5      # 종양 수를 구한다.
    if label2 > 10 :
        label2 = 10
    labelsCount1[label1] = labelsCount1.get(label1,0) + 1
    labelsCount2[label2] = labelsCount2.get(label2,0) + 1

labels1 = []
labels2 = []
for lbl in labelsCount1.items() :
    labels1.append(str(lbl[0])+"0 ages")  # 레이블 정리
for lbl in labelsCount2.items() :
    print lbl
    labels2.append(str(lbl[0])+" counts")  # 레이블 정리

labels = labels1 + labels2 + ['after'] + ['Survived']  # 마지막으로 5년 이상 경과 / 생존 여부 추가

dataSet = []    # 데이터를 분류한다
labelSize = len(labels)
for line in beforeData :
    newList = [0] * labelSize
    lists = line[0].split(",")
    label1 = int(lists[1])/10
    label2 = ((int(lists[3])/5))*5
    if label2 > 10 :
        label2 = 10
    idx1 = labels.index(str(label1)+"0 ages")
    idx2 = labels.index(str(label2)+" counts")
    newList[idx1] = 1
    newList[idx2] = 1
    newList[-2] = int(lists[2]) >= 5 and "up" or "down"
    newList[-1] = lists[0] == labels[-1]
    dataSet.append(newList)

print dataSet, labels

myTree = trees.createTree(dataSet,labels)

print myTree

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

import treePlotter
treePlotter.createPlot(myTree)