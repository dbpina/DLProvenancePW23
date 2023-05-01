# Necessary packages
import sys
import pandas as pd
import numpy as np
import time
import argparse
import os

def main(opt):
	input_path = "D:/Downloads/UCI_Credit_Card.csv/UCI_Credit_Card.csv"
	df = pd.read_csv(input_path)

	df['AGE'].mask(df['AGE'] < 50 , 0, inplace=True)
	df['AGE'].mask(df['AGE'] >=50 , 1, inplace=True)

	# df['race'].mask(df['race'] != 'White', 1, inplace=True)
	# df['race'].mask(df['race'] == 'White', 0, inplace=True)

	print(df['AGE'].value_counts())
	print(df.columns)
	df.to_csv('censustry1.csv')  	


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('-op', dest='opt', action='store_true', help='Use the optimized capture')
	args = parser.parse_args()
	main(args.opt)