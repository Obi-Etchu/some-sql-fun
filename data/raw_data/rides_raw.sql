CREATE TABLE rides_raw (
    ride_id SERIAL PRIMARY KEY,
    rider_id INT,
	driver_id INT,
    request_time TIMESTAMP,
	pickup_time TIMESTAMP,
	dropoff_time TIMESTAMP,
    pickup_city TEXT,
    dropoff_city TEXT,
    distance_km FLOAT,
	status TEXT,
	fare FLOAT
);