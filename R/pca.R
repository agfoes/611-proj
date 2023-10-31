library(tidyverse)
library(dplyr)

# Load the data into R.
data <- read.csv("~/work/source_data/time_data.csv")
# Perform PCA on the data set.
pca <- prcomp(data)
# Plot the variance explained by each principal component as a function of the number of components.
variance_data <- data.frame(
  Principal_Component = 1:ncol(data),
  Cumulative_Variance = cumsum(pca$sdev^2) / sum(pca$sdev^2))

ggplot(variance_data, aes(x = Principal_Component, y = Cumulative_Variance)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "blue", size = 3) +
  geom_hline(yintercept = 0.95, linetype = "dashed", color = "red") +
  labs(x = "Number of Principal Components",
       y = "Cumulative Proportion of Variance Explained",
       title = "Variance Explained by Principal Components",
       subtitle = "Red dashed line indicates 95% variance explained threshold") +
  theme_minimal()
ggsave("variance_by_component.png")

# Plot PC1 by PC2
pr12 <- data.frame("PC1" = pca$x[,1], "PC2" = pca$x[,2])
ggplot(pr12, aes(x = PC1, y = PC2)) +
  geom_point() +
  labs(x = "Principal Component 1", y = "Principal Component 2",
       main = "Data Plot on PC1 and PC2") +
  theme_minimal()
ggsave("data_on_pc1_pc2.png")

# Extract two densely-populated areas of PC1-by-PC2 plot
area1 <- pr12 %>% filter(PC1 <= 100 & PC1 >= 75 & PC2 >= 40 & PC2 <= 80)
area2 <- pr12 %>% filter(PC1 <= -50 & PC1 >= -100 & PC2 >= 0 & PC2 <= 50)