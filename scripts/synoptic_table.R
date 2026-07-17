library(tidyverse)

# Loading the data
url <- "https://raw.githubusercontent.com/opilette/ulaval2023/refs/heads/main/data/PILETTE_Olivier_2023_data.tsv"
df <- read.csv(url, sep = "\t")

# Selecting the data of interest
materials <- c("mat001", "mat002", "mat004", "mat005", "mat011", "mat015", "mat017")
lithics_filtered <- df %>% filter(CODE %in% materials)
lithics_filtered <- lithics_filtered[!grepl("BjFs-0", lithics_filtered$SITE), ]# Removing BjFs-0 which is a artefact without location

# Formatting the lithic data into a synoptic table (syntab)
syntab <- lithics_filtered %>%
  group_by(SITE, CODE, TYPE) %>%
  summarise(QT = sum(QT, na.rm = TRUE), .groups = "drop") %>%
  mutate(val = sprintf("%s(%s)", TYPE, QT)) %>%
  group_by(SITE, CODE) %>%
  summarise(val = paste(val, collapse = ", "), .groups = "drop") %>%
  pivot_wider(names_from = CODE, values_from = val, values_fill = "")

# Export the table to CSV
write.csv(syntab, "synoptic_table.csv", row.names = FALSE)