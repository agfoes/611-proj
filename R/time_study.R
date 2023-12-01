# Date/Time analysis of crime data from 2001 to 2023

# Install necessary libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)

data <- read.csv("~/work/source_data/time_data.csv")
data <- data %>% select(-Year)

# Convert to POSIX format
data$Date <- as.POSIXct(data$Date, format = "%m/%d/%Y %I:%M:%S %p")

# Extract time from date/time
data$time <- format(data$Date, format = "%H:%M:%S")

# Extract date from data/time
data$date <- as.Date(data$Date)

# Separate date into day, month, and year columns
data <- data %>% mutate(year = year(data$date))
data <- data %>% mutate(month = month(data$date))
data <- data %>% mutate(day = day(data$date))

# Pull hour from time
data$hour <- format(strptime(data$time, format="%H:%M:%S"), format="%H")

# Figure of frequency of crimes by year
year_frequency <- ggplot(data, aes(x = year)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Crimes by Year",
       x = "Year",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(year_frequency, filename = "figures/histogram_year.png")

# Figure of frequency of crimes by day of month
day_frequency <- ggplot(data, aes(x = day)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Crimes by Day",
       x = "Day",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(day_frequency, filename = "figures/histogram_day.png")

# Figure of frequency of crimes by day of month
hour_frequency <- ggplot(data, aes(x = hour)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Crimes by Hour",
       x = "Hour",
       y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(hour_frequency, filename = "figures/histogram_hour.png")
