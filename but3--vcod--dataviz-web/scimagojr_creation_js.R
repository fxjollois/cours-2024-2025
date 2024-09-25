library(tidyverse)
library(jsonlite)

csv = read_csv("scimagojr.csv")

top_regions = csv %>%
  group_by(Region) %>%
  summarize(
    Documents = sum(Documents)
  ) %>%
  arrange(desc(Documents))
top_regions

toJSON(top_regions, pretty = T)

par_annee = csv %>%
  group_by(Year, Region) %>%
  summarize(
    Documents = sum(Documents)
  ) %>%
  pivot_wider(names_from = Region, values_from = Documents)

toJSON(par_annee, pretty = T)
