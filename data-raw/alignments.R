library(readODS)
library(here)
library(tidyverse)

alignments <-
  readODS::read_ods(here::here('data-raw/alignments.ods')) %>%
  tibble::as_tibble() %>%
  tidyr::drop_na()

usethis::use_data(alignments, internal = TRUE, overwrite = TRUE)
