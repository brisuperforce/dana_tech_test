-- inserting into ods.review
INSERT INTO ods.review (
    review_id,
    user_id,
    business_id,
    stars,
    useful,
    funny,
    cool,
    text,
    date
)
SELECT
    review_id               AS review_id,
    user_id                 AS user_id,
    business_id             AS business_id,
    CAST(stars AS int)      AS stars,
    CAST(useful AS int)     AS useful,
    CAST(funny AS int)      AS funny,
    CAST(cool AS int)       AS cool,
    text                    AS text,
    CAST(date AS timestamp) AS date
FROM staging.review;