from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2 



class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()
	self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
	self.cur = self.conn.cursor()
	self.exec_str = """update tweetwordcount set count=%(count)s where word=%(word)s;
insert into tweetwordcount (word, count) 
	select %(word)s, %(count)s where not exists (select 1 from tweetwordcount where word=%(word)s);"""	

    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount 
        # Table name: Tweetwordcount 
        # you need to create both the database and the table in advance.
        

        # Increment the local count
        self.counts[word] += 1
        #self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
	self.cur.execute(self.exec_str, {"word": word, "count": self.counts[word]})
	self.conn.commit()

def _handle_run_exception(self, exc):
        """Process an exception encountered while running the ``run()`` loop.

        Called right before program exits.
        """
	self.conn.close()
