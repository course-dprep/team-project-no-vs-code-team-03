DATA = ../../data
TEMP = ../../gen/data_preparation/temp
OUTPUT = ../../gen/data_preparation/output

# Output


# Download data
$(DATA)/title_basics.tsv.gz $(DATA)/title_episodes.tsv.gz $(DATA)/title_ratings.tsv.gz : download_data_01.R
	R --vanilla < download_data_01.R

# Drop missing values
$(TEMP)/title_basics_no_NAs.csv $(TEMP)/title_episode_no_NAs.csv : drop_missing_values_02.R
	R --vanilla < drop_missing_values_02.R

# Merge datasets
$(TEMP)/merged_data.csv : merge_datasets_03.R
	R --vanilla < merge_datasets_03.R

# Engineer variables
$(TEMP)/engineered_data.csv : engineer_variables_04.R
	R --vanilla < engineer_variables_04.R 

# Clean the data
$(OUTPUT)/cleaned_data.csv : cleaned_data_05.R
	R --vanilla < cleaned_data_05.R
