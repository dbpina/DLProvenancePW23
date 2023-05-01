import pandas
from sklearn.model_selection import train_test_split
import numpy as np
import pymongo
import hashlib

data = pandas.read_csv("D:/ipaw-23-experiments/Framingham/fhs.csv")
print(len(data))
mydtypes = dict(data.dtypes)

x = data.drop('TenYearCHD', axis=1)
x = x.drop('id', axis=1)
y = data['TenYearCHD']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

client = pymongo.MongoClient('localhost', 27017)
dbname = "Framingham"
db = client[dbname]
attrs = x_train.columns
records = []
naoencontrados = []

for j in x_train.itertuples():
    other_attributes = {}
    for i in range(0,len(x_train.keys()),1):
        other_attributes[attrs[i]] = str(j[i+1])
    the_hash = hashlib.sha256(str(other_attributes).encode("utf-8")).hexdigest()
    cursor_mongo = list(db.debora_data.find({"hash":the_hash},{"record_id":"$record_id"}))
    if len(cursor_mongo) > 0:
        records.append(cursor_mongo[0])
    else:
        naoencontrados.append(other_attributes)

for j in x_test.itertuples():
    other_attributes = {}
    for i in range(0,len(x_test.keys()),1):
        other_attributes[attrs[i]] = str(j[i+1])
    the_hash = hashlib.sha256(str(other_attributes).encode("utf-8")).hexdigest()
    cursor_mongo = list(db.debora_data.find({"hash":the_hash},{"record_id":"$record_id"}))
    if len(cursor_mongo) > 0:
        records.append(cursor_mongo[0])
    else:
        naoencontrados.append(other_attributes)        

print(len(records))
print(naoencontrados)



# for i in x_train.itertuples():
#     my_data = i._asdict()
#     other_attributes = {}
#     for j in x_train.keys():
#         print(mydtypes[j])
#         other_attributes[j] = str(my_data[j], dtype=mydtypes[j])
#         #str(dframe[i].astype(mydtypes[i]))
#     print(other_attributes)
#     the_hash = str(hash(str(other_attributes)))
#     print(the_hash)
#     cursor_mongo = list(db.debora_data.find({"hash":the_hash},{"record_id":"$record_id"}))