import pandas
from sklearn.model_selection import train_test_split
import numpy as np

import keras
from keras.models import Sequential
from keras.layers import Dense, BatchNormalization, Dropout
from tensorflow.keras.optimizers import Adam
import tensorflow as tf

from datetime import datetime
import os
import time

epochs=100

class MyCallback(tf.keras.callbacks.Callback):
  def __init__(self):
    self.start_time = None

  def on_epoch_begin(self, epoch, logs=None):
    self.start_time = time.time()

  def on_epoch_end(self, epoch, logs=None):
    print(logs)
    elapsed_time = time.time()-self.start_time

data = pandas.read_csv("D:/ipaw-23-experiments/Fraud/fraud.csv")

x = data.drop('Class', axis=1)
x = x.drop('id', axis=1)
y = data['Class']

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

x_train.to_csv('train.csv')
y_train.to_csv('ytrain.csv')
x_test.to_csv('test.csv')
y_test.to_csv('ytest.csv')

opt = Adam(learning_rate=0.001)

model = Sequential()
model.add(Dense(x_train.shape[1], activation = 'relu', input_dim = x_train.shape[1]))
model.add(BatchNormalization())

model.add(Dense(64, activation = 'relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))

model.add(Dense(64, activation = 'relu'))
model.add(BatchNormalization())
model.add(Dropout(0.5))

model.add(Dense(1, activation = 'sigmoid'))


model.compile(optimizer = opt, loss = 'binary_crossentropy', metrics = ['accuracy'])

model.fit(x_train, y_train, batch_size=32, epochs = epochs, verbose = 1, validation_split=0.2, callbacks=[MyCallback()])

test_metric = model.evaluate(x_test, y_test)
print(test_metric)