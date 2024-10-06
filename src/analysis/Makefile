# Directory definitions
ROOT_DIR = ../../
OUTPUT = $(ROOT_DIR)gen/output
ANALYSIS = $(ROOT_DIR)src/analysis
PAPER = $(ROOT_DIR)src/paper

# All output targets
All: $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html $(PAPER)/Analysis_Conclusion.html

# 1: Run Regression Model 1
$(OUTPUT)/regression_model_1_summary.html : $(ANALYSIS)/regression_model_1.R $(OUTPUT)/cleaned_data.csv
	mkdir -p $(OUTPUT)
	R --vanilla -f $(ANALYSIS)/regression_model_1.R

# 2: Run Regression Model 2
$(OUTPUT)/regression_model_2_summary.html : $(ANALYSIS)/regression_model_2.R $(OUTPUT)/cleaned_data.csv
	mkdir -p $(OUTPUT)
	R --vanilla -f $(ANALYSIS)/regression_model_2.R

# 3: Generate R Markdown Report for Analysis
$(PAPER)/Analysis_Conclusion.html : $(PAPER)/Analysis_Conclusion.Rmd $(OUTPUT)/regression_model_1_summary.html $(OUTPUT)/regression_model_2_summary.html
	mkdir -p $(PAPER)
	R --vanilla -e "rmarkdown::render('$(PAPER)/Analysis_Conclusion.Rmd', output_format = 'html_document', output_file = 'Analysis_Conclusion.html', output_dir = '$(PAPER)')"

.PHONY: clean

# Clean up intermediate files (only keep the final HTML reports)
clean:
	rm -f $(OUTPUT)/regression_model_*.html	

	
	

