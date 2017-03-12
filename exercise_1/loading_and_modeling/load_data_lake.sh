tail -n +2 Hospital\ General\ Information.csv > hospitals.csv
tail -n +2 Timely\ and\ Effective\ Care\ -\ Hospital.csv > effective_care.csv
tail -n +2 Readmissions\ and\ Deaths\ -\ Hospital.csv > readmissions.csv
tail -n +2 Measure\ Dates.csv > measures.csv
tail -n +2 hvbp_hcahps_05_28_2015.csv > surveys_responses.csv

# move these files into a common directory
mkdir hospital_data
mv -t hospital_data hospitals.csv effective_care.csv readmissions.csv measures.csv survey_responses.csv

# move the directory to hdfs
su - hdfs
hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -put /hospital_data/* /user/w205/hospital_compare

