#---Removing outliers---#

#we are removing the outliers for series_length, averageRatings, numVotes

remove_outliers_iqr <- function(column) {
  Q1 <- quantile(column, 0.25)
  Q3 <- quantile(column, 0.75)
  IQR_value <- IQR(column)
  lower_bound <- Q1 - 1.5 * IQR_value
  upper_bound <- Q3 + 1.5 * IQR_value
  column >= lower_bound & column <= upper_bound
}

# Columns to check for outliers
columns_to_check <- c("series_lengths", "averageRating", "numVotes")

# Apply outlier removal and combine results
cleaned_data <- merged_data[
  rowSums(sapply(merged_data[columns_to_check], remove_outliers_iqr)) == length(columns_to_check), 
]

# View cleaned data
View(cleaned_data)