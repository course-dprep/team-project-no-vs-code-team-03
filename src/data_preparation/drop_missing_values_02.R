##################
##################
#DATA PREPARATION#
##################
##################

# --- Loading Libraries and Loading Data --- #

library(dplyr)
library(tidyverse)
library(here)

title_basics <- read_delim(gzfile('data/title_basics.tsv.gz'), delim = "\t", na = "\\N")
title_episode <- read_delim(gzfile('data/title_episode.tsv.gz'), delim = '\t', na = "\\N")
title_ratings <- read_delim(gzfile('data/title_ratings.tsv.gz'), delim = '\t', na = "\\N")

# Filter only TV episodes as the RQ is limited only to TV series
title_basics <- title_basics %>% filter(titleType == "tvEpisode")

# --- Dropping NAs --- #

# Motivation: Dropping rows with missing values in startYear, 
# endYear from title_basics and 
# missing seasonNumber, episodeNumber in title_episode

# Dropping missing values in title_basics
title_basics_filtered <- title_basics %>%
  filter(!is.na(startYear) & !is.na(endYear))

# Dropping missing values in title_episode
title_episode_filtered <- title_episode %>%
  filter(!is.na(seasonNumber) & !is.na(episodeNumber))


# --- Save Data --- #
write.csv(title_basics_filtered, file = "gen/temp/title_basics_no_NAs.csv", row.names = FALSE)
write.csv(title_episode_filtered, file = "gen/temp/title_episode_no_NAs.csv", row.names = FALSE)
file.copy("data/title_ratings.tsv.gz", "gen/temp/title_ratings.tsv.gz")  # Copying the title_ratings file (as it has no missing values)



