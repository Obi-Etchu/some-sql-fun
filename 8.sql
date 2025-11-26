SELECT 
    d.driver_id,
    d.name,
    d.rating,
    COUNT(CASE WHEN r.status = 'completed' AND p.amount > 0 THEN 1 END) AS completed_rides,
    COUNT(CASE WHEN r.status = 'cancelled' THEN 1 END) AS cancelled_rides,
    ROUND(COUNT(CASE WHEN r.status = 'cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM drivers_clean d
INNER JOIN rides_clean r ON d.driver_id = r.driver_id
INNER JOIN payments_clean p ON r.ride_id = p.ride_id
GROUP BY d.driver_id, d.name, d.rating
HAVING COUNT(CASE WHEN r.status = 'completed' AND p.amount > 0 THEN 1 END) >= 30  
   AND d.rating >= 4.5                                                             
   AND ROUND(COUNT(CASE WHEN r.status = 'cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) < 5.0  
ORDER BY completed_rides DESC, d.rating DESC
LIMIT 10;