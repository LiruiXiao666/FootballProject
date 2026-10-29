# Football Home Win Analysis

## 1. Project Overview

This project analyses home win percentages in six European football leagues using R.

The main aim is to compare home win percentages across different leagues and examine how they change between seasons.

## 2. Dataset

The dataset contains football match results from the 2016/17 to 2025/26 seasons.

Data source: https://openfootball.github.io/

Dataset file: `football_results_2016_2026.csv`

The dataset contains 22,479 match records and 15 variables.

The six leagues included are:

- Premier League (England)
- Championship (England)
- Bundesliga (Germany)
- La Liga (Spain)
- Ligue 1 (France)
- Serie A (Italy)

## 3. Research Questions

1. Which football league has the highest home win percentage?
2. Which football league has the lowest home win percentage?
3. How do home win percentages change across different seasons?

## 4. Data Cleaning

The original dataset was imported into R using `read.csv()`.

The dataset was examined using functions such as `head()`, `str()`, `dim()` and `colSums(is.na())`.

Matches with missing full-time home or away goals were removed.

After cleaning, 22,357 match records remained.

## 5. Analysis Methods

A home win was defined as a match in which the home team scored more goals than the away team.

Home win percentages were calculated for each league using the `aggregate()` function.

The same calculation was repeated for each league and season.

The `ggplot2` package was used to create a line chart showing changes in home win percentages over time.

## 6. Main Findings

The overall home win percentages were:

| League | Home Win Percentage |
|---|---:|
| La Liga | 45.51% |
| Premier League | 44.63% |
| Bundesliga | 44.22% |
| Ligue 1 | 43.96% |
| Championship | 42.92% |
| Serie A | 42.03% |

La Liga had the highest home win percentage, while Serie A had the lowest.

The results also show that home win percentages varied across seasons.

These findings describe differences in match outcomes but do not establish the causes of home advantage.

## 7. Project Files

- `football_analysis.R` — R code for data cleaning, analysis and visualisation.
- `football_results_2016_2026.csv` — Original football dataset.
- `home_win_by_league.csv` — Home win percentages by league.
- `home_win_by_season.csv` — Home win percentages by league and season.
- `home_win_by_season.png` — Line chart showing seasonal home win percentages.
- `README.md` — Project documentation.

## 8. How to Run the Project

1. Download or clone this GitHub repository.
2. Open `FootballProject.Rproj` in RStudio.
3. Install `ggplot2` if it is not already installed:

   `install.packages("ggplot2")`

4. Open `football_analysis.R`.
5. Run the R script to reproduce the analysis and generate the output files.

The original CSV dataset should remain in the project folder.

## 9. Limitations

The analysis focuses on home win percentages and does not account for team strength, player performance or other factors that may influence match results.

The number of available matches also differs between some leagues