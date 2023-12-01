### geographical study of crime by type

library(ggplot2)
library(dplyr)

data <- read.csv("~/work/derived_data/full_time_data.csv")

top5_types <- data %>%
  group_by(Primary.Type) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  top_n(5) %>%
  pull(Primary.Type)

filtered_df <- data %>%
  filter(Primary.Type %in% top5_types)

geo <- ggplot(filtered_df, aes(x = Longitude, y = Latitude, color = as.factor(Primary.Type))) +
  geom_point(size = 0.25) +
  labs(x = "Longitude", y = "Latitude", title = "Top 5 Most Frequent Crimes") +
  theme_minimal() +
  coord_fixed() +
  scale_color_manual(values = c("red", "cyan", "chartreuse4", "yellow", "purple"),
                     name = "Primary Crime Type") +
  guides(color = guide_legend(override.aes = list(size = 3) ) )

ggsave(plot = geo, filename = "~/work/figures/geo.png", width = 518, height = 296, units = "mm")
