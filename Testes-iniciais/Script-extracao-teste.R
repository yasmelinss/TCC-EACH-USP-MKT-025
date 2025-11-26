
library(tidyverse)
library(jsonlite)
library(atrrr)
library(igraph)
library(ggraph)
library(tidygraph)
library(kableExtra)

querys <-
  c('cblol')

posts <-
  search_post(
    q = querys,
    since = lubridate::dmy("26-07-2024"),
    until = lubridate::dmy("29-08-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_1_thread.rds")



posts2 <-
  search_post(
    q = querys,
    since = lubridate::dmy("30-08-2024"),
    until = lubridate::dmy("05-09-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_2_thread.rds")


posts3 <-
  search_post(
    q = querys,
    since = lubridate::dmy("06-09-2024"),
    until = lubridate::dmy("12-09-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_3_thread.rds")


posts4 <-
  search_post(
    q = querys,
    since = lubridate::dmy("13-09-2024"),
    until = lubridate::dmy("19-09-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_4_thread.rds")

posts5 <-
  search_post(
    q = querys,
    since = lubridate::dmy("20-09-2024"),
    until = lubridate::dmy("26-09-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_5_thread.rds")


posts6 <-
  search_post(
    q = querys,
    since = lubridate::dmy("27-09-2024"),
    until = lubridate::dmy("02-10-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_6_thread.rds")


posts7 <-
  search_post(
    q = querys,
    since = lubridate::dmy("03-10-2024"),
    until = lubridate::dmy("31-10-2024")
  ) |>
  filter(reply_count > 0)

saveRDS(posts, "periodo_7_thread.rds")

