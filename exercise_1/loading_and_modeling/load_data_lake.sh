data_dir=$1

tail -n +2 $data_dir/Hospital\ General\ Information.csv > hospitals.csv
tail -n +2 $data_dir/Timely\ and\ Effective\ Care\ -\ Hospital.csv > effective_care.csv
tail -n +2 $data_dir/Readmissions\ and\ Deaths\ -\ Hospital.csv > readmissions.csv
tail -n +2 $data_dir/Measure\ Dates.csv > measures.csv
tail -n +2 $data_dir/hvbp_hcahps_05_28_2015.csv > surveys_responses.csv

# move these files into a common directory
mkdir $data_dir/hospital_data_no_headers
mv -t $data_dir/hospital_data_no_headers $data_dir/hospitals.csv $data_dir/effective_care.csv $data_dir/readmissions.csv $data_dir/measures.csv $data_dir/survey_responses.csv

# move the directory to hdfs
su - hdfs
cd $data_dir/hospital_data_no_headers
hdfs dfs -mkdir -p /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir -p /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir -p /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir -p /user/w205/hospital_compare/measures
hdfs dfs -mkdir -p /user/w205/hospital_compare/surveys_responses
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses

