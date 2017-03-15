data_dir=$1

cd $data_dir
mkdir $data_dir/hospital_data_no_headers/
chmod 777 $data_dir/hospital_data_no_headers/

# remove headers and move these files into a common directory
tail -n +2 $data_dir/Hospital\ General\ Information.csv > $data_dir/hospital_data_no_headers/hospitals.csv # hospital info
tail -n +2 $data_dir/Measure\ Dates.csv > $data_dir/hospital_data_no_headers/measures.csv # measure info
tail -n +2 $data_dir/hvbp_hcahps_05_28_2015.csv > $data_dir/hospital_data_no_headers/surveys_responses.csv # surveys
tail -n +2 $data_dir/Timely\ and\ Effective\ Care\ -\ Hospital.csv > $data_dir/hospital_data_no_headers/effective_care.csv # procedures 
tail -n +2 $data_dir/Readmissions\ and\ Deaths\ -\ Hospital.csv > $data_dir/hospital_data_no_headers/readmissions.csv # procedures 
tail -n +2 $data_dir/Complications\ -\ Hospital.csv > $data_dir/hospital_data_no_headers/surgical_complications.csv  # procedures 
tail -n +2 $data_dir/Healthcare\ Associated\ Infections\ -\ Hospital.csv > $data_dir/hospital_data_no_headers/infections.csv  # procedures 
tail -n +2 $data_dir/Outpatient\ Imaging\ Efficiency\ -\ Hospital.csv > $data_dir/hospital_data_no_headers/imaging_efficiency.csv # procedures 

# create directories for each file because hive reads from directories
cd $data_dir/hospital_data_no_headers
hdfs dfs -mkdir -p /user/w205/hospital_compare/hospitals
hdfs dfs -mkdir -p /user/w205/hospital_compare/measures
hdfs dfs -mkdir -p /user/w205/hospital_compare/surveys_responses
hdfs dfs -mkdir -p /user/w205/hospital_compare/effective_care
hdfs dfs -mkdir -p /user/w205/hospital_compare/readmissions
hdfs dfs -mkdir -p /user/w205/hospital_compare/surgical_complications
hdfs dfs -mkdir -p /user/w205/hospital_compare/infections
hdfs dfs -mkdir -p /user/w205/hospital_compare/imaging_efficiency

# move the files to their hdfs directories
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures
hdfs dfs -put surveys_responses.csv /user/w205/hospital_compare/surveys_responses
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions
hdfs dfs -put surgical_complications.csv /user/w205/hospital_compare/surgical_complications
hdfs dfs -put infections.csv /user/w205/hospital_compare/infections
hdfs dfs -put imaging_efficiency.csv /user/w205/hospital_compare/imaging_efficiency


