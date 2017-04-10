import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

# Connect to the database
conn = psycopg2.connect(database="postgres", user="postgres", password="pass", host="localhost", port="5432")

#Create the Database if it doesn't exist
try:
    # CREATE DATABASE can't run inside a transaction
    conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
    cur = conn.cursor()
    cur.execute("CREATE DATABASE tcount")
    cur.close()
    conn.close()
except:
    print "Could not create tcount; it probably already exists"

# Connect to the db tcount
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

# Drop the table if it's there (it's stale)
cur = conn.cursor()
cur.execute("DROP TABLE IF EXISTS tweetwordcount;")
conn.commit()

# Create the table tweetwordcount
cur = conn.cursor()
cur.execute('''CREATE TABLE tweetwordcount
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);''')
conn.commit()

# test the db/table 
cur = conn.cursor()
cur.execute("SELECT * from pg_class where relname='tweetwordcount';")
print cur.fetchall()
conn.commit()


# Close out the sql connection now that our db and table exist
conn.close()



#Select
# cur.execute("SELECT word, count from tweetwordcount")
# records = cur.fetchall()
# for rec in records:
#    print "word = ", rec[0]
#    print "count = ", rec[1], "\n"
# conn.commit()


