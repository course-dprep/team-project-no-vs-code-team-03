# Regression Model 1: Using total_years
library(dplyr)
library(readr)
library(kableExtra)
library(knitr)

# Load the cleaned dataset
cleaned_data <- read_csv("gen/output/cleaned_data.csv")

# Log transform numVotes (control variable) and averageRating (dependant variable)
cleaned_data_model_01 <- cleaned_data %>%
  mutate(
    log_numVotes = log(numVotes + 1), 
    log_averageRating = log(averageRating + 1)
      )

# Run regression
model1 <- lm(log_averageRating ~ total_years + log_numVotes, data = cleaned_data_model_01)

# Summary of the model
summary(model1)

# Save the model object for later use in RMarkdown
saveRDS(model1, "gen/output/model1.rds")

# Generate HTML summary

html_model1 <- kable(summary(model1)$coefficients, format = "html") %>% 
  kable_styling()
save_kable(html_model1, "gen/output/regression_model_1_summary.html")





