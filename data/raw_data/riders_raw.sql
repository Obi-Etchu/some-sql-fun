CREATE TABLE riders_raw (
    rider_id SERIAL PRIMARY KEY,
    name varchar(100),
    signup_date TIMESTAMP,
    city TEXT,
    email VARCHAR(100)
)