Steps to execute Exercise 2

1. clone github repo containing the relevant code
e.g. "git clone <github repo>

2. cd into exercise_2/extweetwordcount
e.g. "cd w205-spring-17-labs-exercises/exercise_2/extweetwordcount"

3. run ./setup_environment <attached drive>
This will format and install postgres to an attached drive, as well as install tweepy and psycopg. If postgres is already installed, simply install tweepy and psycopg with pip.
e.g. "./setup_environment /dev/xvdf"

4. Run the init_db.py script to create the database. This will create a new tcount database and a tweetwordcount table as the postgres user. This table can later be cleared with reset_db.py.
e.g. "python init_db.py"

5. execute the stream parse inside the project folder. Since there is only a single topology, it should default to the extweetwordcount.clj topology. You may be prompted to hit <ENTER> if running as root, because the LEIN_ROOT is not set. This is normal. 
e.g. "sparse run"

6. finalresults.py and histogram.py can be found in the extweetwordcount folder and executed at will.
e.g. python finalresults.py hello
e.g. python histogram.py 10,15


