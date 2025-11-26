SELECT 
    rid.rider_id,
    rid.name,
    COUNT(DISTINCT r.ride_id) AS total_rides
FROM riders_clean rid
INNER JOIN rides_cleaned r ON rid.rider_id = r.rider_id
INNER JOIN payments_cleaned p ON r.ride_id = p.ride_id
WHERE r.status = 'completed'
  AND p.amount > 0                
GROUP BY rid.rider_id, rid.name
HAVING COUNT(DISTINCT r.ride_id) > 10;

-- STEP 2: Exclude riders who ever used cash
SELECT 
    rid.rider_id,
    rid.name,
    COUNT(DISTINCT r.ride_id) AS total_rides
FROM riders_clean rid
INNER JOIN rides_cleaned r ON rid.rider_id = r.rider_id
INNER JOIN payments_cleaned p ON r.ride_id = p.ride_id
WHERE r.status = 'completed'
  AND p.amount > 0               
  AND rid.rider_id NOT IN (
      -- find all riders who ever paid with cash
      SELECT DISTINCT r2.rider_id
      FROM rides_cleaned r2
      INNER JOIN payments_cleaned p2 ON r2.ride_id = p2.ride_id
      WHERE LOWER(p2.method) = 'cash'  
        AND r2.status = 'completed'
        AND p2.amount > 0               
  )
GROUP BY rid.rider_id, rid.name
HAVING COUNT(DISTINCT r.ride_id) > 10
ORDER BY total_rides DESC;
