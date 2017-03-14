CREATE TABLE state_scores
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
AS
	SELECT	
		h.state AS state, 
		COUNT(DISTINCT h.provider_id) as hosp_count,
		AVG(s.overall_rating_of_hospital_achievement_points) AS overall_ach_points, 
		AVG(r.score) AS readmit_score, 
		COUNT(r.measure_id) AS readmit_count, 
		AVG(e.score) AS effective_score, 
		COUNT(e.score) AS effective_count 
	FROM hospitals h
	LEFT JOIN survey_responses s ON ( h.provider_id = s.provider_id ) 
	LEFT JOIN readmissions r ON ( h.provider_id = r.provider_id ) 
	LEFT JOIN effective_care e ON (h.provider_id = e.provider_id) 
	GROUP BY h.state;
