# merge_datasets.R

# Loading required packages
library(dplyr)
library(readr)

# Load cleaned datasets
title_basics_no_NAs <- read_csv("gen/output/title_basics_no_NAs.csv")
title_episode_no_NAs <- read_csv("gen/output/title_episode_no_NAs.csv")
title_ratings <- read_tsv("gen/output/title_ratings.tsv.gz",col_types = cols(.default = "c"))

# # Merging datasets based on tconst (common identifier)

merged_data <- title_basics_no_NAs %>%
  inner_join(title_ratings, by = "tconst") %>%
  inner_join(title_episode_no_NAs, by = c("tconst" = "parentTconst"))


# Save the merged dataset
write.csv(merged_data, file = "gen/output/merged_data.csv", row.names = FALSE)

# Confirmation message
message("Merged datasets and saved the output.")

