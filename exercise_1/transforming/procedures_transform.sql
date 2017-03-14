-- create procedures table
CREATE TABLE procedure_scores (provider_id INT, measure_name STRING, measure_id STRING, score_type STRING, score_mean DOUBLE, score_sd DOUBLE);

-- insert data per procedure measure type
INSERT INTO TABLE procedures_scores (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT provider_id, measure_name, measure_id, "readmission", avg(score), stddev_pop(score) 
	FROM readmissions
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT provider_id, measure_name, measure_id, "effective_care", avg(score), stddev_pop(score) 
	FROM effective_care
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT provider_id, measure_name, measure_id, "surgical_complications", avg(score), stddev_pop(score) 
	FROM surgical_complications; 
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT provider_id, measure_name, measure_id, "infections", avg(score), stddev_pop(score) 
	FROM infections;
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT provider_id, measure_name, measure_id, "imaging_efficiency", avg(score), stddev_pop(score) 
	FROM imaging_efficiency
	GROUP BY measure_name, measure_id;
