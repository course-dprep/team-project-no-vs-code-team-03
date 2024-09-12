---
title: "Project Dprep"
author: "Team 03"
date: "2024-09-05"
output:
  html_document: default
---



# Project Dprep

## 1.1 Research Motivation

The television industry has transformed exceptionally in the past decade with the advent of streaming platforms like Netflix, HBO, Amazon Prime, and Hulu, among many others. These platforms have reformed how the audience consumes content, producing series and shows that allure millions across the world. The global video streaming market is projected to grow from USD 674.25 billion in 2024 to USD 2,660.88 billion by 2032, exhibiting a CAGR of 18.7% during the forecast period.(source: fortune business insights) 
This dramatic growth poses the question of what factors contribute to the success (in terms of average customer rating) of these TV shows. One frequently disputed factor is the length of the TV shows. While some believe longer TV series allow for complex storytelling and intricate character development leading to higher customer engagement and satisfaction (Mercader, 2023), others may argue that excessive length could cause viewer fatigue and lower customer satisfaction (Mercader, 2023).
Understanding how the overall length of a TV series influences the average customer ratings could hold important implications for the content producers and streaming platforms. This research may help producers decide the optimal length of the TV series to maximize customer engagement.
Our research aims to indicate the relationship between the length of the TV series in terms of number of episodes (number of years the show is running) and the average customer ratings. By establishing this relationship, the question for producers as to whether more episodes or a new season should be produced, will be made easier. The producer then has a guideline as to what amount of episodes will maximize the consumer engagement, and therefore minimize viewer fatigue which can lead to negative reviews. Thus, the research question of this assignment is: How does the length of a TV series influence its average customers ratings? In addition, the established relationship can be added and compared to existing theories. Thereby, academic research could further be done by looking at the relationship between, for example, different genres, or looking if the relationship differs between different regions or countries. Therefore, this research provides a general overview, which other academics could then use to further investigate this phenomena. 

## 1.1.2 Analysis plan

The first step in our analysis plan is data exploration. This step involves computing summary statistics and visualizations, so we can get an idea about the structure of our dataset. 
After exploring the data, the next step is data preparation. In the second step, we will handle missing observations, transform variables where necessary, and ensure that our dataset is ready for analysis. After exploring and preparing the data, we will perform a regression analysis to quantify the relationship between TV series length and average customer rating. We might have to add control variables to ensure our model is not biased. A linear regression will be conducted to assess this relationship. After conducting a linear regression, we will use a t-test to test the alternative hypothesis: There is a positive/negative relationship between the length of a TV series and the rating for the series. The final step is to summarize the key findings. We will interpret the results of our regression analysis and t-test, and discuss the implications for TV platforms.

## 2. Data preparation & analysis

### 2.1.1 Composition of the datasets and description of the variables


### title.episode.tsv.gz

| Variable       | Description                                                                                   | Data Class |
|----------------|-----------------------------------------------------------------------------------------------|------------|
| `tconst`       | An alphanumeric identifier unique to each episode.                                           | String     |
| `parentTconst` | An alphanumeric identifier for the parent TV series of the episode. It links the episode to the overall series. | String     |
| `seasonNumber` | The season number that the episode belongs to within the TV series.                           | Integer    |
| `episodeNumber`| The specific episode number of the `tconst` in the TV series.                                | Integer    |

### title.basics.tsv.gz

| Variable   | Description                      | Data Class |
|------------|----------------------------------|------------|
| `startYear`| The year the series began.       | Integer    |
| `endYear`  | TV Series end year.              | Integer    |

### title.ratings.tsv.gz

| Variable       | Description                                                    | Data Class |
|----------------|----------------------------------------------------------------|------------|
| `tconst`       | An alphanumeric unique identifier for each title.              | String     |
| `averageRating`| The weighted average of all the individual user ratings.       | Numeric    |


#### To read tsv files, you need to load the **readr** package

```{r include=FALSE}
install.packages('readr')
library(readr)
```


#### Load other packages that you will need to analyse the data

```{r include=FALSE}
install.packages('tidyverse')
install.packages('dplyr')
library(tidyverse)
library(dplyr)
```



#### Create vectors containing the urls where the data is store, read them and load the datasets 

```{r include=TRUE}
#create the vector
urls = c("https://datasets.imdbws.com/title.basics.tsv.gz", "https://datasets.imdbws.com/title.episode.tsv.gz", "https://datasets.imdbws.com/title.ratings.tsv.gz")

#use lapply to read in all files:
datasets <- lapply(urls, read_delim, delim='\t', na = '\\N')

# Access individual datasets
title_basics <- datasets[[1]]
title_episode <- datasets[[2]]
title_ratings <- datasets[[3]]

```
#### To view the datasets, use the code **View()**

```{r}

View(title_basics)

View(title_episode)

View(title_ratings)
```


#### Get a quick overview of the data by using the code **summary()**

```{r}

summary(title_basics)

summary(title_episode)

summary(title_ratings)
```


#### Get specific summary statistics

```{r}
#Summary statistics of title_episode

title_episode_summary <- title_episode %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst=sum(is.na(tconst)),
            missing_values_parentTconst=sum(is.na(parentTconst)),
            missing_values_seasonNumber=sum(is.na(seasonNumber)),
            missing_values_episodeNumber=sum(is.na(episodeNumber)) 
            )%>%
  print()
```
```{r}
#Summary statistics of title_ratings

title_ratings_summary <- title_ratings %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst = sum(is.na(tconst)),
            missing_values_averageRating = sum(is.na(averageRating)),
            missing_values_numVotes = sum(is.na(numVotes))
  ) %>%
  print()
```
```{r}
#Summary statistics of title_basics

title_basics_summary <- title_basics %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst = sum(is.na(tconst)),
            missing_values_titleType = sum(is.na(titleType)),
            missing_values_startYear= sum(is.na(startYear)),
            missing_values_endYear= sum(is.na(endYear))
  )%>%
  print()
```
```{r}
#filtering TV series alone using titleType(tvEpisode) from title_basics

tv_series <- title_basics %>%
  filter(titleType == "tvEpisode")

# Merged with ratings using tconst

tv_series_ratings <- tv_series %>%
  inner_join(title_ratings, by = "tconst")
print(nrow(tv_series_ratings))
```
```{r}
#Merging with title_episode using tconst to add parentTconst to tv_series_ratings

tv_series_ratings_with_parent <- tv_series_ratings %>%
  left_join(title_episode %>% 
              select(tconst,parentTconst), by= "tconst")
head(tv_series_ratings_with_parent)
View(tv_series_ratings_with_parent)
```


#### With the help of the package **ggplot2** we can make plots (To only show the output and hide the code, we use echo = False)
```{r, echo = FALSE}
# Plotting
library(ggplot2)

ggplot(tv_series_ratings_with_parent, aes(y = averageRating)) +
  geom_boxplot(fill = "blue", color = "black", outlier.color = "red") +
  labs(title = "Boxplot of TV Series Average Ratings", y = "Average Rating") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))


ggplot(tv_series_ratings_with_parent, aes(x = averageRating))+ geom_bar() +
  labs(title = "Distribution of Average Ratings for TV Series", x = "Average Rating", y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))
```

#### Repository Overview
```{r}
- README.md
```

