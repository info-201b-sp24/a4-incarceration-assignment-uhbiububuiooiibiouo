library(readr)
library(dplyr)

url <- "https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv"
data <- read_csv(url, show_col_types = FALSE)

# 1. Calculate the average total prison population across US.
average_prison_pop <- data %>%
  summarize(average_prison_pop = mean(total_prison_pop, na.rm = TRUE))

# 2. Find the county with the highest total prison population through all time.
highest_prison_pop <- data %>%
  arrange(desc(total_prison_pop)) %>%
  select(county_name, state, year, total_prison_pop) %>%
  head(1)

# 3. Find the county with the lowest total prison population.
lowest_prison_pop <- data %>%
  filter(!is.na(total_prison_pop)) %>%
  arrange(total_prison_pop) %>%
  select(county_name, state, year, total_prison_pop) %>%
  head(1)

# 4. Find the county with the highest black prison population.
highest_black_prison_pop <- data %>%
  arrange(desc(black_prison_pop)) %>%
  select(county_name, state, year, black_prison_pop) %>%
  head(1)

# 5. Find the county with the highest male prison population.
highest_male_prison_pop <- data %>%
  arrange(desc(male_prison_pop)) %>%
  select(county_name, state, year, male_prison_pop) %>%
  head(1)