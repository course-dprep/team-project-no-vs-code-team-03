SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../..
SRC = $(ROOT_DIR)/src
PAPER = $(SRC)/paper

# Targets
all: $(PAPER)/data_exploration.html $(PAPER)/analysis_conclusion.html

# 1. Generate Data Exploration Report
$(PAPER)/data_exploration.html: $(PAPER)/data_exploration.Rmd
	@mkdir -p $(PAPER)
	Rscript -e "knitr::knit2html(input='$(PAPER)/data_exploration.Rmd', output='$(PAPER)/data_exploration.html')"

# 2. Generate Analysis & Conclusion Report
$(PAPER)/analysis_conclusion.html: $(PAPER)/Analysis_Conclusion.Rmd
	@mkdir -p $(PAPER)
	Rscript -e "knitr::knit2html(input='$(PAPER)/Analysis_Conclusion.Rmd', output='$(PAPER)/analysis_conclusion.html')"

.PHONY: all clean

# Clean up generated HTML reports
clean:
	rm -f $(PAPER)/*.html

