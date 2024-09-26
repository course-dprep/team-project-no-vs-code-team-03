# drop_missing_values.R

# Motivation: Dropping rows with missing values in startYear, endYear from title_basics
# and missing seasonNumber, episodeNumber in title_episode
library(dplyr)

# Dropping missing values in title_basics
title_basics_no_NAs <- title_basics %>%
  filter(!is.na(startYear) & !is.na(endYear))

# Dropping missing values in title_episode
title_episode_no_NAs <- title_episode %>%
  filter(!is.na(seasonNumber) & !is.na(episodeNumber))

# Copying the title_ratings file (as it has no missing values)
file.copy("data/title_ratings.tsv.gz", "gen/output/title_ratings.tsv.gz")


# Save cleaned datasets
write.csv(title_basics_no_NAs, file = "gen/output/title_basics_no_NAs.csv", row.names = FALSE)
write.csv(title_episode_no_NAs, file = "gen/output/title_episode_no_NAs.csv", row.names = FALSE)

# Confirmation message
message("Dropped missing values")

