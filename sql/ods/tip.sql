INSERT INTO ods.tip (
    user_id,
    business_id,
    text,
    date,
    compliment_count
)
SELECT
    user_id                       AS user_id,
    business_id                   AS business_id,
	text						  AS text,
    cast(date AS timestamp)       AS date,
    cast(compliment_count AS int) AS compliment_count
FROM staging.tip;
