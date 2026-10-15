-- SELECT data we are going to use 
/* SELECT 
location,
date,
total_cases,
new_cases,
total_deaths,
population 
FROM coviddeaths
ORDER BY loaction, date */

-- Looking at total cases vs total deaths
-- shows the likelihood of dying if you contract covid in you country

/* SELECT 
location,
date,
total_cases,
total_deaths,
(total_deaths/ total_cases)* 100 as death_percentage
FROM coviddeaths
WHERE location like '%states%'*/

-- looking at the total cases vs the population 
-- shows what percentage of population got covid 
/*SELECT 
	location,
	date,
	total_cases,
	population,
	( total_cases/population)* 100 as cases_percentage
FROM coviddeaths
-- WHERE location like '%states%'
order by location, date */


--  Looking  for countries with highest infecation rate comoared to population 
/*SELECT 
	location,
	MAX(total_cases) as highest_infection_count,
	population,
	MAX((total_cases/population))* 100 as percent_population_infected
FROM coviddeaths
-- WHERE location like '%states%'
GROUP BY location, population
order by percent_population_infected DESC */

--  Showing Countries with the highest death count per population
/*SELECT 
	location,
	-- population,
	MAX(total_deaths) as highest_death_count
	-- MAX((total_deaths/population)) * 100 as percent_deaths_per_population 
FROM coviddeaths
WHERE continent IS NOT NULL
AND continent <> ''
GROUP BY location 
ORDER BY highest_death_count DESC */

-- let's break things down by continent 
/*SELECT 
	continent,
	MAX(total_deaths) as total_death_count
	-- MAX((total_death_count/population)) * 100 as percent_deaths_per_population 
FROM coviddeaths
WHERE continent IS NOT NULL
AND continent <> ''
GROUP BY continent
ORDER BY total_death_count DESC */

-- Global Numbers 
/*SELECT 

  SUM(new_cases) as total_cases,
  SUM(new_deaths) as total_deaths,
  SUM(new_deaths) /SUM(new_cases)* 100 AS Deathpercentage	
FROM coviddeaths
-- WHERE location like '%states%'
WHERE continent IS NOT NULL
AND continent <> ''
order by 1, 2 */

-- looking at total population vs vactionation 
-- USE CTE 
/*WITH PopVsVac AS (
SELECT 
dea.continent ,
dea.location,
dea.date,
dea.population, 
vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date) as rolling_people_vaccinated
FROM coviddeaths as dea
JOIN covidvaccinations as vac
	ON dea.location= vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
AND dea.continent <> ''
ORDER BY 2,3
)
SELECT 
	*, 
	(rolling_people_vaccinated / population) * 100 AS vaccinated_percentage
FROM PopVsVac;    */

-- Temp Table
/*DROP TEMPORARY TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population, 
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location ORDER BY dea.location, dea.date
    ) AS rolling_people_vaccinated
FROM coviddeaths AS dea
JOIN covidvaccinations AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
AND dea.continent <> '';

SELECT * FROM PercentPopulationVaccinated
ORDER BY 2, 3; */


-- creating vie to store data for later visualiztion 

CREATE VIEW  PercentPopulationVaccinated AS 

SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population, 
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
        PARTITION BY dea.location ORDER BY dea.location, dea.date
    ) AS rolling_people_vaccinated
FROM coviddeaths AS dea
JOIN covidvaccinations AS vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
AND dea.continent <> '';
-- ORDER BY 2, 3


