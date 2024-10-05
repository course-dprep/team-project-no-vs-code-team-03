# Directory definitions
DATA = data
TEMP = gen/temp
OUTPUT = gen/output
PAPER = src/paper

# All output targets
All: $(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz \
     $(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv $(TEMP)/merged_data.csv \
     $(TEMP)/engineered_data.csv $(OUTPUT)/cleaned_data.csv $(PAPER)/data_exploration.html


# 1: Download Data
$(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz : src/data_preparation/download_data_01.R
	mkdir -p $(DATA)
	R --vanilla < src/data_preparation/download_data_01.R

# 2: Drop Missing Values and Filter TV Episodes
$(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv $(TEMP)/title_ratings.tsv.gz: src/data_preparation/drop_missing_values_02.R $(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz
	mkdir -p $(TEMP)
	R --vanilla < src/data_preparation/drop_missing_values_02.R

# 3: Merge Datasets
$(TEMP)/merged_data.csv : src/data_preparation/merge_datasets_03.R $(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv
	mkdir -p $(TEMP)
	R --vanilla < src/data_preparation/merge_datasets_03.R	

# 4: Engineer Variables
$(TEMP)/engineered_data.csv : src/data_preparation/engineer_variables_04.R $(TEMP)/merged_data.csv
	mkdir -p $(TEMP)
	R --vanilla < src/data_preparation/engineer_variables_04.R	
	
# 5: Clean the Data
$(OUTPUT)/cleaned_data.csv : src/data_preparation/cleaned_data_05.R $(TEMP)/engineered_data.csv
	mkdir -p $(OUTPUT)
	R --vanilla < src/data_preparation/cleaned_data_05.R
	
# 6: Generate R Markdown Report
$(PAPER)/data_exploration.html : $(PAPER)/data_exploration.Rmd $(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz $(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv
	mkdir -p $(PAPER)
	Rscript -e "rmarkdown::render('$(PAPER)/data_exploration.Rmd', output_format = 'html_document', output_file = 'data_exploration.html', output_dir = '$(PAPER)')"

.PHONY: clean

# Clean up intermediate files (only keep the final cleaned data)
clean:
	rm -f $(TEMP)/*.csv



