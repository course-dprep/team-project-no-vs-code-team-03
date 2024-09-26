
# Regression Model 2: Using episode_count
library(dplyr)

# Load the cleaned dataset
cleaned_data <- read.csv("gen/output/cleaned_data.csv")


# Log transform episode_count and numVotes
cleaned_data <- cleaned_data %>%
  mutate(log_episode_count = log(episode_count + 1),  # Add 1 to avoid log(0)
         log_numVotes = log(numVotes + 1))

# Run regression
model2 <- lm(averageRating ~ log_episode_count + log_numVotes, data = cleaned_data)

# Summary of the model
summary(model2)

# Save the model summary to a text file
capture.output(summary(model2), file = "gen/output/regression_model_2_summary.txt")

message("Model 2: Regression with episode_count completed and summary saved.")