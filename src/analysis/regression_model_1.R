# Regression Model 1: Using total_years
library(dplyr)
library(readr)
library(kableExtra)
library(knitr)

# Load the cleaned dataset
cleaned_data <- read_csv("../../gen/output/cleaned_data.csv")  

# Log transform numVotes (control variable) and averageRating (dependent variable)
cleaned_data_model_01 <- cleaned_data %>%
  mutate(
    log_numVotes = log(numVotes + 1), 
    log_averageRating = log(averageRating + 1)
  )

# Run regression
model1 <- lm(log_averageRating ~ total_years + log_numVotes, data = cleaned_data_model_01)

# Summary of the model
summary_model1 <- summary(model1)
print(summary_model1)

# Generate HTML summary 
html_model1 <- paste(
  "<html><body>",
  "<h2>Regression Model 1 Summary</h2>",
  "<pre>",
  paste(capture.output(summary_model1$coefficients), collapse = "\n"),
  "</pre>",
  "</body></html>",
  sep = "\n"
)

# Save the HTML to a file
writeLines(html_model1, "../../gen/output/regression_model_1_summary.html")

