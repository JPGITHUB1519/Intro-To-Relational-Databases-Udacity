#
# Database access functions for the web forum.
# 

import time
import psycopg2
import itertools
import bleach
## Database connection
DB = []
cont_string = "host='localhost' dbname='forum' user='postgres' password='root'"
## Get posts from database.
def GetAllPosts():
  '''Get all the posts from the database, sorted with the newest first.

  Returns:
    A list of dictionaries, where each dictionary has a 'content' key
    pointing to the post content, and 'time' key pointing to the time
    it was posted.
  '''
  conn = psycopg2.connect(cont_string)
  cursor = conn.cursor()
  cursor.execute("SELECT * FROM POSTS ORDER BY TIME")
  posts = ({'content' : str(row[1]), 'time' : str(row[0])} 
          for row in cursor.fetchall())
  conn.close()
  return posts
## Add a post to the database.
def AddPost(content):
  '''Add a new post to the database.
  Args:
    content: The text content of the new post.
  '''
  # cleaning content for malicious javascript
  #content = bleach.clean(content)
  # database code
  conn = psycopg2.connect(cont_string)
  cursor = conn.cursor()
  # sql inyection vulnerable
  # cursor.execute("insert into posts(content) VALUES('%s')" % content)

  # curing sql inyection yeah past parameters
  cursor.execute("insert into posts(content) VALUES(%s)", (content,))
  conn.commit()
  conn.close()

def queryToDict(cursor,query_str):
    cursor.execute(query_str)
    return [dict(zip([column[0] for column in cursor.description], row)) for row in cursor.fetchall()]


data = GetAllPosts()
print data

