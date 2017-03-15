DROP TABLE IF EXISTS procedures_scores;

-- create procedures table
CREATE TABLE procedures_scores (measure_name STRING, measure_id STRING, score_type STRING, score_num INT, score_mean DOUBLE, score_sd DOUBLE);

-- insert data per procedure measure type
INSERT INTO TABLE procedures_scores -- (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT measure_name, measure_id, "readmissions", count(score), avg(score), stddev_pop(score) 
	FROM readmissions
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores -- (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT measure_name, measure_id, "effective_care", count(score),  avg(score), stddev_pop(score) 
	FROM effective_care
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores -- (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT measure_name, measure_id, "surgical_complications", count(score), avg(score), stddev_pop(score) 
	FROM surgical_complications
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores -- (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT measure_name, measure_id, "infections", count(score), avg(score), stddev_pop(score) 
	FROM infections
	GROUP BY measure_name, measure_id;
INSERT INTO TABLE procedures_scores -- (provider_id, measure_name, measure_id, measure_type, score_mean, score_sd ) 
	SELECT measure_name, measure_id, "imaging_efficiency", count(score), avg(score), stddev_pop(score) 
	FROM imaging_efficiency
	GROUP BY measure_name, measure_id;

