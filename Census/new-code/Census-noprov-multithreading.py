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
from threading import Thread

start = time.time()
def train_nn():
  epochs=300

  class MyCallback(tf.keras.callbacks.Callback):
    def __init__(self):
      self.start_time = None

    def on_epoch_begin(self, epoch, logs=None):
      self.start_time = time.time()

    def on_epoch_end(self, epoch, logs=None):
      print(logs)
      elapsed_time = time.time()-self.start_time


  opt = Adam(learning_rate=0.001)

  classifier = Sequential()

  classifier.add(Dense(2, activation = 'relu'))

  classifier.add(Dense(units = 8, kernel_initializer = 'uniform', activation = 'relu'))

  classifier.add(Dense(units = 1, kernel_initializer = 'uniform', activation = 'sigmoid'))

  classifier.compile(optimizer = opt, loss = 'binary_crossentropy', metrics = ['accuracy'])

  classifier.fit(x_train, y_train, batch_size=32, epochs = epochs, verbose = 1, validation_split=0.2, callbacks=[MyCallback()])

  test_metric = classifier.evaluate(x_test, y_test)
  print(test_metric)

if __name__ == '__main__':
  data = pandas.read_csv("D:/giuliap/DataProvenance/prov_acquisition/census-hash.csv")

  x = data.drop('label', axis=1)
  x = x.drop('id', axis=1)
  y = data['label']

  x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, shuffle = False, stratify = None)

  x_train.to_csv('train.csv')
  y_train.to_csv('ytrain.csv')
  x_test.to_csv('test.csv')
  y_test.to_csv('ytest.csv')

  threadlist = []

  threadlist.append(Thread(target=train_nn))

  for t in threadlist:
    t.start()

  for t in threadlist:
    t.join()

  end = time.time()
  print(end-start)    