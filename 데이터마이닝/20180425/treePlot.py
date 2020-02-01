import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
fig = plt.figure(1)
plt.plot([2, 3])
plt.xlabel('x axis')
plt.ylabel('y axis')
plt.title('test')
fig.savefig('plot.svg')