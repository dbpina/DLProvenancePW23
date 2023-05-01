# Necessary packages
import sys
sys.path.append('../')
from prov_acquisition.prov_libraries import provenance as pr
from prov_acquisition.prov_libraries import provenance_lib as pr_lib
import pandas as pd
import numpy as np
import time
import argparse
import os
from sklearn.preprocessing import StandardScaler

def main(opt):
	input_path = 'D:/ipaw-23-experiments/Fraud/creditcard.csv'
	filename_ext = os.path.basename(input_path)
	filename, ext = os.path.splitext(filename_ext)
	output_path = 'prov_results'
	
	# Specify where to save the processed files as savepath
	savepath = os.path.join(output_path, filename)

	df = pd.read_csv(input_path, nrows=50000)

	#df.isnull().sum()	

	print('[' + time.strftime("%d/%m-%H:%M:%S") +'] Initialization')

	# Create a new provenance document
	if opt: 
		p = pr.Provenance(df, savepath)
	else:
		savepath = os.path.join(savepath, 'FP')
		p = pr_lib.Provenance(df, savepath)
           
    #OPERATION 0	           
	df.drop('Time', axis = 1, inplace = True)

	#PROVENANCE 0
	d = p.get_prov_dim_reduction(df)	

	#OPERATION 1	      
	sc = StandardScaler()
	amount = df['Amount'].values
	df['Amount'] = sc.fit_transform(amount.reshape(-1, 1))	

	#PROVENANCE 1
	d = p.get_prov_value_transformation(df, ['Amount'])

	#OPERATION 2
	df.drop_duplicates(inplace=True)

	#PROVENANCE 2
	d = p.get_prov_dim_reduction(df)

	print('[' + time.strftime("%d/%m-%H:%M:%S") +'] Prov saved')

	df.to_csv('fraud.csv')  	

	p.save_debora_entities("D:/ipaw-23-experiments/Fraud", "sample_hash_total")

if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('-op', dest='opt', action='store_true', help='Use the optimized capture')
	args = parser.parse_args()
	main(args.opt)