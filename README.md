**COVID-19 Global Data Analysis with SQL**

This project focuses on the comprehensive analysis of COVID-19 data using Structured Query Language (SQL). It demonstrates how to clean, transform, and derive insights from large-scale, real-world data stored in a relational database. By leveraging Microsoft SQL Server, this project uncovers trends related to infections, deaths, and vaccinations across countries and continents.

 What I Did
1. Data Cleaning & Filtering
I began by filtering out rows that did not represent actual countries (e.g., global aggregates or rows without a continent). This ensured all analyses focused only on valid national data.

2. Analyzing Death Rates
I calculated the percentage of people who died after contracting COVID-19 in each country — focusing particularly on my country, Ghana, for context.

3. Examining Infection Rates
I compared total cases against population to determine what percentage of each country’s population had been infected over time.

4. Identifying Impacted Countries
I ranked countries by infection rate and death count to highlight where the virus had the greatest impact.

5. Summarizing by Continent
I aggregated total deaths across continents to understand regional differences in the pandemic’s toll.

6. Global Overview
I created global summaries to assess the overall scale of the pandemic and calculate a global death rate based on total reported cases and deaths.

7. Tracking Vaccination Progress
I merged case and vaccination datasets to analyze how quickly and effectively different countries rolled out vaccinations. I used window functions to calculate cumulative vaccinations over time.

8. Comparing Vaccinations to Population
I determined what percentage of a country’s population had been vaccinated using rolling totals and population data, helping assess vaccination coverage.

9. Using CTEs & Temp Tables
To make the analysis modular and maintainable, I used Common Table Expressions (CTEs) and temporary tables for intermediate calculations.

10. Creating a SQL View
For easier access and potential visualization, I created a view to store the final, cleaned and processed dataset that can be used in tools like Tableau.
