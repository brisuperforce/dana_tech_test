INSERT INTO ods.checkin (
    business_id,
    date
)
SELECT 
    business_id,
    date
FROM staging.checkin 
;