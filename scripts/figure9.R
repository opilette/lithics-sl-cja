# Section 1: Data preparation ----
library(tidyverse)
library(scales)

materiaux <- c("mat001", "mat002", "mat004", "mat005", "mat011", "mat015", "mat017")

# Load spatial data & clean site names
north_pos <- read.csv("REL_NORTH.csv", sep = ",") %>%
  mutate(
    REL_LAT = as.numeric(gsub(",", ".", REL_LAT)),
    SITE = str_trim(SITE) # Removes accidental leading/trailing spaces
  )

# Load, categorize, calculate proportions, and join
matrix_long <- read.csv("https://raw.githubusercontent.com/opilette/ulaval2023/refs/heads/main/data/PILETTE_Olivier_2023_data.tsv", sep = "\t") %>%
  # Keep all TYPEs (filter removed) but exclude the unlocated artifact
  filter(SITE != "BjFs-0") %>%
  mutate(
    SITE = str_trim(SITE), 
    Material = if_else(CODE %in% materiaux, CODE, "unidentified")
  ) %>%
  # NEW ORDER: Remove unidentified items BEFORE calculating proportions
  filter(Material != "unidentified") %>% 
  
  group_by(SITE, Material) %>%
  summarise(QT = sum(QT), .groups = "drop_last") %>% 
  # Now, this math only sees the 7 materials, so they will add up to 1.0 (100%)
  mutate(Proportion = QT / sum(QT)) %>% 
  ungroup() %>%
  
  # RIGHT JOIN: Forces all 66 sites from north_pos to stay in the dataset
  # If a site ONLY had unidentified materials, it will now correctly show as an empty space
  right_join(north_pos %>% select(SITE, REL_LAT), by = "SITE") %>%
  arrange(REL_LAT) %>%
  mutate(
    SITE = factor(SITE, levels = unique(SITE)),
    Material = factor(Material, levels = materiaux) # 'unidentified' removed
  )

# Section 2: Visualization ----
custom_palette <- c(
  mat001 = "#56B4E9", mat002 = "#000000", mat004 = "#DBDBDB",
  mat005 = "#33A02C", mat011 = "#E31A1C", mat015 = "#8338EC", 
  mat017 = "#E69F00" 
)

stacked2 <- ggplot(matrix_long, aes(x = SITE, y = Proportion, fill = Material)) +
  geom_col(width = 1, color = NA) + 
  scale_y_continuous(
    labels = percent_format(),
    expand = c(0, 0)
  ) +
  scale_x_discrete(
    drop = FALSE, # Ensures empty sites aren't dropped from the axis completely
    labels = function(x) {
      idx <- seq_along(x)
      last_idx <- length(x)
      if_else(
        idx == 1 | idx == last_idx | (idx %% 5 == 0 & idx != last_idx - 1), 
        as.character(idx), 
        ""
      )
    }
  ) + 
  scale_fill_manual(values = custom_palette, na.translate = FALSE) +
  theme_minimal(base_size = 15) + 
  labs(
    x = "Relative Latitude (South to North)",
    y = "Relative Proportion",
    fill = "Material"
  ) +
  theme(
    axis.title = element_text(face = "bold"),
    panel.grid.major.x = element_blank(),
    legend.position = "bottom",
    legend.key.size = unit(0.8, "cm"),
    
    axis.text.x = element_text(size = 11, vjust = 1),
    axis.ticks.x = element_line(color = "grey30", linewidth = 0.5),
    axis.ticks.length.x = unit(0.15, "cm")
  )

# Section 3: Export ----
ggsave(
  filename = "figure_9_without_unidentified_weithed.tiff",
  plot = stacked2,
  device = "tiff",
  width = 200, 
  height = 160,
  units = "mm",
  dpi = 600,
  compression = "lzw"
)