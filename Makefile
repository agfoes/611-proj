
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
	
# Run PCA and create associated figures
pca: \
	R/pca.R \
	derived_data/full_time_data.csv
	Rscript R/pca.R

# Logistic Regression and Forest Plot
fplot: \
	R/model.R \
	derived_data/full_time_data.csv
	Rscript R/model.R
	
	
report: \
	
	
	
	
# Clean up generated figures
clean:
	rm -f figures/histogram_year.png
	rm -f figures/histogram_day.png
	rm -f figures/type_histogram_2020.png
	rm -f derived_data/full_time_data.csv
	rm -f derived_data/pca_data.csv
	rm -f figures/data_on_pc1_pc2.png
	rm -f figures/variance_by_component.png
	rm -f figures/fplot.png
	
