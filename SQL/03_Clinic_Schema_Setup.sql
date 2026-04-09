CREATE TABLE clinics (
    cid VARCHAR PRIMARY KEY,
    clinic_name VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR
);

CREATE TABLE customer (
    uid VARCHAR PRIMARY KEY,
    name VARCHAR,
    mobile VARCHAR
);

CREATE TABLE clinic_sales (
    oid VARCHAR PRIMARY KEY,
    uid VARCHAR,
    cid VARCHAR,
    amount INT,
    datetime TIMESTAMP,
    sales_channel VARCHAR
);

CREATE TABLE expenses (
    eid VARCHAR PRIMARY KEY,
    cid VARCHAR,
    description VARCHAR,
    amount INT,
    datetime TIMESTAMP
);
