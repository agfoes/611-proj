
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
	
geo: \
	R/geo.R \
	derived_data/full_time_data.csv
	Rscript R/geo.R
	
report: \
	time_figures \
	full_data \
	pca \
	fplot \
	geo \
	report.Rmd
		Rscript -e "rmarkdown::render('report.Rmd',output_format='html_document')"
		
# Clean up generated figures
clean:
	rm -rf figures
	rm -rf derived_data
	rm -rf report.html
	mkdir -p figures
	mkdir -p derived_data
	
