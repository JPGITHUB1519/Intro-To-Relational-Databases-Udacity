import sqlite3

# coneccting to database
conn = sqlite3.connect("cookies")
# cursor fetch result and save data
cursor = conn.cursor()
cursor.execute("select host_key from cookies limit 10")
# get all results, to fetch only on is fetchone()
result = cursor.fetchall()
print results
# always close the connection
con.close()
