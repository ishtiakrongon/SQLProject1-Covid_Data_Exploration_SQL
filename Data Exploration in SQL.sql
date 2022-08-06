-- PORTFOLIO PROJECT OF COVID DATASETS
-- MD. ISHTIAK AHMED
--------------------------------------------------------------------------------------------------------


-- SHOWING THE TWO TABLES

-- TABLE 1

SELECT *
FROM covid_deaths
LIMIT 15;

-- TABLE 2

SELECT *
FROM covid_vaccinations
LIMIT 15;


--------------------------------------------------------------------------------------------------------------

-- showing total cases, new cases, total deaths, population, date and location

SELECT
	location, date, total_cases,
	new_cases, total_deaths, population
FROM
	covid_deaths;


-------------------------------------------------------------------------------------------------------------

-- Looking at the total cases vs total deaths

SELECT
	location, date,
	total_cases, total_deaths,
	ROUND( ((total_deaths / total_cases) * 100), 2 ) AS death_percentage
	
FROM
	covid_deaths
WHERE
	total_deaths IS NOT NULL;


-------------------------------------------------------------------------------------------------------------

-- Looking at death percentage of country Bangladesh

SELECT
	location, date,
	total_cases, total_deaths,
	ROUND( ((total_deaths / total_cases) * 100), 2 ) AS death_percentage
	
FROM
	covid_deaths
WHERE
	total_deaths IS NOT NULL AND location = 'Bangladesh';


-------------------------------------------------------------------------------------------------------------

-- Looking at total cases vs the population of Bangladesh
-- Shows what percentage of population got covid

SELECT
	location, date,
	total_cases, population,
	(total_cases / population) * 100 AS percentage_of_affected_people
FROM
	covid_deaths
WHERE
	total_deaths IS NOT NULL AND location = 'Bangladesh';


-------------------------------------------------------------------------------------------------------------

-- Looking at countries with highest infection rate compared to population


SELECT
	location,
	population,
	MAX(total_cases) AS highest_infection_count,
	ROUND( MAX((total_cases / population)) * 100, 3) AS percentage_of_affected_people
	
FROM
	covid_deaths
GROUP BY
	location, population
ORDER BY
	location;


---------------------------------------------------------------------------------------------------------

-- Showing countries with highest death count per population

SELECT
	location,
	MAX(total_deaths) AS total_death_count

FROM
	covid_deaths
WHERE
	total_deaths IS NOT NULL AND continent IS NOT NULL
GROUP BY
	location
ORDER BY
	total_death_count DESC;


--------------------------------------------------------------------------------------------------------

-- Showing continent with highest death count per population


SELECT
	continent,
	MAX(total_deaths) AS total_death_count

FROM
	covid_deaths
WHERE
	total_deaths IS NOT NULL AND continent IS NOT NULL
GROUP BY
	continent
ORDER BY
	total_death_count DESC;


-------------------------------------------------------------------------------------------------------------

-- Global numbers

SELECT
	SUM(new_cases) AS total_cases,
	SUM(new_deaths) AS total_deaths,
	(SUM(new_cases) / SUM(new_deaths)) * 100 AS death_percentage

FROM
	covid_deaths
WHERE
	continent is not null;
	
	
-------------------------------------------------------------------------------------------------------------

-- Looking at total populations vs vaccinations

SELECT
	d.continent, d.location, d.population, v.new_vaccinations
	
FROM covid_deaths AS d
	INNER JOIN covid_vaccinations AS v
	ON d.location = v.location
WHERE
	d.continent IS NOT NULL;


-------------------------------------------------------------------------------------------------

