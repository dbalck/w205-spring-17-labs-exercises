select h.hospital_name as name, hs.provider_id as id, AVG(hs.hospital_z_score) as score
        from hospitals_scored hs
        right join hospitals h on hs.provider_id = h.provider_id
	where (hs.hospital_z_score is not null)
        group by h.hospital_name, hs.provider_id
        sort by score asc 
	limit 10;
