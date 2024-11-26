# load cleaned data ####
library(tidyverse)
# setwd("d:/OneDrive - London School of Economics/Desktop/SocFund/Plot")
clean <- read_csv("SEAASEAN_clean.csv")

# format date ####
clean <- clean |>
  filter(protime != "null" & subtype != "null") |>
  mutate(
    protime = as.Date(protime),
    subtype = replace(subtype, subtype == "区域国别学和国际问题研究", "区域国别学"),
    subtype = replace(subtype, subtype == "理论经济", "理论经济学"),
    subtype = replace(subtype, subtype == "应用经济", "应用经济学")
  )

# count subtype by year ####
plotData <- clean |>
  mutate(year = year(protime)) |>
  group_by(year, subtype) |>
  count()

# plot ####
plotData |>
  ggplot(aes(x = year, y = n, fill = subtype)) +
  geom_area() +
  theme_bw(base_family = "Microsoft YaHei", # change to another font if needed
           base_size = 12) +
  labs(x = "年份", y = "数量", fill = "学科")
#ggsave("plot.pdf", width = 8, height = 5)
