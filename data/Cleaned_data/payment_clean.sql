CREATE TABLE payments_clean AS
SELECT DISTINCT
    payment_id,
    ride_id,
	amount,
    method,
	paid_date
FROM payments_raw
WHERE amount > 0
AND paid_date BETWEEN '2021-06-01' AND '2024-12-31';
