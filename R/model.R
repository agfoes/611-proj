library(dplyr)
library(caret)

# Model to predict crime type

data <- read.csv("~/work/proj/derived_data/full_time_data.csv")

model_data <- data.frame(
  primtype = as.numeric(factor(data$Primary.Type, levels = unique(data$Primary.Type))),
  arrest = as.numeric(factor(data$Arrest, levels = unique(data$Arrest))),
  domestic = as.numeric(factor(data$Domestic, levels = unique(data$Domestic))),
  beat = data$Beat,
  district = data$District,
  ward = data$Ward,
  month = data$month,
  day = data$day,
  hour = data$hour,
  community_area = data$Community.Area)

set.seed(123)
train_control <- trainControl(method = "cv", number = 10)
model <- train(primtype ~.,data = model_data, trControl = train_control, method = "lm")

write.csv(model_data, "~/work/proj/derived_data/model_data", row.names = FALSE)
