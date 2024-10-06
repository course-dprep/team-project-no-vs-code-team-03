SHELL := /usr/bin/env bash

# Directory definitions
DATA_PREPARATION_DIR = src/data_preparation
ANALYSIS_DIR = src/analysis

# Targets
.PHONY: all data-preparation analysis clean

# Run the entire workflow
all: data-preparation analysis

# 1: Run Data Preparation Makefile
data-preparation:
	$(MAKE) -C $(DATA_PREPARATION_DIR)

# 2: Run Analysis Makefile
analysis: data-preparation
	$(MAKE) -C $(ANALYSIS_DIR)

# Clean up all generated files
clean:
	$(MAKE) -C $(DATA_PREPARATION_DIR) clean
	$(MAKE) -C $(ANALYSIS_DIR) clean
