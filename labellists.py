import pandas as pd
import cPickle as pickle

data = pd.read_csv('labeltest.csv', sep=';', encoding='latin-1')
biglist=[]
list = data.values.tolist()
listoflist = []
listoflist.append(list[0][1])
l=list[0][0]
for i in range(0,len(list)):
    if l==list[i][0]:
        listoflist.append(list[i][1])
    else:
        l=list[i][0]
        biglist.append(listoflist)
        listoflist = []
        listoflist.append(list[i][1])

biglist.append(listoflist)   


with open('labell.test','wb') as fout:
    pickle.dump(biglist,fout)

# read data from a file
with open('labell.test') as fin:
    print pickle.load(fin)
