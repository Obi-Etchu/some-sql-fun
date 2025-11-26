CREATE TABLE rides_clean AS
SELECT DISTINCT
    ride_id,
    rider_id,
	driver_id,
    request_time
	pickup_time,
	dropoff_time,
    INITCAP(TRIM(pickup_city)) AS pickup_city,
    INITCAP(TRIM(dropoff_city)) AS dropoff_city,
    distance_km,
	fare
FROM rides_raw
WHERE distance_km > 0
  AND distance_km < 1000
  AND fare > 0
  AND pickup_time BETWEEN '2021-06-01' AND '2024-12-31';
