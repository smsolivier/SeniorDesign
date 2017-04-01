#!/usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt

import os 

def getTdir():

	# find largest time directory 
	tdir = '0' 
	for f in os.listdir('.'):

		if (f[0].isdigit() and f[-1].isdigit() and os.path.isdir(f)):

			if (float(f) > float(tdir)):

				tdir = f 

	tdir += '/'

	return tdir 

def getH(Ts):

	tdir = getTdir()

	print('using time directory ' + tdir)

	initDir = '0/' 

	# get z for wall patch 
	zfile = initDir + 'ccz' 

	z = [] # store z locations 

	f = open(zfile, 'r')

	for line in f:

		if line.startswith('boundaryField'):

			next(f)
			line = next(f) 

			if ('wall' in line):

				for line in f: 

					if line.startswith('('):

						for line in f:

							if (line.startswith(')')):
								break 

							z.append(float(line.strip()))

						break 

	z = np.array(z)
	f.close()

	# get wall heat flux 
	f = open(tdir + 'wallHeatFlux', 'r')

	whf = [] # store wall heat flux 

	for line in f:

		if line.startswith('boundaryField'):

			next(f)
			line = next(f)

			if ('wall' in line):

				for line in f:

					if line.startswith('('):

						for line in f:

							if (line.startswith(')')):

								break 

							whf.append(float(line.strip()))

						break 

	whf = np.array(whf)
	f.close()

	sdir = 'postProcessing/singleGraph/' + tdir

	zc, Tc, rho = np.loadtxt(sdir + 'line_T_rho.xy', unpack=True)

	z = z[:-1]
	whf = whf[:-1]

	h = whf/(Ts - Tc)

	return z, h, rho

def getU():

	tdir = getTdir()

	zc, Uz = np.loadtxt('postProcessing/singleGraph/' + tdir + 'line_U.xy', 
		unpack=True, usecols=(0,3))

	return zc, Uz 