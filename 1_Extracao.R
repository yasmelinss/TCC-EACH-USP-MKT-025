
library(tidyverse)
library(jsonlite)
library(atrrr)
library(igraph)
library(ggraph)
library(tidygraph)
library(kableExtra)

querys <-
  c('cblol','lol')

posts <-
  search_post(
    q = querys,
    limit = 5L,
    since = lubridate::dmy("02-07-2024"),
    until = lubridate::dmy("02-08-2024")
  ) |>
  filter(reply_count > 0)
