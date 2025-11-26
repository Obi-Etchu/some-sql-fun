SELECT 
    pickup_city,
    COUNT(*) AS total_rides,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides,
    ROUND(SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent
FROM rides_clean
GROUP BY pickup_city
ORDER BY cancellation_rate_percent DESC;

-- To find just the worst city:
SELECT 
    pickup_city,
    ROUND(SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS cancellation_rate_percent
FROM rides_clean
GROUP BY pickup_city
ORDER BY cancellation_rate_percent DESC
LIMIT 1;