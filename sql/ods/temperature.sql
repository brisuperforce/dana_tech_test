INSERT INTO ods.temperature (
    date,
    min,
    max,
    normal_min,
    normal_max
)
SELECT
    cast(date AS date) AS date,
    cast(
        CASE
            WHEN min = '' THEN '0'
            ELSE min
        END AS float
    )                  AS min,
    cast(
        CASE
            WHEN max = '' THEN '0'
            ELSE max
        END AS float
    )                  AS max,
    cast(
        CASE
            WHEN normal_min = '' THEN '0'
            ELSE normal_min
        END AS float
    )                  AS normal_min,
    cast(
        CASE
            WHEN normal_max = '' THEN '0'
            ELSE normal_max
        END AS float
    )                  AS normal_max
FROM staging.temperature;