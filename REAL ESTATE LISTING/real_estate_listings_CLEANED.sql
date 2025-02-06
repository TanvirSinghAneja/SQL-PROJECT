SELECT *
FROM real_estate_listings;

CREATE TABLE `real_estate_listings_USE` (
  `listing_id` text,
  `address` text,
  `price` text,
  `sq_ft` text,
  `status` text,
  `R_NO` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO real_estate_listings_use
SELECT *,
row_number() OVER(partition by LISTING_ID,ADDRESS,PRICE,SQ_FT,`STATUS`) AS R_NO
FROM real_estate_listings;

select *
FROM real_estate_listings_use;

SELECT *
FROM real_estate_listings_use
WHERE listing_id='L002';

DELETE 
FROM real_estate_listings_use
WHERE R_NO>1;

SELECT DISTINCT(`STATUS`)
FROM real_estate_listings_use;

UPDATE real_estate_listings_use
SET STATUS=upper(TRIM(STATUS));

ALTER TABLE real_estate_listings_use
MODIFY COLUMN SQ_FT INT;

SELECT DISTINCT(PRICE)
FROM real_estate_listings_use;

UPDATE real_estate_listings_use
SET PRICE=REPLACE(PRICE,'$','');

UPDATE real_estate_listings_use
SET PRICE=REPLACE(PRICE,',','');

UPDATE real_estate_listings_use
SET PRICE=CASE
			WHEN PRICE= '250' THEN '250000'
            ELSE PRICE
		END;

ALTER TABLE real_estate_listings_use
DROP COLUMN R_NO;

SELECT *
FROM real_estate_listings_use;
-- CLEANED DATA