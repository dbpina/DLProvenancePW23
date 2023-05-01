import pandas
from sklearn.model_selection import train_test_split
import numpy as np

from datetime import datetime
import os
import time
import pymonetdb

from threading import Thread

dataflow_tag = "framingham"
exec_tag = dataflow_tag + "-" + str(datetime.now())
start = time.time()

def split_data():
  print("split data")
  data = pandas.read_csv("D:/ipaw-23-experiments/Framingham/fhs.csv")

  x = data.drop('TenYearCHD', axis=1)
  x = x.drop('id', axis=1)
  y = data['TenYearCHD']

  x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

  x_train.to_csv('train.csv')
  y_train.to_csv('ytrain.csv')
  x_test.to_csv('test.csv')
  y_test.to_csv('ytest.csv')

def save_records():  
  print("saving records")
  with open("D:/ipaw-23-experiments/Framingham/fhs-records.txt") as file:
      lines = [line.rstrip('\n') for line in file]

  connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
  cursor = connection.cursor()
  query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'train'); COMMIT;")
  cursor.executemany(query, lines)
  connection.close()

def write_csv():
  print("training my NN")
  time.sleep(50)

threadlist = []

threadlist.append(Thread(target=split_data))
threadlist.append(Thread(target=save_records))
threadlist.append(Thread(target=write_csv))

for t in threadlist:
  t.start()

for t in threadlist:
  t.join()

end = time.time()
print(end - start)  