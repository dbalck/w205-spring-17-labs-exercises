	SELECT	
		h.state AS state, 
		COUNT(DISTINCT h.provider_id) as hosp_count,
		AVG(r.score) AS readmit_score, 
		COUNT(case when r.provider_id is not null then 1 else NULL end ) AS readmit_count, 
		AVG(e.score) AS effective_score, 
		COUNT(case when e.score is not null then 1 else NULL end ) AS effective_count 
	FROM hospitals h
	LEFT JOIN survey_responses s ON ( h.provider_id = s.provider_id ) 
	LEFT JOIN readmissions r ON ( h.provider_id = r.provider_id ) 
	LEFT JOIN effective_care e ON (h.provider_id = e.provider_id) 
	GROUP BY h.state;