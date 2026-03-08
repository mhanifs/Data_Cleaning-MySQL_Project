Project Overview

This project demonstrates a structured approach to cleaning and preparing raw data using MySQL.

Real-world datasets often contain duplicates, inconsistent formatting, and missing values. These issues must be addressed before performing meaningful analysis.

The goal of this project is to transform a raw layoffs dataset into a clean, structured dataset ready for analysis and reporting.


---

Dataset

The dataset contains information about layoffs across different companies and industries.

Dataset Fields

Column	Description

company	company name
location	company location
industry	industry sector
total_laid_off	number of employees laid off
percentage_laid_off	percentage of employees laid off
date	layoff date
stage	company funding stage
country	company headquarters country
funds_raised_millions	funding raised by the company


Like many real-world datasets, the raw data contains duplicates, missing values, and inconsistent formatting.


---

Tools Used

MySQL

SQL



---

Data Cleaning Process

The following steps were performed to clean and standardize the dataset.


---

1. Removing Duplicate Records

Duplicate rows were identified and removed using SQL techniques such as window functions and ROW_NUMBER() to ensure each record represents a unique layoff event.


---

2. Standardizing Text Fields

Several columns contained inconsistent formatting.

Cleaning actions included:

trimming whitespace

standardizing company names

normalizing industry labels

correcting country name variations.


This ensures reliable grouping and aggregation during analysis.


---

3. Handling Missing Values

The dataset contained NULL or missing values in some fields.

Steps included:

identifying null values

populating missing data where possible

removing records that could not be corrected.



---

4. Fixing Date Formats

The date column was converted into a proper DATE data type to allow time-based analysis.


---

5. Removing Unnecessary Columns

Columns that were no longer required after cleaning were removed to produce a simplified and analysis-ready dataset.


---

Before vs After Cleaning

Example Issues in Raw Dataset

company	industry	country

CryptoCurrency	crypto	United States.
crypto currency	crypto	United States
Airbnb	NULL	United States


Problems identified:

duplicate entries

inconsistent text formatting

missing values

inconsistent country naming.



---

Cleaned Dataset Example

company	industry	country

Crypto	Crypto	United States
Airbnb	Travel	United States


Improvements:

duplicates removed

consistent naming conventions

standardized fields

missing values handled.



---

Example Business Insights

Once cleaned, the dataset can be used to generate insights.

Layoffs by Industry

SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_cleaned
GROUP BY industry
ORDER BY total_layoffs DESC;


---

Layoffs by Year

SELECT YEAR(date) AS year, SUM(total_laid_off) AS layoffs
FROM layoffs_cleaned
GROUP BY year
ORDER BY year;


---

Top Companies by Layoffs

SELECT company, SUM(total_laid_off) AS layoffs
FROM layoffs_cleaned
GROUP BY company
ORDER BY layoffs DESC;

These queries demonstrate how the cleaned dataset can be used for business analysis and reporting.


---

Key SQL Concepts Demonstrated

This project demonstrates several practical SQL skills used in real-world data workflows:

Data cleaning using SQL

Common Table Expressions (CTEs)

Window functions (ROW_NUMBER)

Handling null values

Text standardization

Data type conversion

Data preparation for analytics.

Author

Hanif S

Data professional with experience in SQL, data analysis, and data engineering workflows.


---

Portfolio Purpose

This project is part of a SQL portfolio demonstrating practical data preparation and cleaning techniques used in real-world analytics projects.
