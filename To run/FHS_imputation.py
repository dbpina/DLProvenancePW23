# Necessary packages
import sys
import pandas as pd
import numpy as np
import time
import argparse
import os
import statistics

def main(opt):
	input_path = 'D:/ipaw-23-experiments/Framingham/framingham.csv'
	filename_ext = os.path.basename(input_path)
	filename, ext = os.path.splitext(filename_ext)
	output_path = 'prov_results'
	
	# Specify where to save the processed files as savepath
	savepath = os.path.join(output_path, filename)

	df = pd.read_csv(input_path)
	#print(df.dtypes)

	print('[' + time.strftime("%d/%m-%H:%M:%S") +'] Initialization')

           
    #OPERATION 0	           
	#Drop education variable
	df = df.drop(['education'], axis=1)
	#PROVENANCE 0
	#d = p.get_prov_dim_reduction(df)

	#OPERATION 1
	#Replace missing value for cigsPerDay for median
	# cigarette_index = df[df['cigsPerDay'].isnull()].index	
	# current_smoke_status = []
	# for i in cigarette_index:
	#    current_smoke_status.append(df['currentSmoker'][i])	
	# smokers = df[df['currentSmoker'] == 1].index
	# cigarettes_by_smokers = []
	# for i in smokers:
	#      if df['cigsPerDay'][i] != 'nan':
	#         cigarettes_by_smokers.append(df['cigsPerDay'][i])
	# smoker_median = statistics.median(cigarettes_by_smokers)
	# df['cigsPerDay'] = df['cigsPerDay'].fillna(smoker_median)

	cigs_missing = df[df["cigsPerDay"].isnull()].index
	df = df.drop(cigs_missing)

	smoker_missing = df[df["currentSmoker"].isnull()].index
	df = df.drop(smoker_missing)

	glucose_missing = df[df["glucose"].isnull()].index
	df = df.drop(glucose_missing)	

	bp_missing = df[df["BPMeds"].isnull()].index
	df = df.drop(bp_missing)

	df = df.drop(df[df["male"].isnull()].index)	
	df = df.drop(df[df["age"].isnull()].index)	
	df = df.drop(df[df["prevalentStroke"].isnull()].index)	
	df = df.drop(df[df["prevalentHyp"].isnull()].index)	
	df = df.drop(df[df["diabetes"].isnull()].index)	
	df = df.drop(df[df["diaBP"].isnull()].index)	
	df = df.drop(df[df["totChol"].isnull()].index)	
	df = df.drop(df[df["BMI"].isnull()].index)	
	df = df.drop(df[df["heartRate"].isnull()].index)	

	#PROVENANCE 1
	#d = p.get_prov_value_transformation(df, ['cigsPerDay'])

	#OPERATION 2
	#BPMed missing values: I made some research on Google, so if your blood pressure is higher than 140-90 
	#Doctors are recommending to take BPMed. So, I will check if sysBP is higher than 140 and/or diaBP is higher 
	#than 90, if so I will switch NaN values to 1 or 0
	#BP_missing_index = df[df['BPMeds'].isnull()].index	
	#for i in BP_missing_index:
	#    if ( df['sysBP'][i] > 140 or df['diaBP'][i] > 90 ):
	#        df.loc[i,'BPMeds'] = 1  
	#    else:
	#        df.loc[i,'BPMeds'] = 0	

	#PROVENANCE 2
	#d = p.get_prov_value_transformation(df, ['BPMeds'])

	#OPERATION 3

	#PROVENANCE 3
	#d = p.get_prov_value_transformation(df, ['totChol', 'BMI', 'glucose', 'heartRate'])	

	print(len(df))

	print('[' + time.strftime("%d/%m-%H:%M:%S") +'] Prov saved')

	#p.save_debora_entities("D:/ipaw-23-experiments/Framingham", "sample_hash")

	df.to_csv('fhs-imputation-4.csv')	


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument('-op', dest='opt', action='store_true', help='Use the optimized capture')
	args = parser.parse_args()
	main(args.opt)