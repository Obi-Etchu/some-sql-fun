SELECT DISTINCT Count(r1.rider_id) AS number_of_active_riders
FROM riders_clean r1 
JOIN rides_clean r2 on r1.rider_id = r2.rider_id
JOIN payments_clean p on r2.ride_id = p.ride_id
WHERE EXTRACT (YEAR FROM r1.signup_date) = '2021'
AND EXTRACT (YEAR FROM r2.pickup_time) = '2024'
AND r2.status = 'completed'
AND p.amount > 0