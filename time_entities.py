import pymongo
import pymonetdb
import time
import pandas
from sklearn.model_selection import train_test_split
from datetime import datetime

dataflow_tag = "census"
df_exec = dataflow_tag + "-" + str(datetime.now())

#data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/fhs-hash.csv")
data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/census-hash.csv")

# x = data.drop('TenYearCHD', axis=1)
# x = x.drop('id', axis=1)
# y = data['TenYearCHD']

x = data.drop('label', axis=1)
x = x.drop('id', axis=1)
y = data['label']

# x = data.drop('Class', axis=1)
# x = x.drop('id', axis=1)
# y = data['Class']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)


start = time.time()
client = pymongo.MongoClient('localhost', 27017)

print('Connected to: localhost')

dblist = client.list_database_names()
dbname = "Census"

db = client[dbname]

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()  

record_ids = []
x_train_dict = x_train.to_dict('records')
for row in x_train_dict:
    my_list = []
    for col_name in range(len(x.columns)):
        col_n = x.columns[col_name]
        my_list.append({col_n: str(row[col_n])})
    cursor_mongo = list(db.debora_entities.find({"$and": my_list}))
    record_ids.append((str(df_exec), cursor_mongo[0]['record_id']))
print(len(record_ids))
query = ("INSERT INTO record_tuples(df_exec,record_id,record_type) VALUES (%s, %s,'train');")
cursor.executemany(query, record_ids) 


record_ids = []
x_test_dict = x_test.to_dict('records')
for row in x_test_dict:
    my_list = []
    for col_name in range(len(x.columns)):
        col_n = x.columns[col_name]
        my_list.append({col_n: str(row[col_n])})
    cursor_mongo = list(db.debora_entities.find({"$and": my_list}))
    record_ids.append((str(df_exec), cursor_mongo[0]['record_id']))  
print(len(record_ids))
query = ("INSERT INTO record_tuples(df_exec, record_id,record_type) VALUES (%s, %s,'test');") 
cursor.executemany(query, record_ids)

connection.commit()
connection.close()

client.close()

end = time.time()
print("time to get and insert: " + str(end-start))
