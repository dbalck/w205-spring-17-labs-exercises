from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql.types import *
sc = SparkContext("local", "surveys")

lines = sc.textFile("hdfs:///user/w205/hospital_compare/surveys_responses")
tokens = lines.map(lambda l: l.split(","))
surveys = parts.map
surveys_schema = ["provider_id"]

