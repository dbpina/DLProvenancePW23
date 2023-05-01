import pandas
from sklearn.model_selection import train_test_split
import numpy as np
import pymonetdb
import pymongo
import time

data = pandas.read_csv("D:/ipaw-23-experiments/Framingham/fhs.csv")

x = data.drop('TenYearCHD', axis=1)
x = x.drop('id', axis=1)
y = data['TenYearCHD']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

x_train.to_csv('train.csv')
y_train.to_csv('ytrain.csv')
x_test.to_csv('test.csv')
y_test.to_csv('ytest.csv')

start = time.time()
client = pymongo.MongoClient('localhost', 27017)
dbname = "Framingham"
db = client[dbname]

#cursor_mongo = list(db.entities.distinct("attributes.record_id"))

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()  

attrs = x_train.columns  
record_ids = []
for j in x_train.itertuples():
  my_list = []
  for i in range(0,len(attrs),1):
    my_list.append({str(attrs[i]): str(j[i+1])})
  cursor_mongo = list(db.debora_data.find({'$and':my_list}))
  record_ids.append(cursor_mongo[0]['record_id'])
query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'train');")
cursor.executemany(query, record_ids)

record_ids = []
for j in x_test.itertuples():
  my_list = []
  for i in range(0,len(attrs),1):
    my_list.append({str(attrs[i]): str(j[i+1])})
  cursor_mongo = list(db.debora_data.find({'$and':my_list}))
  record_ids.append(cursor_mongo[0]['record_id'])
query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'test');")    
cursor.executemany(query, record_ids)

connection.commit()
connection.close()

client.close()

end = time.time()
print("time to retrieve and save records:")
print(end-start)