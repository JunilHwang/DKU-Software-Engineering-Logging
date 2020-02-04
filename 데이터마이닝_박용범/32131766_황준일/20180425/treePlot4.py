import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
fig = plt.figure(1)
plt.plot([1, 2, 3, 4], [3, 6, 11, 18], linewidth=2.0) 
plt.title('two line')
fig.savefig('plot4.svg')