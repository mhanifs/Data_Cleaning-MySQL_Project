Project Overview

This project focuses on cleaning and preparing a real-world layoffs dataset using MySQL. Raw datasets often contain inconsistencies, duplicates, missing values, and formatting issues that must be resolved before meaningful analysis can be performed.

The objective of this project is to demonstrate a structured SQL-based data cleaning workflow that transforms raw data into a reliable dataset ready for analysis.


---

Dataset

The dataset used in this project contains information about layoffs across companies and industries. It includes fields such as:

Company name

Location

Industry

Total employees laid off

Percentage of layoffs

Date of layoffs

Company funding stage

Country


Like many real-world datasets, the data initially contained duplicates, inconsistent formatting, and missing values, which required systematic cleaning.


---

Tools Used

MySQL

SQL (Data Cleaning Techniques)



---

Data Cleaning Steps

The following data cleaning operations were performed:

1. Removing Duplicate Records

Duplicate rows were identified and removed using SQL techniques such as ROW_NUMBER() with Common Table Expressions (CTEs) to retain only unique records.


---

2. Standardizing Text Data

Several text fields contained inconsistent formatting. Standardization steps included:

Normalizing company names

Standardizing industry labels

Cleaning country name variations

Trimming unnecessary whitespace


This ensures consistent grouping and analysis later.


---

3. Handling Missing and Null Values

Some records contained null or missing values in fields such as industry or total layoffs.

Cleaning steps included:

Identifying null values

Filling missing information where possible

Removing unusable records when necessary



---

4. Correcting Data Types

Certain fields required formatting adjustments to ensure proper analysis.

Examples include:

Converting date columns into proper DATE format

Ensuring numerical columns were stored as numeric values



---

5. Removing Unnecessary Columns

Columns that were no longer required after the cleaning process were removed to produce a simplified, analysis-ready dataset.


---

Result

After the cleaning process, the dataset was transformed into a clean and structured table suitable for analysis and reporting.

The final dataset can now be used for tasks such as:

analyzing layoffs by industry

identifying trends over time

comparing layoffs across companies and locations.



---

Key SQL Concepts Demonstrated

This project highlights practical SQL skills used in real-world data preparation:

Common Table Expressions (CTEs)

Window functions (ROW_NUMBER)

Data standardization techniques

Handling null and missing values

Data type conversion

Data transformation using SQL



---

Why Data Cleaning Matters

Data cleaning is one of the most important steps in any data analysis workflow. Poor data quality can lead to incorrect insights and unreliable reporting.

This project demonstrates how SQL can be used to systematically clean and prepare raw datasets for accurate analysis and decision-making.


---

Project Structure

Data_Cleaning-MySQL_Project
│
├── Data Cleaning Project.sql
├── README.md


---

Author

Hanif S

Data professional with experience in SQL, data analysis, and data engineering workflow
