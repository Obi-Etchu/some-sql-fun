CREATE TABLE drivers_clean AS
SELECT DISTINCT
    driver_id,
    name,
	city,
    signup_date,
	rating
FROM drivers_raw
WHERE rating between 1 and 5
AND signup_date BETWEEN '2021-06-01' AND '2024-12-31';
