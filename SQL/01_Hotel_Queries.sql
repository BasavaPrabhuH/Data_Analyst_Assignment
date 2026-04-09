
CREATE TABLE users (
    user_id VARCHAR PRIMARY KEY,
    name VARCHAR,
    phone_number VARCHAR,
    mail_id VARCHAR,
    billing_address VARCHAR
);

CREATE TABLE bookings (
    booking_id VARCHAR PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no VARCHAR,
    user_id VARCHAR
);

CREATE TABLE items (
    item_id VARCHAR PRIMARY KEY,
    item_name VARCHAR,
    item_rate INT
);

CREATE TABLE booking_commercials (
    id VARCHAR PRIMARY KEY,
    booking_id VARCHAR,
    bill_id VARCHAR,
    bill_date TIMESTAMP,
    item_id VARCHAR,
    item_quantity FLOAT
);
