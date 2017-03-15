DROP TABLE IF EXISTS state_scores;
CREATE TABLE state_scores (state STRING, hcahps_base_score_mean DOUBLE, num_hospitals INT, mean_procedure_z_score DOUBLE);
INSERT INTO TABLE state_scores
	SELECT	h.state, AVG(s.hcahps_base_score), COUNT(DISTINCT h.provider_id) as hosp_count, AVG(p.hospital_z_score)
	FROM hospitals h
	LEFT JOIN surveys_scored s ON ( h.provider_id = s.provider_id ) 
	LEFT JOIN hospitals_scored p ON (h.provider_id = p.provider_id) 
	GROUP BY h.state;
