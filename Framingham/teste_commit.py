import pymonetdb 
import time

with open("D:/ipaw-23-experiments/Framingham/fhs-records.txt") as file:
  lines = [line.rstrip('\n') for line in file]

start = time.time()

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()
query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'train');")
cursor.executemany(query, lines)
connection.commit()
connection.close()

end = time.time()
print("no commit")
print(end - start)

start = time.time()

connection = pymonetdb.connect(username="monetdb", password="monetdb", hostname="localhost", port="50000", database="dataflow_analyzer")
cursor = connection.cursor()
query = ("INSERT INTO record_tuples(record_id,record_type) VALUES (%s,'train');COMMIT;")
cursor.executemany(query, lines)
connection.close()

end = time.time()
print("with commit")
print(end - start)