SELECT *
FROM finance_loans;

CREATE TABLE `finance_loans_USE` (
  `application_id` text,
  `applicant_name` text,
  `dob` text,
  `loan_amount` text,
  `status` text,
  `credit_score` text,
  `R_NO` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO finance_loans_use
SELECT *,
row_number() OVER(PARTITION BY APPLICATION_ID,APPLICANT_NAME,DOB,
					LOAN_AMOUNT,`STATUS`,CREDIT_SCORE) AS R_NO
FROM finance_loans;

SELECT *
FROM finance_loans_use;

SELECT *
FROM finance_loans_use
WHERE R_NO>1;

SELECT *
FROM finance_loans_use
WHERE application_id='A002';

DELETE
FROM finance_loans_use
WHERE R_NO>1;

ALTER TABLE finance_loans_use
DROP COLUMN	R_NO;

SELECT DISTINCT(APPLICANT_NAME)
FROM finance_loans_use
ORDER BY 1;

UPDATE finance_loans_use
SET APPLICANT_NAME=UPPER(TRIM(APPLICANT_NAME));

SELECT DISTINCT(CREDIT_SCORE)
FROM finance_loans_use;

ALTER TABLE finance_loans_use
MODIFY COLUMN credit_score INT;

SELECT DISTINCT(`STATUS`)
FROM finance_loans_use;

UPDATE finance_loans_use
SET `STATUS`=UPPER(TRIM(`STATUS`));

SELECT distinct(LOAN_AMOUNT)
FROM finance_loans_use;

UPDATE finance_loans_use
SET LOAN_AMOUNT=REPLACE(LOAN_AMOUNT,'$','');

UPDATE finance_loans_use
SET LOAN_AMOUNT= CASE
					WHEN LOAN_AMOUNT LIKE '%THOUSAND' THEN '15000'
                    ELSE LOAN_AMOUNT
				END;

ALTER TABLE finance_loans_use
MODIFY COLUMN LOAN_AMOUNT INT;

SELECT DISTINCT(DOB)
FROM finance_loans_use;

SELECT DOB,
CASE
WHEN DOB LIKE '%-%-%' THEN
	CASE
	WHEN substring(DOB,6,2) BETWEEN 01 AND 12 THEN
		str_to_date(DOB,'%Y-%m-%d')
	ELSE
		str_to_date(DOB,'%Y-%d-%m')
	END
ELSE str_to_date(DOB,'%Y/%m/%d')
END AS NEW_DATE
FROM finance_loans_use;

UPDATE finance_loans_use
SET DOB=
CASE
WHEN DOB LIKE '%-%-%' THEN
	CASE
	WHEN substring(DOB,6,2) BETWEEN 01 AND 12 THEN
		str_to_date(DOB,'%Y-%m-%d')
	ELSE
		str_to_date(DOB,'%Y-%d-%m')
	END
ELSE str_to_date(DOB,'%Y/%m/%d')
END;
commit;

ALTER TABLE finance_loans_use
MODIFY column DOB DATE;

SELECT *
FROM finance_loans_use;