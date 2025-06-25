INSERT INTO data_warehouse.dim_weather (
    date,
    is_bad_weather
)
WITH temperature AS (
    SELECT
        date       AS date,
        min        AS t_min,
        max        AS t_max,
        normal_min AS normal_min,
        normal_max AS normal_max,
        NOT coalesce(
            min < normal_min AND max < normal_max,
            FALSE
        )          AS is_bad_weather_t
    FROM ods.temperature
    WHERE (min > 0 OR max > 0)
),

precipitation AS (
    SELECT
        date                 AS date,
        precipitation        AS precipitation,
        precipitation_normal AS precipitation_normal,
        NOT coalesce(
            precipitation < precipitation_normal,
            FALSE
        )                    AS is_bad_weather_p
    FROM ods.precipitation
)

SELECT
    temperature.date AS date,
    coalesce(
        (temperature.is_bad_weather_t OR precipitation.is_bad_weather_p) IS TRUE,
        FALSE
    )                AS is_bad_weather
FROM temperature
LEFT JOIN precipitation ON temperature.date = precipitation.date;
