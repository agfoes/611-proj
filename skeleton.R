
# download/install packages and libraries

library(tidyverse)
library(dplyr)
library(ggplot2)
library(raster)
library(lubridate)

# read in data from makefile
data <- read.csv(data.csv)

# keep only data that is fully observed (rows without any NA values)
data_clean <- data[complete.cases(data),]

# use lubridate package to clean data/time column
new_date <- strptime(data_clean$Date, format = "%m/%d/%Y %I:%M:%S %p")
data_clean$Date <- new_date

# figure of frequencies of Primary.Type of crimes
p <- ggplot(data_clean, aes(x = Primary.Type)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Types of Crime",
       x = "Primary.Type",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("figures/crime_histogram.png",plot=p);
