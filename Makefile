SHELL := /bin/bash

# Directory definitions
SRC = src
DATA_PREP =	$(SRC)/data_preparation
ANALYSIS =	$(SRC)/analysis
PAPER =	$(SRC)/paper

# sequence
all: data_preparation analysis paper

# Run the makefile in src/data_preparation
data_preparation:
	@cd $(DATA_PREP) && $(MAKE)

# Run the makefile in src/analysis 
analysis: data_preparation
	@cd $(ANALYSIS) && $(MAKE)

# Run the makefile in src/paper 
paper: analysis
	@cd $(PAPER) && $(MAKE)

.PHONY: all data_preparation analysis paper clean

# Clean all 
clean:
	@cd $(DATA_PREP) && $(MAKE) clean
	@cd $(ANALYSIS) && $(MAKE) clean
	@cd $(PAPER) && $(MAKE) clean


