CREATE TABLE drivers_raw (
    driver_id SERIAL PRIMARY KEY,
	name TEXT,
    city TEXT,
    signup_date TIMESTAMP,
	rating FLOAT
)