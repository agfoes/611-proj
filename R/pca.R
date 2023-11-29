library(tidyverse)
library(dplyr)
library(cluster)

# Load the data into R.
data <- read.csv("~/work/derived_data/full_time_data.csv")

# Filter data to only numeric variables
char_vars_to_convert <- c("Primary.Type","Arrest","Domestic","FBI.Code")
pca_data <- data %>%
  mutate(across(all_of(char_vars_to_convert), as.factor)) %>%
  mutate(across(all_of(char_vars_to_convert), as.integer)) %>%
  distinct() %>%
  select(is.factor, is.integer) %>%
  select(- ID)
write.csv(pca_data, "~/work/derived_data/pca_data.csv", row.names = FALSE)

# Perform PCA on the data set.
pca <- prcomp(pca_data)
# Plot the variance explained by each principal component as a function of the number of components.
variance_data <- data.frame(
  Principal_Component = 1:ncol(pca_data),
  Cumulative_Variance = cumsum(pca$sdev^2) / sum(pca$sdev^2))

variance_plot <- ggplot(variance_data, aes(x = Principal_Component, y = Cumulative_Variance)) +
  geom_line(color = "blue") +
  geom_point(color = "blue") +
  geom_hline(yintercept = 0.95, linetype = "dashed", color = "red") +
  labs(x = "Number of Principal Components",
       y = "Cumulative Proportion of Variance Explained",
       title = "Variance Explained by Principal Components",
       subtitle = "Red dashed line indicates 95% variance explained threshold") +
  theme_minimal()
ggsave(variance_plot, file = "~/work/figures/variance_by_component.png")

# Plot PC1 by PC2

label_mapping <- setNames(levels(as.factor(data$Primary.Type)), levels(as.character(data$Primary.Type)))
color_palette <- rainbow(length(label_mapping))

pr12 <- data.frame("PC1" = pca$x[,1], "PC2" = pca$x[,2], "Primary.Type" = as.factor(pca_data$Primary.Type))
plot_comps <- ggplot(pr12, aes(x = PC1, y = PC2, color = as.factor(Primary.Type))) +
  geom_point() +
  labs(x = "Principal Component 1", 
       y = "Principal Component 2",
       main = "Data Plot on PC1 and PC2 by Primary Crime Type") +
  theme_minimal() +
  scale_color_manual(name = "Primary Type", values = color_palette, labels = label_mapping) +
  theme(
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.key.width = unit(0.5, "cm"),
    legend.text = element_text(margin = margin(r = 10))) +
  guides(color = guide_legend(nrow = 11))
ggsave(plot_comps, file = "~/work/figures/data_on_pc1_pc2.png", height = 12, width = 16)

pr12_v2 <- data.frame("PC1" = pca$x[,1], "PC2" = pca$x[,2], "District" = as.factor(pca_data$District))
plot_comps_2 <- ggplot(pr12_v2, aes(x = PC1, y = PC2, color = (District))) +
  geom_point() +
  labs(x = "Principal Component 1", 
       y = "Principal Component 2",
       main = "Data Plot on PC1 and PC2 by District") +
  theme_minimal() +
  guides(color = "none")
ggsave(plot_comps_2, file = "~/work/figures/data_on_pc1_pc2_v2.png", height = 12, width = 16)

pr12_v3 <- data.frame("PC1" = pca$x[,1], "PC2" = pca$x[,2], "hour" = as.factor(pca_data$hour))
plot_comps_3 <- ggplot(pr12_v3, aes(x = PC1, y = PC2, color = (hour))) +
  geom_point() +
  labs(x = "Principal Component 1", 
       y = "Principal Component 2",
       main = "Data Plot on PC1 and PC2 by Hour") +
  theme_minimal() +
  guides(color = "none")
ggsave(plot_comps_3, file = "~/work/figures/data_on_pc1_pc2_v3.png", height = 12, width = 16)

