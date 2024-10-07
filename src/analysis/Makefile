SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../..
DATA = $(ROOT_DIR)/data
TEMP = $(ROOT_DIR)/gen/temp
OUTPUT = $(ROOT_DIR)/gen/output
SRC = $(ROOT_DIR)/src
ANALYSIS = $(SRC)/analysis

# Scripts
REGRESSION_SCRIPT_1 = $(ANALYSIS)/regression_model_1.R
REGRESSION_SCRIPT_2 = $(ANALYSIS)/regression_model_2.R

# All output targets
all: $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html

# 1: Run Regression Model 1
$(OUTPUT)/regression_model_1_summary.html: $(REGRESSION_SCRIPT_1) $(OUTPUT)/cleaned_data.csv
	@mkdir -p $(OUTPUT)
	Rscript --vanilla "$(REGRESSION_SCRIPT_1)"

# 2: Run Regression Model 2
$(OUTPUT)/regression_model_2_summary.html: $(REGRESSION_SCRIPT_2) $(OUTPUT)/cleaned_data.csv
	@mkdir -p $(OUTPUT)
	Rscript --vanilla "$(REGRESSION_SCRIPT_2)"


.PHONY: all clean

# Clean up intermediate files (keep the cleaned data and final regression summaries)
clean:
	rm -f $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html

