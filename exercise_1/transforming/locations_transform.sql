CREATE TABLE locations 
	AS
		SELECT provider_id, address, city, state, zip_code, county_name
		FROM hospitals;
	
