import psycopg2
import sys 

class Histogram():
	
    def __init__(self):
        # Connect to the db tcount
        self.conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    def get_words(self, gt, lt):
        # get the wordcount for a supplied word
        cur = self.conn.cursor()
        cur.execute("SELECT * FROM tweetwordcount WHERE (count >= %(gt)s AND count <= %(lt)s );", {"gt": gt, "lt": lt})
        results = cur.fetchall()
        for line in results:
                print "\"{}\": {}".format(line[0], str(line[1]))
        self.conn.commit()
        
    def __enter__(self):
        self.obj = Histogram()
        return self.obj

    def __exit__(self, exc_type, exc_value, traceback):
        self.conn.close()

if __name__ == '__main__':
    with Histogram() as hg:
    # determine whether this is for a single word count, or all word counts
        if (len(sys.argv) < 2):
            print "Insufficient arguments, exiting...\n"
            sys.exit(0)
        else:
            args = sys.argv[1] 
            gt, lt = args.split(",")
            hg.get_words(gt, lt)

