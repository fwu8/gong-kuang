import numpy as np
import csv
import gzip, cPickle
from numpy import genfromtxt
import theano
import theano.tensor as T
import pdb
import numpy
from mSdA import mSdA
import cPickle
import pickle
import collections

#Open csv file and read in data
csvFile = "data.csv"
my_data = genfromtxt(csvFile, delimiter=',')
data = []
for i in xrange(250):
		array = []
		for k in xrange(6):
				if(k%2 == 0):
						array.append(my_data[i][k])
		data.append(array)
my_data = data

num_rows = len(my_data) # Number of data samples
num_cols = len(my_data[0]) # Length of Data Vector

total_size = num_cols * num_rows

data = np.arange(total_size)
data = data.reshape(num_rows, num_cols) # 2D Matrix of data points
data = data.astype('float64')

max_val = []
min_val = []
for j in xrange(num_cols):
		max_val.append(my_data[0][j])
		min_val.append(my_data[0][j])
for i in xrange(num_rows):
		for j in xrange(num_cols):
				max_val[j] = max(max_val[j], my_data[i][j])
				min_val[j] = min(min_val[j], my_data[i][j])

#Read through data file, assume label is in last col
#Split data in terms of 70% train, 10% val, 20% test
for i in xrange(num_rows):
		for j in xrange(num_cols):
				data[i][j] = (my_data[i][j]-min_val[j])/(max_val[j]-min_val[j])
				
sda = mSdA(
		layers = [3, 5, 2]
)
sda.train(data, 10)
feat = sda.get_hidden_values(data)

writer = csv.writer(open("feat.csv", 'w'))
for row in feat:
		writer.writerow(row)
