SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../..
DATA = $(ROOT_DIR)/data
TEMP = $(ROOT_DIR)/gen/temp
OUTPUT = $(ROOT_DIR)/gen/output
PAPER = $(ROOT_DIR)/src/paper

# Targets
all: $(PAPER)/data_exploration.html $(PAPER)/analysis_conclusion.html

# 1. Generate Data Exploration Report
$(PAPER)/data_exploration.html: $(PAPER)/data_exploration.Rmd $(OUTPUT)/cleaned_data.csv
	@mkdir -p $(PAPER)
	Rscript -e "rmarkdown::render(input='$(PAPER)/data_exploration.Rmd', output_file='data_exploration.html', output_dir='$(PAPER)')"

# 2. Generate Analysis & Conclusion Report
$(PAPER)/analysis_conclusion.html: $(PAPER)/Analysis_Conclusion.Rmd $(OUTPUT)/model1.rds $(OUTPUT)/model2.rds
	@mkdir -p $(PAPER)
	Rscript -e "rmarkdown::render(input='$(PAPER)/Analysis_Conclusion.Rmd', output_file='analysis_conclusion.html', output_dir='$(PAPER)')"

.PHONY: all clean

# Clean up generated HTML reports
clean:
	rm -f $(PAPER)/*.html
