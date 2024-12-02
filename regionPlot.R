# load cleaned data ####
library(tidyverse)
# setwd("d:/OneDrive - London School of Economics/Desktop/SocFund/Plot") # change to your working directory
clean <- read_csv("SEAASEAN_clean.csv")

# format date ####
clean <- clean |>
  filter(!is.na(protime) & !is.na(provloc)) |>
  mutate(
    protime = as.Date(protime),
    provloc = replace(provloc, provloc == "教育部", "中央"),
    provloc = replace(provloc, provloc == "社科院", "中央"),
    provloc = replace(provloc, provloc == "党校", "中央"),
    provloc = replace(provloc, provloc == "湖南省", "湖南"),
    provloc = replace(provloc, provloc == "广西南宁", "广西"),
    provloc = replace(provloc, provloc == "军队系统", "军队"),
  )

# count provloc by year ####
plotData <- clean |>
  mutate(year = year(protime)) |>
  group_by(year, provloc) |>
  count()

plotDataSummary <- plotData |>
  group_by(provloc) |>
  summarise(n = sum(n)) |>
  arrange(desc(n))

plotData <- plotData |>
  mutate(provloc = fct_relevel(provloc, plotDataSummary$provloc)) # reorder provloc by sum of n

# plain plot ####
plotData |>
  ggplot(aes(x = year, y = n, fill = provloc)) +
  geom_area() +
  theme_bw(base_family = "Microsoft YaHei", # change to another font if needed
           base_size = 12) +
  labs(x = "年份", y = "数量", fill = "地区、部门")
#ggsave("output/regionPlot.pdf", width = 8, height = 5, device = cairo_pdf) # save as pdf