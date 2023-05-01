import pymongo
import pymonetdb
import time
import pandas
from sklearn.model_selection import train_test_split
from datetime import datetime
import time
import hashlib

dataflow_tag = "fraud"
exec_tag = dataflow_tag + "-" + str(datetime.now())

#data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/fhs-hash.csv")
#data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/censusout.csv")

data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/fraud-hash.csv")

# x = data.drop('TenYearCHD', axis=1)
# x = x.drop('id', axis=1)
# y = data['TenYearCHD']

# x = data.drop('label', axis=1)
# x = x.drop('id', axis=1)
# y = data['label']

x = data.drop('Class', axis=1)
x = x.drop('id', axis=1)
y = data['Class']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)


start = time.time()

client = pymongo.MongoClient('localhost', 27017)
dbname = "FraudHash"
db = client[dbname]

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()  

records = []

x_train2 = x_train.drop('Amount', axis=1)
x_train_dict = x_train2.to_dict('records')

for row in x_train_dict:
  the_hash = hashlib.sha256(str(row).encode("utf-8")).hexdigest()
  cursor_mongo = list(db.debora_data.find({"hash":the_hash}))
  records.append((str(exec_tag), cursor_mongo[0]['record_id']))
query = ("INSERT INTO record_tuples(df_exec,record_id,record_type) VALUES (%s, %s,'train');")
cursor.executemany(query, records) 
print(len(records))
records = []    
x_test2 = x_test.drop('Amount', axis=1)
x_test_dict = x_test2.to_dict('records')
for row in x_test_dict:
  the_hash = hashlib.sha256(str(row).encode("utf-8")).hexdigest()
  cursor_mongo = list(db.debora_data.find({"hash":the_hash}))
  records.append((str(exec_tag), cursor_mongo[0]['record_id']))  
query = ("INSERT INTO record_tuples(df_exec, record_id,record_type) VALUES (%s, %s,'test');") 
cursor.executemany(query, records)
print(len(records))
connection.commit()
connection.close()

client.close()

end = time.time()
print("time to get and insert: " + str(end-start))
