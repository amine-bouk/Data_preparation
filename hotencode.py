from sklearn.preprocessing import OneHotEncoder
import pandas as pd
from array import array
from sklearn.preprocessing import LabelEncoder
import numpy as np
#read data from csv file
data = pd.read_csv('~/doctorai/labelsorted.csv', sep=';', encoding='utf8')
list = data.values.tolist()

#encode to int 
labelencoder = LabelEncoder()
myarray = np.asarray(list)
myarray[:, 1] = labelencoder.fit_transform(myarray[:, 1])

#encode to one hot encoder
onehotencoder = OneHotEncoder(categorical_features = [1])
myarray = onehotencoder.fit_transform(myarray[:,1])
