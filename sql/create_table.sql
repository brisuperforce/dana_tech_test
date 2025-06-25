-- create schema
CREATE SCHEMA IF NOT EXISTS staging;

CREATE SCHEMA IF NOT EXISTS ods;

CREATE SCHEMA IF NOT EXISTS data_warehouse;

CREATE SCHEMA IF NOT EXISTS data_mart;

-- create table for staging schema
CREATE TABLE IF NOT EXISTS staging.checkin
(
    business_id VARCHAR(50) NOT NULL,
    date TEXT NULL
);

CREATE INDEX IF NOT EXISTS business_id_checkin
ON staging.checkin(business_id);

CREATE TABLE IF NOT EXISTS staging.business
(
    business_id VARCHAR(50) NOT NULL,
    name VARCHAR (255) NULL,
    address TEXT NULL,
    city    VARCHAR(100) NULL,
    state   VARCHAR(100) NULL,
    postal_code VARCHAR(50) NULL,
    latitude VARCHAR(100) NULL,
    longitude VARCHAR(100) NULL,
    stars   VARCHAR(100) NULL,
    review_count VARCHAR(100) NULL,
    is_open TEXT NULL,
    attributes TEXT NULL,
    categories TEXT NULL,
    hours TEXT NULL,
    CONSTRAINT business_id_pk PRIMARY KEY (business_id)
);

CREATE TABLE IF NOT EXISTS staging.review
(
    review_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    business_id VARCHAR(50) NOT NULL,
    stars   VARCHAR(100) NULL,
    useful INT NULL,
    funny INT NULL,
    cool INT NULL,
    text TEXT NULL,
    date VARCHAR(50) NULL,
    CONSTRAINT review_id_pk PRIMARY KEY (review_id)
);

