DATA = ../../data
TEMP = ../../gen/temp
OUTPUT = ../../gen/data_preparation/output
ANALYSIS = ../../gen/analysis/output

# Regression model 1
$(ANALYSIS)/regression_model_1_summary.txt : regression_model_1.R $(OUTPUT)/cleaned_data.csv
	R --vanilla < regression_model_1.R

# Regression model 2
$(ANALYSIS)/regression_model_2_summary.html : regression_model_2.R $(OUTPUT)/cleaned_data.csv
	R --vanilla < regression_model_2.R