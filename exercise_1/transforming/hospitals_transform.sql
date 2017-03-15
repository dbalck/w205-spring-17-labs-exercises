DROP TABLE hospitals_scored;
CREATE TABLE hospitals_scored (provider_id STRING, measure_name STRING, measure_id STRING, hospital_score DOUBLE, hospital_z_score DOUBLE, score_mean DOUBLE, score_sd DOUBLE);
INSERT INTO TABLE hospitals_scored
	SELECT r.provider_id, r.measure_name, r.measure_id, r.score, (r.score - ps.score_mean) / ps.score_sd, ps.score_mean, ps.score_sd
	FROM readmissions r
	LEFT JOIN procedures_scores ps
	ON r.measure_name =  ps.measure_name AND ps.score_type = 'readmissions';
INSERT INTO TABLE hospitals_scored
	SELECT r.provider_id, r.measure_name, r.measure_id, r.score, (r.score - ps.score_mean) / ps.score_sd, ps.score_mean, ps.score_sd
	FROM effective_care r
	LEFT JOIN procedures_scores ps
	ON r.measure_name =  ps.measure_name AND ps.score_type = 'effective_care';
INSERT INTO TABLE hospitals_scored
	SELECT r.provider_id, r.measure_name, r.measure_id, r.score, (r.score - ps.score_mean) / ps.score_sd, ps.score_mean, ps.score_sd
	FROM surgical_complications r
	LEFT JOIN procedures_scores ps
	ON r.measure_name =  ps.measure_name AND ps.score_type = 'surgical_complications';
INSERT INTO TABLE hospitals_scored
	SELECT r.provider_id, r.measure_name, r.measure_id, r.score, (r.score - ps.score_mean) / ps.score_sd, ps.score_mean, ps.score_sd
	FROM infections r
	LEFT JOIN procedures_scores ps
	ON r.measure_name =  ps.measure_name AND ps.score_type = 'infections';
INSERT INTO TABLE hospitals_scored
	SELECT r.provider_id, r.measure_name, r.measure_id, r.score, (r.score - ps.score_mean) / ps.score_sd, ps.score_mean, ps.score_sd
	FROM imaging_efficiency r
	LEFT JOIN procedures_scores ps
	ON r.measure_name =  ps.measure_name AND ps.score_type = 'imaging_efficiency';
