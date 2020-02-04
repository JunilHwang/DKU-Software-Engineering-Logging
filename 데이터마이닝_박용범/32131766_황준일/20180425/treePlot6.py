import numpy as np
t = np.arange(0, 20, 1)
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
fig = plt.figure(1)
plt.title('plot6')
plt.scatter([2, 3, 4], [6, 11, 18], [200,300,400], marker='1')
plt.scatter([3, 4, 5], [6, 11, 18], [200,300,400], marker='2')
plt.scatter([4, 5, 6], [6, 11, 18], [200,300,400], marker='3')
plt.scatter([5, 6, 7], [6, 11, 18], [200,300,400], marker='4')
plt.show()
fig.savefig('plot6.svg')