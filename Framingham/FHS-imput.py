import pandas

df = pandas.read_csv('D:/ipaw-23-experiments/Framingham/framingham.csv')

cigs_missing = df[df["cigsPerDay"].isnull()].index
df = df.drop(cigs_missing)

#glucose_missing = df[df["glucose"].isnull()].index
#df = df.drop(glucose_missing)

df.to_csv('fhs-hash-imputation-2.csv')