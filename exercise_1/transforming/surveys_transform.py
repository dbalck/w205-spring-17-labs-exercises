from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql import HiveContext
from pyspark.sql.types import *

sc = SparkContext("local", "surveys")
hiveContext = HiveContext(sc)

lines = sc.textFile("hdfs:///user/w205/hospital_compare/surveys_responses")
parts = lines.map(lambda l: l.split("\",\""))
row_clean = parts.map(lambda p:  (p[0][1:], p[7].split(" ")[0], p[8].split(" ")[0], p[9].split(" ")[0], p[10].split(" ")[0], p[11].split(" ")[0], p[12].split(" ")[0], p[13].split(" ")[0], p[14].split(" ")[0], p[15].split(" ")[0], p[16].split(" ")[0], p[17].split(" ")[0], p[18].split(" ")[0], p[19].split(" ")[0], p[20].split(" ")[0], p[21].split(" ")[0], p[22].split(" ")[0], p[23].split(" ")[0], p[24].split(" ")[0], p[25].split(" ")[0], p[26].split(" ")[0], p[27].split(" ")[0], p[28].split(" ")[0], p[29].split(" ")[0], p[30].split(" ")[0], p[31].split(" ")[0], p[32].split(" ")[0]))

header = ["provider_id", "communication_with_nurses_achievement_points", "communication_with_nurses_improvement_points", "communication_with_nurses_dimension_score","communication_with_doctors_achievement_points", "communication_with_doctors_improvement_points", "communication_with_doctors_dimension_score", "responsiveness_of_hospital_staff_achievement_points", "responsiveness_of_hospital_staff_improvement_points", "responsiveness_of_hospital_staff_dimension_score", "pain_management_achievement_points", "pain_management_improvement_points", "pain_management_dimension_score", "communication_about_medicines_achievement_points", "communication_about_medicines_improvement_points", "communication_about_medicines_dimension_score", "cleanliness_and_quietness_of_hospital_environment_achievement_points", "cleanliness_and_quietness_of_hospital_environment_improvement_points", "cleanliness_and_quietness_of_hospital_environment_dimension_score", "discharge_information_achievement_points", "discharge_information_improvement_points", "discharge_information_dimension_score", "overall_rating_of_hospital_achievement_points", "overall_rating_of_hospital_improvement_points", "overall_rating_of_hospital_dimension_score", "hcahps_base_score", "hcahps_consistency_score"]
fields = [StructField(f, StringType(), True) for f in header]
schema = StructType(fields)
data = hiveContext.createDataFrame(row_clean, schema)
data.registerTempTable('surveys_temp')
results = hiveContext.sql("select * from surveys_temp")
results.saveAsTable("surveys_scored")


