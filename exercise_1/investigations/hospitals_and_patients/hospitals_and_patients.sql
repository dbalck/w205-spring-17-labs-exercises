select corr(hs.hospital_z_score, cast(s.hcahps_base_score as int)) as correlation
        from hospitals_scored hs
	inner join surveys_scored s on s.provider_id = hs.provider_id
	sort by correlation
	limit 10;
