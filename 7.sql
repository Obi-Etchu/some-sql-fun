WITH driver_city_revenue AS (
    SELECT 
        r.pickup_city,
        d.driver_id,
        d.name AS driver_name,
        SUM(p.amount) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY r.pickup_city ORDER BY SUM(p.amount) DESC) AS city_rank
    FROM rides_clean r
    INNER JOIN drivers_clean d ON r.driver_id = d.driver_id
    INNER JOIN payments_clean p ON r.ride_id = p.ride_id
    WHERE r.status = 'completed'
      AND p.amount > 0                   
      AND r.pickup_time >= '2021-06-01'
      AND r.pickup_time < '2025-01-01'
    GROUP BY r.pickup_city, d.driver_id, d.name
)
SELECT 
    pickup_city,
    driver_id,
    driver_name,
    ROUND(total_revenue::NUMERIC, 2) AS total_revenue,
    city_rank
FROM driver_city_revenue
WHERE city_rank <= 3
ORDER BY pickup_city, city_rank;