CREATE TABLE IF NOT EXISTS staging.user
(
    user_id VARCHAR(50) NOT NULL,
    name VARCHAR(50) NULL,
    review_count VARCHAR(50) NULL,
    yelping_since    VARCHAR(50) NULL,
    useful   TEXT NULL,
    funny TEXT NULL,
    cool TEXT NULL,
    elite TEXT NULL,
    friends   TEXT null,
    fans TEXT NULL,
    average_stars VARCHAR(50) NULL,
    compliment_hot VARCHAR(50) NULL,
    compliment_more VARCHAR(50) NULL,
    compliment_profile VARCHAR(50) NULL,
    compliment_cute VARCHAR(50) NULL,
    compliment_list VARCHAR(50) NULL,
    compliment_note VARCHAR(50) NULL,
    compliment_plain VARCHAR(50) NULL,
    compliment_cool VARCHAR(50) NULL,
    compliment_funny VARCHAR(50) NULL,
    compliment_writer VARCHAR(50) NULL,
    compliment_photos VARCHAR(50) null,
    CONSTRAINT user_id_pk PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS staging.tip
(
    user_id VARCHAR(50) NOT NULL,
    business_id VARCHAR(50) NULL,
    text TEXT NULL,
    date    VARCHAR(50) NULL,
    compliment_count   VARCHAR(50) NULL
)
;
CREATE TABLE IF NOT EXISTS staging.temperature
(
    date VARCHAR(50) NOT NULL,
    min VARCHAR(50) NULL,
    max VARCHAR(50) NULL,
    normal_min    VARCHAR(50) NULL,
    normal_max   VARCHAR(50) NULL
)
;

CREATE TABLE IF NOT EXISTS staging.precipitation
(
    date VARCHAR NOT NULL,
    precipitation VARCHAR(50) NULL,
    precipitation_normal VARCHAR(50) NULL
)
;

-- create table for ods schema
CREATE TABLE IF NOT EXISTS ods.temperature
(
    date DATE NOT NULL,
    min FLOAT NULL,
    max FLOAT NULL,
    normal_min    FLOAT NULL,
    normal_max   FLOAT null,
    CONSTRAINT date_pk PRIMARY KEY (date)
)
;

CREATE TABLE IF NOT EXISTS ods.precipitation
(
    date DATE NOT NULL,
    precipitation FLOAT NULL,
    precipitation_normal FLOAT NULL,
    CONSTRAINT date_precipitation_pk PRIMARY KEY (date)
)
;

CREATE TABLE IF NOT EXISTS ods.review
(
    review_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NULL,
    business_id VARCHAR(50) NULL,
    stars    INT NULL,
    useful   INT NULL,
    funny INT NULL,
    cool INT NULL,
    text TEXT NULL,
    date   timestamp without time zone NULL,
    CONSTRAINT review_id_pk PRIMARY KEY (review_id)
);


CREATE TABLE IF NOT EXISTS ods.tip
(
    user_id VARCHAR(50) NOT NULL,
    business_id VARCHAR(50) NULL,
    text TEXT NULL,
    date    TIMESTAMP NULL,
    compliment_count   INT NULL
)
;

CREATE TABLE IF NOT EXISTS ods.user
(
    user_id VARCHAR(50) NOT NULL,
    name VARCHAR(50) NULL,
    review_count INT NULL,
    yelping_since    TIMESTAMP NULL,
    useful   TEXT NULL,
    funny TEXT NULL,
    cool TEXT NULL,
    elite TEXT NULL,
    friends   TEXT null,
    fans TEXT NULL,
    average_stars VARCHAR(50) NULL,
    compliment_hot VARCHAR(50) NULL,
    compliment_more VARCHAR(50) NULL,
    compliment_profile VARCHAR(50) NULL,
    compliment_cute VARCHAR(50) NULL,
    compliment_list VARCHAR(50) NULL,
    compliment_note VARCHAR(50) NULL,
    compliment_plain VARCHAR(50) NULL,
    compliment_cool VARCHAR(50) NULL,
    compliment_funny VARCHAR(50) NULL,
    compliment_writer VARCHAR(50) NULL,
    compliment_photos VARCHAR(50) null,
    CONSTRAINT user_id_pk PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS ods.business
(
    business_id VARCHAR(50) NOT NULL,
    name VARCHAR (255) NULL,
    address TEXT NULL,
    city    VARCHAR(100) NULL,
    state   VARCHAR(100) NULL,
    postal_code VARCHAR(50) NULL,
    latitude VARCHAR(100) NULL,
    longitude VARCHAR(100) NULL,
    stars   VARCHAR(100) NULL,
    review_count INT NULL,
    is_open TEXT NULL,
    attributes TEXT NULL,
    categories TEXT NULL,
    hours TEXT NULL,
    CONSTRAINT business_id_pk PRIMARY KEY (business_id)
);

CREATE TABLE IF NOT EXISTS ods.checkin
(
    business_id VARCHAR(50) NOT NULL,
    date TEXT NULL
);

-- create table for dwh schema
CREATE TABLE IF NOT EXISTS data_warehouse.fct_review
(
    review_id VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NULL,
    business_id VARCHAR(50) NULL,
    stars    INT NULL,
    date   TIMESTAMP NULL,
    text TEXT NULL,
    useful INT NULL,
    funny INT NULL,
    cool   INT NULL,
    CONSTRAINT review_id_fact_review PRIMARY KEY (review_id)
);


CREATE TABLE IF NOT EXISTS data_warehouse.dim_weather
(
    date DATE NOT NULL,
    is_bad_weather BOOLEAN NULL,
    CONSTRAINT date_id_dim_weather PRIMARY KEY (date)
);


CREATE TABLE IF NOT EXISTS data_warehouse.dim_user
(
    user_id VARCHAR(50) NOT NULL,
    name VARCHAR(50) NULL,
    review_count INT NULL,
    yelping_since    TIMESTAMP NULL,
    useful   TEXT NULL,
    funny TEXT NULL,
    cool TEXT NULL,
    fans TEXT NULL,
    average_stars VARCHAR(50) NULL,
    CONSTRAINT user_id_dim_user_pk PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS data_warehouse.dim_business
(
    business_id VARCHAR(50) NOT NULL,
    name VARCHAR (255) NULL,
    address TEXT NULL,
    city    VARCHAR(100) NULL,
    state   VARCHAR(100) NULL,
    postal_code VARCHAR(50) NULL,
    latitude VARCHAR(100) NULL,
    longitude VARCHAR(100) NULL,
    stars   VARCHAR(100) NULL,
    review_count INT NULL,
    is_open TEXT NULL,
    CONSTRAINT business_id_dim_business_pk PRIMARY KEY (business_id)
);
