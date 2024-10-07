# Regression Model 2: Using episode_count
library(dplyr)
library(readr)
library(kableExtra)

# Load the cleaned dataset
cleaned_data <- read_csv("../../gen/output/cleaned_data.csv") 

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
summary_model2 <- summary(model2)

# Generate HTML summary 
html_model2 <- paste(
  "<html><body>",
  "<h2>Regression Model 2 Summary</h2>",
  "<pre>",
  capture.output(summary_model2$coefficients),
  "</pre>",
  "</body></html>",
  sep = "\n"
)

# Save the HTML to a file
writeLines(html_model2, "../../gen/output/regression_model_2_summary.html")







