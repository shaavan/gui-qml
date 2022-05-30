import math
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from util import ODE


# Constants
h_bar = 197.3269631
m = 938.272

# Given Values
a = 0.5
R = 5

#Assumed Values
L = 24

# Differential Energy. Used in the code to vary the Energy
dE = 0.01

# Woods-Saxon Potential
def V(r):
    return V0/(1 + math.exp((r - R)/a))

# Let:
# psi = z1
# diff(psi) = z2

# Differential Equation 1
def f1(r, v):
    return v[1]

# Differential Equation 2
def f2(r, v):
    return -2 * m * (E - V(r)) * v[0] / h_bar**2


V0_list = []
E_list = []
dd = 1
for V0 in np.arange(-45, -15 + dd, dd):
    V0_list.append(V0)

    flag = False
    h = dE
    i = 0
    while(not flag and i < 4):
        E = V0
        i += 1
        while(E < V0 + 1):
            r, v = ODE(-L/2, L/2, 100, [0, 0.01], [f1, f2])
            if (abs(v[0][-1]) < 10e-2 and abs(v[1][-1]) < 10e-1):
                print(E - V0, V0)
                E_list.append(E - V0)
                plt.plot(r, v[0])
                flag = True
                break
            E += h
        if not flag:
            print("No Convergence")
            h /= 5

V0_np = np.array(V0_list)
E_np = np.array(E_list)

df = pd.DataFrame({"Depth V0" : V0_np, "Ground State Energy (E - V0)" : E_np})
df.to_csv("Submission.csv", index=False)

plt.plot(V0_list, E_list)
plt.title("Ground State Energy v/s V0 (Depth)")
plt.xlabel("V0 (in MeV)")
plt.ylabel("Ground State Energy (E - V0) (in MeV)")
plt.xlim(-45, -15)
plt.ylim(0.6, 0.75)
plt.show()
