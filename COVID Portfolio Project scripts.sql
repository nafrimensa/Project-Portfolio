Select *
 From [Project Portfolio]..CovidDeaths
 where continent is not null
 order by 3,4

--Select *
-- From [Project Portfolio]..CovidVaccinations
 --order by 3,4

 -- Select Data that we are going to be starting with

Select Location, date, total_cases, new_cases, total_deaths, population
From [Project Portfolio]..CovidDeaths
Where continent is not null 
order by 1,2


--Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contracted covid in my country Ghana
Select Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Project Portfolio]..CovidDeaths
Where location like '%Ghana%'
 where continent is not null


--Looking at Total Cases vs Population
--Shows what percentage of population contracted Covid

Select Location, date, population, total_cases, (total_cases/population)*100 as PercentageInfected
From [Project Portfolio]..CovidDeaths
Where location like '%Ghana%'
 where continent is not null
order by 1,2

--Looking at Countries which Highest Infection Rate compared to Population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentageInfected
From [Project Portfolio]..CovidDeaths
-- Where location like '%Ghana%'
Group by Location, Population
 where continent is not null
order by PercentageInfected desc

--Showing the countries with the highest death count per population


Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount 
From [Project Portfolio]..CovidDeaths
-- Where location like '%Ghana%'
 where continent is not null
Group by Location
order by TotalDeathCOunt desc


--Breaking things down by Continent


Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
From [Project Portfolio]..CovidDeaths
-- Where location like '%Ghana%'
 where continent is not null
Group by continent
order by TotalDeathCount desc


-- Showing the continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount 
From [Project Portfolio]..CovidDeaths
-- Where location like '%Ghana%'
 where continent is not null
Group by continent
order by TotalDeathCount desc



-- Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From [Project Portfolio]..CovidDeaths
--Where location like '&Ghana&'
where continent is not null
--Group by date
order by 1,2

--Looking at total population vs vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From [Project Portfolio]..CovidDeaths dea
Join [Project Portfolio]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3



--USE CTE
With PopnvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Project Portfolio]..CovidDeaths dea
Join [Project Portfolio]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopnvsVac

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Project Portfolio]..CovidDeaths dea
Join [Project Portfolio]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating view to store data for later visualisations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From [Project Portfolio]..CovidDeaths dea
Join [Project Portfolio]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3


Select *
From PercentPopulationVaccinated