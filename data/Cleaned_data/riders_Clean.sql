CREATE TABLE riders_clean AS
SELECT DISTINCT
    rider_id,
	name,
    signup_date,
	city,
	email
FROM riders_raw
WHERE signup_date BETWEEN '2021-06-01' AND '2024-12-31';
