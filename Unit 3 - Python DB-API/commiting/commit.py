import sqlite3


db = sqlite3.connect("users")
c = db.cursor()
c.execute("INSERT INTO test VALUES(2,'JEAN')")
db.commit()
db.close()