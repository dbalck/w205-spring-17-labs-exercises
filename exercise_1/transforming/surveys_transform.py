from pyspark import SparkContext
from pyspark.sql import SQLContext
from pyspark.sql.types import *
sc = SparkContext("local", "surveys")

lines = sc.textFile("hdfs:///user/w205/hospital_compare/surveys_responses")
indices = range(7, 33) 
tokens = lines.map(lambda l: l.split(","))
# get the scores and filter out all the string except the actual numeric score
survey_scores = parts.map(lambda p: list(p[i] for i in indices))
survey_scores = survey_scores.map(lambda tokens: tuple(int(token.substr(0,2)) for token in tokens))




survey_scores = survey_scores.map(lambda score: score.split(" ")[0])
header = ["provider_id", "communication_with_nurses_achievement_points", "communication_with_nurses_improvement_points", "communication_with_nurses_dimension_score","communication_with_doctors_achievement_points", "communication_with_doctors_improvement_points", "communication_with_doctors_dimension_score", "responsiveness_of_hospital_staff_achievement_points", "responsiveness_of_hospital_staff_improvement_points", "responsiveness_of_hospital_staff_dimension_score", "pain_management_achievement_points", "pain_management_improvement_points", "pain_management_dimension_score", "communication_about_medicines_achievement_points", "communication_about_medicines_improvement_points", "communication_about_medicines_dimension_score", "cleanliness_and_quietness_of_hospital_environment_achievement_points", "cleanliness_and_quietness_of_hospital_environment_improvement_points", "cleanliness_and_quietness_of_hospital_environment_dimension_score", "discharge_information_achievement_points", "discharge_information_improvement_points", "discharge_information_dimension_score", "overall_rating_of_hospital_achievement_points", "overall_rating_of_hospital_improvement_points", "overall_rating_of_hospital_dimension_score", "hcahps_base_score", "hcahps_consistency_score"]
indices.insert(0,0)
fields = [StructField(f, StringType(), True) for f in header]
schema = StructType(fields)



