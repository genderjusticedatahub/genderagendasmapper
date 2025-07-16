# Load libraries

library(tidyverse)

# Read the CSV file

Dataset <- read_csv("Jun25Output.csv") %>% 
  filter(probability >= 0.75)

# Count how many unique countries each topic_label appears in

Topic_Countries <- Dataset %>%
  distinct(topic_label, country) %>%
  count(topic_label, name = "n_countries")

# Step 2: Count total occurrences of each topic_label

Topic_Freq <- Dataset %>%
  count(topic_label, name = "n_total")

# Step 3: Combine frequency and geographic spread

Topic_Summary <- Topic_Freq %>%
  left_join(Topic_Countries, by = "topic_label")

# Step 4: Calculating scores

Topic_Summary <- Topic_Summary %>%
  mutate(score = n_total + 2 * n_countries)

# Step 5: Top 10 topics

Top_Topics <- Topic_Summary %>%
  arrange(desc(score)) %>%
  slice_head(n = 10)
