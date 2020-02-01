import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
# fig = plt.figure(1, facecolor='red')
# plt.plot([2,3])
# plt.xlabel('count')
# plt.ylabel('result')
# plt.title('Hahaha Goooood!!!')
# fig.savefig('plot.svg')


# import matplotlib
# matplotlib.use('Agg')
# import matplotlib.pyplot as plt
# fig = plt.figure(1, facecolor='white')
# fig.clf()
# ax = plt.subplot(111, frameon=True)
# # ax.scatter([.2, .5], [.1, .5])
# plt.figure(1, figsize=(3,3))
# ax = plt.subplot(111)
# ax.annotate("Test", xy=(0.2, 0.2), xycoords='data', xytext=(0.8, 0.8),
# textcoords='data', size=20, va="center", ha="center",
# bbox=dict(boxstyle="round4", fc="w"),
# arrowprops=dict(arrowstyle="-|>",
# connectionstyle="arc3,rad=-0.2", fc="w"), )
# ax.annotate("This is my text", xy=(0.2, 0.1), xycoords='data',
#     xytext=(0.4, 0.3), textcoords='data', ha='center', va='center',
#     arrowprops=dict(arrowstyle="->", connectionstyle="arc3"), )

# fig.savefig('plot.svg')

# import textPlotter
# textPlotter.createPlot()

import treePlotter
treePlotter.createPlot(treePlotter.retrieveTree(0))