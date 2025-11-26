SELECT 
    this_year.year,
    this_year.quarter,
    this_year.total_revenue AS revenue_this_year,
    last_year.total_revenue AS revenue_last_year,
    ROUND((((this_year.total_revenue - last_year.total_revenue) / last_year.total_revenue) * 100)::NUMERIC, 2) AS growth_percent
FROM (
    -- Revenue for each quarter
    SELECT 
        EXTRACT(YEAR FROM r.pickup_time)::INTEGER AS year,
        EXTRACT(QUARTER FROM r.pickup_time)::INTEGER AS quarter,
        SUM(p.amount) AS total_revenue
    FROM rides_clean r
    INNER JOIN payments_clean p ON r.ride_id = p.ride_id
    WHERE r.status = 'completed'
      AND p.amount > 0          
    GROUP BY EXTRACT(YEAR FROM r.pickup_time), EXTRACT(QUARTER FROM r.pickup_time)
) AS this_year
LEFT JOIN (
    SELECT 
        EXTRACT(YEAR FROM r.pickup_time)::INTEGER AS year,
        EXTRACT(QUARTER FROM r.pickup_time)::INTEGER AS quarter,
        SUM(p.amount) AS total_revenue
    FROM rides_clean r
    INNER JOIN payments_clean p ON r.ride_id = p.ride_id
    WHERE r.status = 'completed'
      AND p.amount > 0            
    GROUP BY EXTRACT(YEAR FROM r.pickup_time), EXTRACT(QUARTER FROM r.pickup_time)
) AS last_year ON this_year.quarter = last_year.quarter 
                 AND this_year.year = last_year.year + 1  
WHERE last_year.total_revenue IS NOT NULL
ORDER BY growth_percent DESC
LIMIT 1;