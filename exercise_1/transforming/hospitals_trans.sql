create table hospital_scores
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
