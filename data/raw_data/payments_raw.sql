CREATE TABLE payments_raw (
    payment_id SERIAL PRIMARY KEY,
	ride_id SERIAL,
    amount FLOAT,
	method TEXT,
    paid_date TIMESTAMP
)