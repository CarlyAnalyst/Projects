
--Queries used for Tableau Project

select *from dbo.Sheet1$
1.
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From dbo.Sheet1$
--Where location like '%Nigeria%'
where continent is not null 
--Group By date
order by 1,2

2.
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From dbo.Sheet1$
--Where location like '%Nigeria%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc

3.
--Using the first 32,270 rows
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From dbo.Sheet1$
--Where location like '%Nigeria%'
Group by Location, Population
order by PercentPopulationInfected desc

4.
--Using the first 32,270 rows
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From dbo.Sheet1$
--Where location like '%Nigeria%'
Group by Location, Population, date
order by PercentPopulationInfected desc
