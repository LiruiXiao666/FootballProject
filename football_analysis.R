
# Football Home Win Analysis
# Dataset: European football results from 2016/17 to 2025/26
# Data source: OpenFootball
#
# Research question:
# How does the home win percentage vary across
# different football leagues and seasons?


# 1. Load the dataset

football <- read.csv("football_results_2016_2026.csv")

# Display the first six rows
head(football)

# Check the structure and dimensions of the dataset
str(football)
dim(football)

# Display all column names
names(football)


# 2. Explore the dataset

# Count missing values in each column
colSums(is.na(football))

# Count the number of matches in each league
table(football$league)

# Count the number of matches in each season
table(football$season)


# 3. Clean the dataset

# Remove matches with missing full-time scores
# because their results cannot be determined
football_clean <- subset(
  football,
  !is.na(home_goals) & !is.na(away_goals)
)

# Compare the number of rows before and after cleaning
nrow(football)
nrow(football_clean)

# Check for missing scores after cleaning
colSums(is.na(
  football_clean[, c("home_goals", "away_goals")]
))


# 4. Calculate home wins

# TRUE means the home team won the match
# FALSE means the home team drew or lost
football_clean$home_win <-
  football_clean$home_goals > football_clean$away_goals


# 5. Calculate home win percentages by league

# Calculate the average of home_win for each league
home_win_by_league <- aggregate(
  home_win ~ league,
  data = football_clean,
  FUN = mean
)

# Convert the results into percentages
home_win_by_league$home_win_percentage <-
  round(home_win_by_league$home_win * 100, 2)

# Sort leagues from highest to lowest home win percentage
home_win_by_league <- home_win_by_league[
  order(-home_win_by_league$home_win_percentage),
]

# Display the results
print(home_win_by_league)


# 6. Calculate home win percentages by season and league

# Group matches by season and league
home_win_by_season <- aggregate(
  home_win ~ season + league,
  data = football_clean,
  FUN = mean
)

# Convert the results into percentages
home_win_by_season$home_win_percentage <-
  round(home_win_by_season$home_win * 100, 2)

# Display the first twelve rows
head(home_win_by_season, 12)


# 7. Create visualisations

# Load the package for creating graphs
library(ggplot2)

# Figure 1: Overall home win percentage by league
ggplot(
  home_win_by_league,
  aes(
    x = reorder(league, home_win_percentage),
    y = home_win_percentage
  )
) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Overall Home Win Percentage by League",
    x = "League",
    y = "Home Wins (%)"
  ) +
  theme_minimal()


# Figure 2: Home win percentage by league and season
ggplot(
  home_win_by_season,
  aes(
    x = season,
    y = home_win_percentage,
    color = league,
    group = league
  )
) +
  geom_line(linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Home Win Percentage by League and Season",
    x = "Season",
    y = "Home Wins (%)",
    color = "League"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


# 8. Summarise the findings

# Identify the league with the highest home win percentage
highest_home_win <- home_win_by_league[1, ]

# Identify the league with the lowest home win percentage
lowest_home_win <- home_win_by_league[
  nrow(home_win_by_league),
]

# Display the highest and lowest results
print(highest_home_win)
print(lowest_home_win)


# 9. Export the analysis results

# Save the summary tables as CSV files
write.csv(
  home_win_by_league,
  "home_win_by_league.csv",
  row.names = FALSE
)

write.csv(
  home_win_by_season,
  "home_win_by_season.csv",
  row.names = FALSE
)
# Save the seasonal home win percentage chart
ggsave(
  "home_win_by_season.png",
  width = 10,
  height = 6,
  dpi = 300
)