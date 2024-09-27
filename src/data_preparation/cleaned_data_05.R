### Removing outliers 

# Load required packages
library(dplyr)

# Load the engineered dataset

engineered_data <- read.csv("gen/output/engineered_data.csv")

# Define a function to remove outliers using the IQR method

remove_outliers_iqr <- function(column) {
  Q1 <- quantile(column, 0.25)  # Calculate the 25th percentile
  Q3 <- quantile(column, 0.75)  # Calculate the 75th percentile
  IQR_value <- IQR(column)  # Calculate the IQR (Q3 - Q1)
  lower_bound <- Q1 - 1.5 * IQR_value  # Lower bound for outliers
  upper_bound <- Q3 + 1.5 * IQR_value  # Upper bound for outliers
  column >= lower_bound & column <= upper_bound # Returns TRUE for values within bounds
}

# Columns to check for outliers
columns_to_check <- c("total_years", "episode_count", "numVotes", "averageRating")

# Apply the IQR method and retain only the non-outliers

cleaned_data <- engineered_data[
  rowSums(sapply(engineered_data[columns_to_check], remove_outliers_iqr)) == length(columns_to_check), 
]

# Save the cleaned dataset with outliers removed
write.csv(cleaned_data, file = "gen/output/cleaned_data.csv", row.names = FALSE)

# Confirmation message
message("Removed outliers and saved the cleaned dataset.")

