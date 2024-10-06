SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../../
OUTPUT = $(ROOT_DIR)gen/output
ANALYSIS = $(ROOT_DIR)src/analysis
PAPER = $(ROOT_DIR)src/paper

# Scripts
REGRESSION_1_SCRIPT = $(ANALYSIS)/regression_model_1.R
REGRESSION_2_SCRIPT = $(ANALYSIS)/regression_model_2.R
GENERATE_REPORT_SCRIPT = $(PAPER)/report-analysis_conclusion.R

# All output targets
all: $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html $(PAPER)/Analysis_Conclusion.html

# 1: Run Regression Model 1
$(OUTPUT)/regression_model_1_summary.html: $(REGRESSION_1_SCRIPT) $(OUTPUT)/cleaned_data.csv
	@mkdir -p $(OUTPUT)
	R --vanilla < "$(REGRESSION_1_SCRIPT)"

# 2: Run Regression Model 2
$(OUTPUT)/regression_model_2_summary.html: $(REGRESSION_2_SCRIPT) $(OUTPUT)/cleaned_data.csv
	@mkdir -p $(OUTPUT)
	R --vanilla < "$(REGRESSION_2_SCRIPT)"
	
# 3: Generate R Markdown Report for Analysis
$(PAPER)/Analysis_Conclusion.html: $(GENERATE_REPORT_SCRIPT) $(PAPER)/Analysis_Conclusion.Rmd $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html
	@mkdir -p $(PAPER)
	Rscript "$(GENERATE_REPORT_SCRIPT)"
	
	
.PHONY: all clean

# Clean up intermediate files (only keep the final HTML reports)
clean:
	rm -f $(OUTPUT)/regression_model_*.html

