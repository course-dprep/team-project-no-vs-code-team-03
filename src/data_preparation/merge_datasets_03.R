##################
##################
##MERGE DATASETS##
##################
##################

# --- Loading Libraries and Datasets --- #
library(dplyr)
library(readr)

title_basics_no_NAs <- read_csv("gen/output/title_basics_no_NAs.csv")
title_episode_no_NAs <- read_csv("gen/output/title_episode_no_NAs.csv")
title_ratings <- read_delim("gen/output/title_ratings.csv", delim = ',')

# --- Merging Datasets --- #
# Merging datasets based on tconst (common identifier)
merged_data <- title_basics_no_NAs %>%
  inner_join(title_ratings, by = "tconst") %>%
  inner_join(title_episode_no_NAs, by = c("tconst" = "parentTconst"))
View(merged_data)

# --- Save Data --- #
write.csv(merged_data, file = "gen/output/merged_data.csv", row.names = FALSE)

