INSERT INTO ods.business (
    business_id,
    name,
    address,
    city,
    state,
    postal_code,
    latitude,
    longitude,
    stars,
    review_count,
    is_open,
    attributes,
    categories,
    hours
)
SELECT
    business_id               AS business_id,
    name                      AS name,
    address                   AS address,
    city                      AS city,
    state                     AS state,
    postal_code               AS postal_code,
    latitude                  AS latitude,
    longitude                 AS longitude,
    stars                     AS stars,
    cast(review_count AS int) AS review_count,
    is_open                   AS is_open,
    attributes                AS attributes,
    categories                AS categories,
    hours                     AS hours
FROM staging.business;


