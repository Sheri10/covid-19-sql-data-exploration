/*
=============================================================
Create Database and Tables for Covid 19 Data Exploration
(MySQL version)
=============================================================
NOTE: most numeric-looking columns are stored as VARCHAR here,
not INT/DECIMAL. The source dataset (Our World in Data) has
many blank values scattered throughout these columns (early
pandemic dates, smaller countries, missing test/vaccination
data, etc.), and MySQL's LOAD DATA/import tools can fail or
silently drop rows when a blank hits a strict numeric column.
This also matches the original SQL Server tutorial, which runs
into the same issue and works around it with CAST() in the
analysis queries - already handled in the converted
covid_data_exploration_mysql.sql script.

`date` is a MySQL reserved word, so it's backticked wherever
it's used as a plain column name.
*/

CREATE DATABASE covid_project;
USE covid_project;

CREATE TABLE CovidDeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(100),
    location VARCHAR(100),
    `date` DATE,
    total_cases VARCHAR(50),
    new_cases VARCHAR(50),
    new_cases_smoothed VARCHAR(50),
    total_deaths VARCHAR(50),
    new_deaths VARCHAR(50),
    new_deaths_smoothed VARCHAR(50),
    total_cases_per_million VARCHAR(50),
    new_cases_per_million VARCHAR(50),
    new_cases_smoothed_per_million VARCHAR(50),
    total_deaths_per_million VARCHAR(50),
    new_deaths_per_million VARCHAR(50),
    new_deaths_smoothed_per_million VARCHAR(50),
    reproduction_rate VARCHAR(50),
    icu_patients VARCHAR(50),
    icu_patients_per_million VARCHAR(50),
    hosp_patients VARCHAR(50),
    hosp_patients_per_million VARCHAR(50),
    weekly_icu_admissions VARCHAR(50),
    weekly_icu_admissions_per_million VARCHAR(50),
    weekly_hosp_admissions VARCHAR(50),
    weekly_hosp_admissions_per_million VARCHAR(50),
    new_tests VARCHAR(50),
    total_tests VARCHAR(50),
    total_tests_per_thousand VARCHAR(50),
    new_tests_per_thousand VARCHAR(50),
    new_tests_smoothed VARCHAR(50),
    new_tests_smoothed_per_thousand VARCHAR(50),
    positive_rate VARCHAR(50),
    tests_per_case VARCHAR(50),
    tests_units VARCHAR(50),
    total_vaccinations VARCHAR(50),
    people_vaccinated VARCHAR(50),
    people_fully_vaccinated VARCHAR(50),
    new_vaccinations VARCHAR(50),
    new_vaccinations_smoothed VARCHAR(50),
    total_vaccinations_per_hundred VARCHAR(50),
    people_vaccinated_per_hundred VARCHAR(50),
    people_fully_vaccinated_per_hundred VARCHAR(50),
    new_vaccinations_smoothed_per_million VARCHAR(50),
    stringency_index VARCHAR(50),
    population VARCHAR(50),
    population_density VARCHAR(50),
    median_age VARCHAR(50),
    aged_65_older VARCHAR(50),
    aged_70_older VARCHAR(50),
    gdp_per_capita VARCHAR(50),
    extreme_poverty VARCHAR(50),
    cardiovasc_death_rate VARCHAR(50),
    diabetes_prevalence VARCHAR(50),
    female_smokers VARCHAR(50),
    male_smokers VARCHAR(50),
    handwashing_facilities VARCHAR(50),
    hospital_beds_per_thousand VARCHAR(50),
    life_expectancy VARCHAR(50),
    human_development_index VARCHAR(50)
);

CREATE TABLE CovidVaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(100),
    location VARCHAR(100),
    `date` DATE,
    new_tests VARCHAR(50),
    total_tests VARCHAR(50),
    total_tests_per_thousand VARCHAR(50),
    new_tests_per_thousand VARCHAR(50),
    new_tests_smoothed VARCHAR(50),
    new_tests_smoothed_per_thousand VARCHAR(50),
    positive_rate VARCHAR(50),
    tests_per_case VARCHAR(50),
    tests_units VARCHAR(50),
    total_vaccinations VARCHAR(50),
    people_vaccinated VARCHAR(50),
    people_fully_vaccinated VARCHAR(50),
    new_vaccinations VARCHAR(50),
    new_vaccinations_smoothed VARCHAR(50),
    total_vaccinations_per_hundred VARCHAR(50),
    people_vaccinated_per_hundred VARCHAR(50),
    people_fully_vaccinated_per_hundred VARCHAR(50),
    new_vaccinations_smoothed_per_million VARCHAR(50),
    stringency_index VARCHAR(50),
    population_density VARCHAR(50),
    median_age VARCHAR(50),
    aged_65_older VARCHAR(50),
    aged_70_older VARCHAR(50),
    gdp_per_capita VARCHAR(50),
    extreme_poverty VARCHAR(50),
    cardiovasc_death_rate VARCHAR(50),
    diabetes_prevalence VARCHAR(50),
    female_smokers VARCHAR(50),
    male_smokers VARCHAR(50),
    handwashing_facilities VARCHAR(50),
    hospital_beds_per_thousand VARCHAR(50),
    life_expectancy VARCHAR(50),
    human_development_index VARCHAR(50)
);

-- NOTE: update these file paths to wherever you saved the CSVs.
-- Make sure local_infile is enabled (same steps as your earlier projects:
-- SET GLOBAL local_infile = 1; and OPT_LOCAL_INFILE=1 in your connection's
-- Advanced settings, then reconnect). Also make sure Safe Updates is off
-- if you plan to run any UPDATE statements later.

LOAD DATA LOCAL INFILE 'C:/sql-covid-project/CovidDeaths.csv'
INTO TABLE CovidDeaths
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/sql-covid-project/CovidVaccinations.csv'
INTO TABLE CovidVaccinations
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Quick checks after loading - both should return 85171
SELECT COUNT(*) FROM CovidDeaths;
SELECT COUNT(*) FROM CovidVaccinations;

SELECT * FROM CovidDeaths LIMIT 10;
