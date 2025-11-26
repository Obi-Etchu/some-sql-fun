-- STEP 1: Count rides per driver per month
SELECT 
d.driver_id,
d.name,
TO_CHAR(r.pickup_time, 'YYYY-MM') AS month,
count(r.ride_id) AS rides_this_month
FROM drivers_clean d
JOIN rides_clean r on r.driver_id = d.driver_id
JOIN payments_clean p on p.ride_id = r.ride_id
WHERE r.status = 'completed'
  AND p.amount > 0    
GROUP BY d.driver_id, d.name, TO_CHAR(r.pickup_time, 'YYYY-MM')
ORDER BY d.driver_id, month;  

-- STEP 2: Calculate average rides per month for each driver
SELECT 
    d.driver_id,
    d.name,
    COUNT(DISTINCT TO_CHAR(r.pickup_time, 'YYYY-MM')) AS months_active,
    COUNT(r.ride_id) AS total_rides,
    ROUND(COUNT(r.ride_id)::NUMERIC / COUNT(DISTINCT TO_CHAR(r.pickup_time, 'YYYY-MM')), 2) AS avg_rides_per_month
FROM drivers_clean d
INNER JOIN rides_clean r ON d.driver_id = r.driver_id
INNER JOIN payments_clean p ON r.ride_id = p.ride_id
WHERE r.status = 'completed'
  AND p.amount > 0                
GROUP BY d.driver_id, d.name
ORDER BY avg_rides_per_month DESC
LIMIT 5;