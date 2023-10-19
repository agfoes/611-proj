

# Define the target file name and URL
TARGET_FILE = data.csv
URL = https://data.cityofchicago.org/api/views/ijzp-q8t2/rows.csv?accessType=DOWNLOAD

# Default target: download data file
all: $(TARGET_FILE)

# Rule to download the data file using curl
$(TARGET_FILE):
	curl -o $(TARGET_FILE) $(URL)

# Clean target: remove the downloaded file
clean:
	rm -f $(TARGET_FILE)

