# Date/Time analysis of crime data from 2001 to 2023

data <- read.csv(time_data)

# Convert to POSIX format YY-MM-DD HH-MM-SS in 24-hour time
data$Date_Time <- as.POSIXct(data$Date_Time, format = "%Y-%m-%d %H:%M:%S")

# Extract time from date/time
data$time <- format(data$Date_Time, format = "%H:%M:%S")

# Extract date from data/time
data$date <- as.Date(data$Date_Time)

# Separate date into day, month, and year columns
data <- data %>% mutate(year = year(data$date))
data <- data %>% mutate(month = month(data$date))
data <- data %>% mutate(day = day(data$date))

# Pull hour from time
data$hour <- format(strptime(data$time, format="%H:%M:%S"), format="%H")