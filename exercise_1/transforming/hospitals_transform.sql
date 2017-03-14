CREATE TABLE hospital_scores (
	provider_id STRING, 
	hospital_name STRING,
	total_num_measures INT, 
	readmission_delta DOUBLE,
	readmission_num INT,
	effective_care_delta DOUBLE, 
	effective_care_num INT, 
	surgical_complications_delta DOUBLE,
	surgical_complications_num INT,
	infections_delta DOUBLE,   
	infections_num INT, 
	imaging_efficiency_delta DOUBLE,
	imaging_efficiency_num DOUBLE
);
	
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
	"separatorChar" = ",",
	"quoteChar" = '"',
	"escapeChar" = '\\'
)
AS
	select 
		h.provider_id AS id, 
		h.hospital_name AS name, 
		h.state AS state, 
		AVG(r.score) AS rscore, 
		COUNT(r.measure_id) AS rcount, 
		AVG(e.score) AS escore, 
		COUNT(e.score) AS ecount 
	from hospitals h 
	JOIN readmissions r ON ( h.provider_id = r.provider_id ) 
	JOIN effective_care e ON (e.provider_id = h.provider_id) 
	GROUP BY h.provider_id, h.hospital_name, h.state 
	ORDER BY rscore desc

create table hospital_scores
