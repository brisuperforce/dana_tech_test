-- inserting into ods.precipitation
INSERT INTO ods.precipitation (
    date,
    precipitation,
    precipitation_normal
)
SELECT
    CAST(date AS date) AS date,
    CAST(
        CASE
            WHEN precipitation IN ('', 'T') THEN '0'
            ELSE precipitation
        END AS float
    )                  AS precipitation,
    CAST(
        CASE
            WHEN precipitation_normal IN ('', 'T') THEN '0'
            ELSE precipitation_normal
        END AS float
    )                  AS precipitation_normal
FROM staging.precipitation;