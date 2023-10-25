
# Define a variable for all figure files
FIGURES = figures/histogram_year.png figures/histogram_day.png

# Default target when you just use 'make'
all: all_figures

# Target to generate all figures
all_figures: $(FIGURES)

# Create two histograms for first pass at data analysis
figures/histogram_year.png figures/histogram_day.png: time_study.R source_data/time_data.csv
	Rscript time_study.R

# Clean up generated figures
clean:
	rm -f figures/histogram_year.png
	rm -f figures/histogram_day.png
	
