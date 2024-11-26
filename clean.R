# load packages and data ####
library(tidyverse)
raw <- read_csv("SEAASEAN_raw.csv") # from https://github.com/SEASocFund/socFundScrapy/blob/main/data_formatted.csv

# merge keywords and remove duplicates ####
clean <- raw |> 
  group_by(pronums) |> 
  mutate(keyword = paste(unique(keyword), collapse = "；")) |>
  distinct(pronums, .keep_all = TRUE) |>
  ungroup()

# save clean data ####
write_csv(clean, "SEAASEAN_clean.csv")
