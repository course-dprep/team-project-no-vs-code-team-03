# Engineering for new variables: 

# Load required packages
library(dplyr)

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


# Save the updated dataset with the new variables
write.csv(merged_data, file = "gen/output/engineered_data.csv", row.names = FALSE)



