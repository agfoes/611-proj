
# Create two histograms for first pass at data analysis
figures/histogram_year.png figures/histogram_day.png: time_study.R source_data/time_data.csv
	Rscript time_study.R

# Clean up generated figures
clean:
	rm -f figures/histogram_year.png
	rm -f figures/histogram_day.png
	