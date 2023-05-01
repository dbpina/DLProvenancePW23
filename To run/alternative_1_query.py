import pymongo
import time
import pandas 
import pymonetdb
from sklearn.model_selection import train_test_split
from datetime import datetime


dataflow_tag = "fhs"
df_exec = dataflow_tag + "-" + str(datetime.now())

data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/fhs-hash.csv", nrows=1000)

x = data.drop('TenYearCHD', axis=1)
x = x.drop('id', axis=1)
y = data['TenYearCHD']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

start = time.time()

client = pymongo.MongoClient('localhost', 27017)

print('Connected to: localhost')

dblist = client.list_database_names()
dbname = "Framingham"

db = client[dbname]

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()  

the_records = []
x_train_dict = x_train.to_dict('records')
for row in x_train_dict:
	dct = {}
	for col_name in range(len(x.columns)):
		col_n = x.columns[col_name]
		dct["lst_%s" % col_n] = []
		cursor_mongo = list(db.entities.find({"attributes.feature_name": col_n,"attributes.value": str(row[col_n])}))
		for j in range(0,len(cursor_mongo),1):
			dct["lst_%s" % col_n].append(cursor_mongo[j].get("attributes").get("record_id"))   
	elements_in_all = list(set.intersection(*map(set, [dct["lst_%s" % i] for i in x.columns])))	
	the_records.append((str(df_exec), elements_in_all[0]))
print(len(the_records))
query = ("INSERT INTO record_tuples(df_exec,record_id,record_type) VALUES (%s, %s,'train');")
cursor.executemany(query, the_records) 		

the_records = []
x_test_dict = x_test.to_dict('records')
for row in x_test_dict:
	dct = {}
	for col_name in range(len(x.columns)):
		col_n = x.columns[col_name]
		dct["lst_%s" % col_n] = []
		cursor_mongo = list(db.entities.find({"attributes.feature_name": col_n,"attributes.value": str(row[col_n])}))
		for j in range(0,len(cursor_mongo),1):
			dct["lst_%s" % col_n].append(cursor_mongo[j].get("attributes").get("record_id"))   
	elements_in_all = list(set.intersection(*map(set, [dct["lst_%s" % i] for i in x.columns])))	
	the_records.append((str(df_exec), elements_in_all[0]))
print(len(the_records))
query = ("INSERT INTO record_tuples(df_exec,record_id,record_type) VALUES (%s, %s,'test');")
cursor.executemany(query, the_records) 	

connection.commit()
connection.close()

client.close()

# for i in range(0,len(attrs),1):
# 	cursor = list(db.entities.find({"attributes.feature_name": str(attrs[i]),"attributes.value": str(values_attrs[i])}))
# 	for j in range(0,len(cursor),1):
# 		dct["lst_%s" % attrs[i]].append(cursor[j].get("attributes").get("record_id"))

end = time.time()
print(end - start)
