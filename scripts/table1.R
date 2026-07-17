library(tidyverse)

# 1. Loading the data
url <- "https://raw.githubusercontent.com/opilette/ulaval2023/refs/heads/main/data/PILETTE_Olivier_2023_data.tsv"
df <- read.csv(url, sep = "\t")

# 2. Defining materials of interest
materials <- c("mat001", "mat002", "mat004", "mat005", "mat011", "mat015", "mat017")

# 3. Process: Calculate total quantity AND count unique sites per material
result <- df %>%
  filter(CODE %in% materials) %>%
  group_by(CODE) %>%
  summarise(
    Total_QT = sum(QT, na.rm = TRUE),
    Number_of_Sites = n_distinct(SITE)
  ) %>%
  arrange(CODE)

# 4. View and Export
print(result)
write.csv(result, "tableau11.csv", row.names = FALSE)