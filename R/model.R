library(dplyr)
library(caret)
library(forestplot)

# Model to predict crime type

data <- read.csv("~/work/derived_data/full_time_data.csv")

model_data <- data.frame(
  primtype = as.factor(factor(data$Primary.Type, levels = unique(data$Primary.Type))),
  arrest = as.factor(factor(data$Arrest, levels = unique(data$Arrest))),
  domestic = as.factor(factor(data$Domestic, levels = unique(data$Domestic))),
  beat = data$Beat,
  district = data$District,
  ward = data$Ward,
  month = data$month,
  day = data$day,
  hour = data$hour,
  community_area = data$Community.Area)

# model to predict if crime had an arrest based on location and time information
model <- glm(primtype ~ domestic + beat + district + ward + month + day + hour + community_area, 
             data = model_data, 
             family = "binomial")

coefficients <- coef(model)
odds_ratios <- exp(coefficients)
conf_intervals <- exp(confint(model))

mod_results <- data.frame(Coefficient = coefficients, 
           OR = odds_ratios, 
           lower = conf_intervals[, 1],
           upper = conf_intervals[, 2],
           Term = c("Intercept", "Domestic", "Beat", "District", "Ward", "Month", "Day", "Hour", "Community Area"))
mod_results <- mod_results %>% filter(Term != "Intercept")

fplot <- ggplot(mod_results, aes(x = OR, y = Term)) +
  geom_point(aes(x = OR), size = 3, color = "black") +
  geom_errorbarh(aes(xmin = lower, xmax = upper), height = 0.2, color = "black") +
  geom_vline(xintercept = 1, linetype = "dashed", color = "red") +
  labs(title = "Forest Plot",
       x = "Odds Ratio",
       y = "Term") +
  theme_minimal()

ggsave(fplot, filename = "figures/fplot.png")

