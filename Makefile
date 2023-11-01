
.PHONY: clean

# Create two histograms for 2001-2023 time data
time_figures: \
	R/time_study.R \
	source_data/time_data.csv
	Rscript R/time_study.R

# Clean and pre-process data for 2020 only. Create first .png of histogram of 
# frequency of crime by primary.type
full_data: \
	R/clean.R \
	source_data/data_2020.csv
	Rscript R/clean.R

# Clean up generated figures
clean:
	rm -f figures/histogram_year.png
	rm -f figures/histogram_day.png
	rm -f figures/type_histogram_2020.png
	rm -f derived_data/full_time_data.csv
	
