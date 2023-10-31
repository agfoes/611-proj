# load necessary packages. Takes a while to run this chunk and load the original data set
library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)

# Clean/Process Data
data <- read.csv("~/work/source_data/data_2020.csv")

# Extract and reformat date/time information
time_data <- data.frame(Date_Time = data$Date)

time_data$Date_Time <- as.POSIXct(time_data$Date_Time, format = "%m/%d/%Y %I:%M:%S %p")

time_data$time <- format(time_data$Date_Time, format = "%H:%M:%S")
time_data$date <- as.Date(time_data$Date_Time)

time_data <- time_data %>% mutate(month = month(time_data$date))
time_data <- time_data %>% mutate(day = day(time_data$date))

time_data$hour <- format(strptime(time_data$time, format="%H:%M:%S"), format="%H")

data_full_time <- bind_cols(data, time_data)
full_data <- data_full_time[complete.cases(data_full_time), ]

# Create plot of histogram for frequency of type of crime
frequency_type <- ggplot(data, aes(x = Primary.Type)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Types of Crime",
       x = "Type of Crime",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggsave(frequency_type, filename = "~/work/figures/type_histogram_2020.png")

# Convert data to factors as needed or make indicator variables as needed

# Save data created to derived_data
write.csv(full_data, "~/work/derived_data/full_time_data.csv", row.names = FALSE)


