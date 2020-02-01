import numpy as np
t = np.arange(0., 5., 0.2)
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
fig = plt.figure(1)
plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
plt.show()
fig.savefig('plot5.svg')