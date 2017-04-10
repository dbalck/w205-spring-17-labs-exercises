import psycopg2
import sys


class FinalResults():
	
    def __init__(self):
        # Connect to the db tcount
        self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    def all_words(self):
        # Drop the table if it's there (it's stale)
        cur = self.conn.cursor()
        cur.execute("SELECT * FROM tweetwordcount ORDER BY word ASC;")
        results = cur.fetchall()
        for line in results:
            print line
        self.conn.commit()

    def single_word(self, word):
        # get the wordcount for a supplied word
        cur = self.conn.cursor()
        cur.execute("SELECT * FROM tweetwordcount WHERE word=%(word)s;", {"word": word})
        results = cur.fetchall()
        for line in results:
                print "Total number of occurences of \"{}\": ".format(word) + str(line[1])
        self.conn.commit()
        
    def __enter__(self):
        self.obj = FinalResults()
        return self.obj

    def __exit__(self, exc_type, exc_value, traceback):
        self.conn.close()

if __name__ == '__main__':
    with FinalResults() as fr:
    # determine whether this is for a single word count, or all word counts
        if (len(sys.argv) == 1):
            print "No arguments: printing top 50 words.\n"
            fr.all_words()
        else:
            word = sys.argv[1] 
            fr.single_word(word)

