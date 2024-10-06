# Regression Model 2: Using episode_count
library(dplyr)
install.packages("kableExtra")
library(knitr)
library(kableExtra)

# Load the cleaned dataset
cleaned_data <- read.csv("gen/output/cleaned_data.csv")

# Log transform `episode_count`,`numVotes` and `averageRating`
cleaned_data_model_02 <- cleaned_data %>%
  mutate(
    log_episode_count = log(episode_count + 1),  
    log_averageRating = log(averageRating + 1),
    log_numVotes = log(numVotes + 1)
      )

# Run regression
model2 <- lm(log_averageRating ~ log_episode_count + log_numVotes, data = cleaned_data_model_02)

# Summary of the model
summary(model2)

# Save the model object for later use in RMarkdown
saveRDS(model2, "gen/output/model2.rds")

# Generate HTML summary
library(knitr)
library(kableExtra)
html_model2 <- kable(summary(model2)$coefficients, format = "html") %>% 
  kable_styling()
writeLines(html_model2, "gen/output/regression_model_2_summary.html")







