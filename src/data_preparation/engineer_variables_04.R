########################
########################
#ENGINEER NEW VARIABLES#
########################
########################

# --- Loading Libraries and Dataset --- #
library(dplyr)
library(tidyverse)

merged_data <- read_csv('gen/output/merged_data.csv')

# --- Create New Variable --- #
# Transform endYear to numeric
merged_data$endYear <- as.numeric(merged_data$endYear)
sum(is.na(merged_data$endYear))

# total_years and  episode_count
merged_data <- merged_data %>%
  mutate(total_years = endYear - startYear)

# Calculate the total number of episodes for each series
episode_count <- title_episode_no_NAs %>%
  group_by(parentTconst) %>%
  summarise(episode_count = n(), .groups = 'drop')  # Count the number of episodes per series

# Merge the episode count back into the merged_data
merged_data <- merged_data %>%
  left_join(episode_count, by = c("tconst" = "parentTconst"))

# --- Save Data --- #
write.csv(merged_data, file = "gen/output/engineered_data.csv", row.names = FALSE)
