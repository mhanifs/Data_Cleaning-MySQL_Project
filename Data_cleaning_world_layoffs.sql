-- Create database
CREATE DATABASE world_layoffs;

-- Select database for use
USE world_layoffs;

-- Create table and import dataset

SELECT * FROM layoffs;

-- Steps involved in data cleaning as follows
-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Handle NULL and blank values
-- 4. Remove any Columns or Rows not necessary

-- Creating a new table to as layoff_stagging_1 to preserve the original data

CREATE TABLE layoffs_stagging_1
LIKE layoffs;

SHOW TABLES;

-- Insert values in the new table from original table
INSERT layoffs_stagging_1
SELECT * FROM layoffs;

SELECT * FROM layoffs_stagging_1;

-- Removing duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stagging_1;

-- Using this query as cte to filter the duplicates
WITH cte_duplicates AS 
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stagging_1
)
SELECT * FROM cte_duplicates
WHERE row_num > 1;

-- Create table layoffs_stagging_2 to store dataset with duplicate records deleted
-- We used Creates statement from the clipboard to create the table from 


CREATE TABLE `layoffs_stagging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert values with row_numbers in layoffs_stagging_2 table 

INSERT INTO layoffs_stagging_2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_stagging_1;

-- Delete duplicating records by filtering row_num > 1
DELETE 
FROM layoffs_stagging_2
WHERE row_num > 1;

-- Verify the duplicates have been removed
SELECT * 
FROM layoffs_stagging_2 
WHERE row_num >1;

SELECT * FROM layoffs_stagging_2;

-- Remove column row_number from layoffs_stagging_2 to prevent extra overheads

ALTER TABLE layoffs_stagging_2
DROP column row_num;

-- Standardizing data

-- Removing white spaces from the company column
SELECT company, TRIM(company)
FROM layoffs_stagging_2;

UPDATE layoffs_stagging_2
SET company = TRIM(company);

-- Removing white spaces from the industry column
SELECT industry, TRIM(industry)
FROM layoffs_stagging_2;

UPDATE layoffs_stagging_2
SET industry = TRIM(industry);

-- Removing white spaces from the location column
SELECT location, TRIM(location)
FROM layoffs_stagging_2;

UPDATE layoffs_stagging_2
SET location = TRIM(location);

-- Review records for disticnt records for mispellings that could lead to duplicate segments
-- We have Crypto, CryptoCurrency, Crypto Currency, let's change all them to Crypto
SELECT DISTINCT(industry) 
FROM layoffs_stagging_2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_stagging_2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Verify if the update
SELECT DISTINCT industry
FROM layoffs_stagging_2;

SELECT DISTINCT country
FROM layoffs_stagging_2;

-- Similary we have Country column has 'United States' and 'United States.'.
--  Fixing '.' using trim and trailing

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_stagging_2
WHERE country LIKE 'United States%';

UPDATE layoffs_stagging_2
SET country = 'United States'
WHERE country LIKE 'United States%';

DESCRIBE layoffs_stagging_2;
-- The date column has datatype. Convert using string to date function STR_TO_DATE()
SELECT date, STR_TO_DATE(date, '%m/%d/%Y') 
FROM layoffs_stagging_2;

UPDATE layoffs_stagging_2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

DESCRIBE layoffs_stagging_2;

-- The date column is still in text format, so update the datatype in the table schema
ALTER TABLE layoffs_stagging_2
MODIFY column `date` DATE;
-- The date column has now been corrected to datatype date. Verify using describe
DESCRIBE layoffs_stagging_2;

-- Handling null and blank values

SELECT *
FROM  layoffs_stagging_2
WHERE industry IS NULL 
OR industry = '';

SELECT * 
FROM layoffs_stagging_2 
WHERE company = 'Airbnb';

-- Airbnb, Caravana, Juul in company records have blank values in industry however, 
-- Carvana has transportatio Airbnb has Travel Juul has Consumer in other records
-- We should be using the above data to populate the values
SELECT t1.company, t1.location, t1.industry, t2.industry
FROM layoffs_stagging_2 t1
JOIN layoffs_stagging_2 t2
ON t1.company = t2.company
WHERE  t1.industry = ''
AND t2.industry IS NOT NULL;

-- Update statement did not let us update from blank '' to new value, so we changed it 
-- to null first, then changed the null to the new values
UPDATE layoffs_stagging_2 
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_stagging_2 t1
JOIN layoffs_stagging_2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- Values having null in both total_laid_off and percentage_laid_off columns are 
-- not credible data and should be removed
SELECT * 
FROM  layoffs_stagging_2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

DELETE
FROM  layoffs_stagging_2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;
