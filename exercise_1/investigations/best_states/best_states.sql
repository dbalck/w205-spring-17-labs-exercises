select s.state as name, s.hcahps_base_score_mean as survey_score, mean_procedure_z_score as z_score
        from state_scores s
	where s.hcahps_base_score_mean is not null and mean_procedure_z_score is not null
        sort by z_score asc, survey_score desc
	limit 10;
