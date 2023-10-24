

figures/crime_histogram.png: crime_type.R ~/work/source_data/data2010.csv
	Rscript ~/work/codes/crime_type.R

# Clean up generated figures
clean:
	rm -f figures/crime_histogram.png