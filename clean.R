# load packages and data ####
library(tidyverse)
raw <- read_csv("https://raw.githubusercontent.com/SEASocFund/socFundScrapy/refs/heads/main/SEAASEAN.csv")

# merge keywords and remove duplicates ####
clean <- raw |> 
  group_by(pronums) |> 
  mutate(keyword = paste(unique(keyword), collapse = "；")) |>
  distinct(pronums, .keep_all = TRUE) |>
  ungroup()

# save clean data ####
write_csv(clean, "SEAASEAN_clean.csv")
