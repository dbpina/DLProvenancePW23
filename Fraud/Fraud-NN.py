import pandas
from sklearn.model_selection import train_test_split
import numpy as np

import keras
from keras.models import Sequential
from keras.layers import Dense
from tensorflow.keras.optimizers import Adam
import tensorflow as tf

from datetime import datetime
import os
import time

from dfa_lib_python.dataflow import Dataflow
from dfa_lib_python.transformation import Transformation
from dfa_lib_python.attribute import Attribute
from dfa_lib_python.attribute_type import AttributeType
from dfa_lib_python.set import Set
from dfa_lib_python.set_type import SetType
from dfa_lib_python.task import Task
from dfa_lib_python.dataset import DataSet
from dfa_lib_python.element import Element
from dfa_lib_python.task_status import TaskStatus

dataflow_tag = "credit-fraud"
exec_tag = dataflow_tag + "-" + str(datetime.now())

df = Dataflow(dataflow_tag, True)
df.save()

epochs=100

class MyCallback(tf.keras.callbacks.Callback):
  def __init__(self):
    self.start_time = None

  def on_epoch_begin(self, epoch, logs=None):
    self.start_time = time.time()

  def on_epoch_end(self, epoch, logs=None):
    print(logs)
    elapsed_time = time.time()-self.start_time
    tf1_output = DataSet("oTrainingModel", [Element([datetime.now().strftime('%Y-%m-%d %H:%M:%S'), elapsed_time, -9999999 if np.isnan(logs['loss']) else logs['loss'], -9999999 if np.isnan(logs['accuracy']) else logs['accuracy'], -9999999 if np.isnan(logs['val_loss']) else logs['val_loss'], -9999999 if np.isnan(logs['val_accuracy']) else logs['val_accuracy'] , epoch])])
    #tf1_output = DataSet("oTrainingModel", [Element([datetime.now().strftime('%Y-%m-%d %H:%M:%S'), "elapsed_time", logs['loss'], logs['accuracy'], epoch])])
    t1.add_dataset(tf1_output)
    if(epoch==epochs-1):
        t1.end()
    else:
        t1.save()

data = pandas.read_csv("/scratch/rtm-uq/debora.pina/ipaw-23-experiments/Fraud/fraud.csv")

t_tuples = Task(1, dataflow_tag, exec_tag, "SplitDataset")
tinput_tuples = DataSet("iTuples", [Element(["/scratch/rtm-uq/debora.pina/ipaw-23-experiments/Fraud/credit.csv","Fraud","Credit Card Fraud"])])
t_tuples.add_dataset(tinput_tuples)
t_tuples.begin()

x = data.drop('Class', axis=1)
x = x.drop('id', axis=1)
y = data['Class']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

x_train.to_csv('train.csv')
y_train.to_csv('ytrain.csv')
x_test.to_csv('test.csv')
y_test.to_csv('ytest.csv')


t1 = Task(2, dataflow_tag, exec_tag, "TrainingModel")

opt = Adam(learning_rate=0.001)

model = Sequential()
model.add(Dense(X_train_new.shape[1], activation = 'relu', input_dim = X_train_new.shape[1]))
model.add(BatchNormalization())

model.add(Dense(64, activation = 'relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))

model.add(Dense(64, activation = 'relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))

model.add(Dense(1, activation = 'sigmoid'))


tf1_input = DataSet("iTrainingModel", [Element([opt.get_config()['name'], opt.get_config()['learning_rate'], epochs, len(classifier.layers)])])
t1.add_dataset(tf1_input)
#t1.save()
t1.begin()

classifier.compile(optimizer = opt, loss = 'binary_crossentropy', metrics = ['accuracy'])

classifier.fit(x_train, y_train, batch_size=256, epochs = epochs, verbose = 1, validation_split=0.2, callbacks=[MyCallback()])


t2 = Task(3, dataflow_tag, exec_tag, "TestingModel", dependency=t1)
t2.begin()

test_metric = classifier.evaluate(x_test, y_test)
print(test_metric)

testing_output = DataSet("oTestingModel", [Element([-9999999 if np.isnan(test_metric[0]) else test_metric[0], -9999999 if np.isnan(test_metric[1]) else test_metric[1]])])
t2.add_dataset(testing_output)
t2.end()

start = time.time()

with open("/scratch/rtm-uq/debora.pina/ipaw-23-experiments/Fraud/fraud-records.txt") as file:
  lines = [line.rstrip('\n') for line in file]

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()
query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'train');")
cursor.executemany(query, lines)
connection.commit()
connection.close()

toutput_tuples = DataSet("oTuples",[Element(["train.csv", "train"])])
t_tuples.add_dataset(toutput_tuples)
t_tuples.end()

end = time.time()
print(end - start)