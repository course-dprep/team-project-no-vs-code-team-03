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
title_basics <- title_basics[complete.cases(title_basics), ] # WE HAVE TO CHECK IF THIS IS RIGHT!!!!
title_episode <- read_delim(gzfile('data/title_episode.tsv.gz'), delim = '\t', na = "\\N")
title_ratings <- read_delim(gzfile('data/title_ratings.tsv.gz'), delim = '\t', na = "\\N")


# --- title_basics# --- Dropping NAs --- #
# Motivation: Dropping rows with missing values in startYear, endYear from title_basics and missing seasonNumber, episodeNumber in title_episode

# Dropping missing values in title_basics
title_basics_no_NAs <- title_basics %>%
  filter(!is.na(startYear) & !is.na(endYear))

# Dropping missing values in title_episode
title_episode_no_NAs <- title_episode %>%
  filter(!is.na(seasonNumber) & !is.na(episodeNumber))

# Copying the title_ratings file (as it has no missing values)
file.copy("data/title_ratings.tsv.gz", "gen/temp/title_ratings.tsv.gz")

# --- Save Data --- #
write.csv(title_basics_no_NAs, file = "gen/temp/title_basics_no_NAs.csv", row.names = FALSE)
write.csv(title_episode_no_NAs, file = "gen/temp/title_episode_no_NAs.csv", row.names = FALSE)
