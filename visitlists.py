import pandas as pd
import cPickle as pickle
#read data from csv file 
data = pd.read_csv('visitsorted.csv', sep=';', encoding='latin-1')
biglist=[]
#fill not available data
data = data.fillna(0)
#transformer dataframe to list. 
list = data.values.tolist()

for i in range(0,len(list)):
    for j in range(0,19):
        if(type(list[i][j])==unicode):
            list[i][j] = int(float(list[i][j].replace(',','.')))
        else:
            list[i][j] = int(list[i][j])
# listoflist rssemble des visit d'un patient 
listoflist = []
listoflist.append(list[0])
l=list[0][0]
for i in range(0,len(list)):
    if l==list[i][0]:
        listoflist.append(list[i])
    else:
        l=list[i][0]
        #biglist la grande list qui contient tous les lists
        biglist.append(listoflist)
        listoflist = []
        listoflist.append(list[i])

biglist.append(listoflist)   


#picklé la list et écrire sur fichier de sortie.
with open('visitee','wb') as fout:
    pickle.dump(biglist,fout)

# read data from a file
with open('visitee') as fin:
    print pickle.load(fin)
