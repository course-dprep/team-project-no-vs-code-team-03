
# Regression Model 2: Using episode_count
library(dplyr)
install.packages("kableExtra")

# Load the cleaned dataset
cleaned_data <- read.csv("gen/output/cleaned_data.csv")


# Log transform `episode_count` and `numVotes`
cleaned_data <- cleaned_data %>%
  mutate(log_episode_count = log(episode_count + 1),  # Add 1 to avoid log(0)
         log_numVotes = log(numVotes + 1))

# Log transform `averageRating` (dependant variable)
cleaned_data <- cleaned_data %>%
  mutate(log_averageRating = log(averageRating + 1))  # Add 1 to avoid log(0)

# Run regression
model2 <- lm(log_averageRating ~ log_episode_count + log_numVotes, data = cleaned_data)


# Summary of the model
summary(model2)

# Save the model summary to a text file
capture.output(summary(model2), file = "gen/output/regression_model_2_summary.txt")



# Generating html output 

# load libraries
library(knitr)
library(kableExtra)

# Save model summaries as HTML tables
html_model1 <- kable(summary(model1)$coefficients, format = "html") %>% 
  kable_styling()

html_model2 <- kable(summary(model2)$coefficients, format = "html") %>% 
  kable_styling()

# Save to output folder
writeLines(html_model1, "gen/output/regression_model_1_summary.html")
writeLines(html_model2, "gen/output/regression_model_2_summary.html")








