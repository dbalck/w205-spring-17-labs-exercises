select h.hospital_name, hs.provider_id as id, stddev_pop(hs.hospital_score) as standard_dev
	from hospitals_scored hs
	right join hospitals h
	group by h.hospital_name, hs.provider_id
	sort by standard_dev desc
	limit 10;
