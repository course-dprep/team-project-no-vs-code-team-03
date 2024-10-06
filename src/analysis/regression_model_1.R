# Regression Model 1: Using total_years
library(dplyr)

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







