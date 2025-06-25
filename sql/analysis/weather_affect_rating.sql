WITH review AS (
    SELECT
        business_id AS business_id,
        stars       AS stars,
        date(date)  AS review_date
    FROM data_warehouse.fct_review
),

weather AS (
    SELECT
        date           AS date,
        is_bad_weather AS is_bad_weather
    FROM data_warehouse.dim_weather
),

base AS (
    SELECT
        review.stars           AS stars,
        weather.is_bad_weather AS is_bad_weather
    FROM review
    INNER JOIN weather ON review.review_date = weather.date
)

SELECT
    is_bad_weather AS is_bad_weather,
    avg(stars)     AS avg_stars
FROM base
GROUP BY is_bad_weather