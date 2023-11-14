library(dplyr)
library(caret)

# Model to predict crime type

data <- read.csv("~/work/derived_data/full_time_data.csv")

primtype <- as.numeric(factor(data$Primary.Type, levels = unique(data$Primary.Type)))
arrest <- as.numeric(factor(data$Arrest, levels = unique(data$Arrest)))
domestic <- as.numeric(factor(data$Domestic, levels = unique(data$Domestic)))
beat <- data$Beat
district <- data$District
ward <- data$Ward
month <- data$month
day <- data$day
hour <- data$hour
community_area <- data$Community.Area


m1 <- lm(primtype ~ arrest + domestic + beat + district + ward + community_area + month + day + hour)
plot(m1)


outcome_variable <- primtype
predictor_variables <- c(arrest, beat, community_area, day, district, domestic, hour, month, ward)

# Define the model formula
formula <- as.formula(paste(outcome_variable, "~", paste(predictor_variables, collapse = " + ")))

# Create the linear regression model
model <- lm(formula)

# Define the training control
ctrl <- trainControl(method = "cv", number = 10)  # 10-fold cross-validation

# Perform cross-validation
cv_results <- train(model, trControl = ctrl)

# View the results
print(cv_results)
