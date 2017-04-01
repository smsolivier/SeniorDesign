#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

from util.geth import * 

# mu = 1.831e-5 
mu = 2.286e-5
mus = 2.670e-5
# Pr = .705 
Pr = .688
# k = .0257
k = 3.365e-2
P = 1e5
Tb = 293
Ts = 500
Tf = .5*(Tb + Ts)

print('Film Temperature =', Tf)

R = 8.314
nmol = 28.96

U = 20
L = 20
r = .4
D = 2*r 

# rho = P/(287.058 * Tb)
rho = 1.18586764829

print('rho =', rho)

Re = rho*U*D/mu 

print('Re = {:.6e}'.format(Re))

print('lam entrance =', .05*Re)
print('lam T entrance =', .05*Re*Pr)

print('turb entrance =', 1.359*Re**(1/4))
print('turb T entrance =', 10)

qT = k/D*.023*Re**(4/5)*Pr**.4 * (Ts - Tb)
qL = k/D*3.66*(Ts - Tb)

print('qT =', qT)
print('qL =', qL)

z, h, rho = getH(Ts)

hb = k/D * .023 * Re**(4/5) * Pr**.4
hs = k/D * .027 * Re**(4/5) * Pr**(1/3) * (mu/mus)**.14
hl = 3.66*k/D 

print('Percent Error =', np.fabs(h[-1] - hb)/hb*100)

print(np.mean(rho))

plt.figure()
plt.semilogy(z/D, h)
plt.axhline(hb, color='k', alpha=.5)
# plt.axhline(hs, color='b', alpha=.5)
plt.axhline(hl, color='b', alpha=.5)
plt.xlabel(r'$z/D$')
plt.ylabel('Heat Transfer Coefficient')

plt.figure()
plt.plot(z/D, rho)

plt.show()