import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
fig = plt.figure(1)
plt.plot([2, 3])
plt.plot([1, 4])
plt.axis([0, 2, 0.5, 4.5])
plt.title('two line')
fig.savefig('plot2.svg')