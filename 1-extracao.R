########################################## #
# script de extração de skeets do bluesky
########################################## #

# bibliotecas ----

library(atrrr)
library(tidyverse)
#library(readr)

# parâmetros da busca ----

## quando buscar? ----

inicio.bloqueio <- "30-08-2024" |> dmy()
wday(inicio.bloqueio)
  # começou em uma sexta-feira
  # marcando as semanas a partir das sextas-feiras
inicio.busca <- inicio.bloqueio - 4 * dweeks()
final.bloqueio <- "08-10-2024" |> dmy()
wday(final.bloqueio)
  # terminou em uma quinta-feira
final.bloqueio - inicio.bloqueio + 1
  # o bloqueio durou 40 dias --> não é um número redondo de semanas
(final.bloqueio - inicio.bloqueio + 1) / dweeks()
  # 5.7 blocos de 7 dias
  # 1 bloco de 7 dias != 1 semana, pois o bloco não começa no domingo
((final.bloqueio - inicio.bloqueio + 1) / dweeks() - 5) * dweeks()
  # 5 blocos de 7 dias e 5 dias
  # 5 blocos inteiros e, no sexto bloco, saiu o desbloqueio
final.busca <- final.bloqueio + 2 * ddays() + 4 * dweeks()
(final.busca - inicio.busca + 1) / dweeks()
  # 14 blocos de 7 dias
  #    blocos 1 a 4: 1 mês antes
  #    bloco 5: bloqueia 1o dia desse bloco
  #    blocos 6 a 9: só bluesky
  #    bloco 10: desbloqueia no 5o dia desse bloco
  #    blocos 11 a 14: X voltando a funcionar e bluesky esvaziando

## o quê buscar? ----

# termos.busca <- c("cblol", "lol")  # tanto CBLOL como LOL em geral
#termos.busca <- c("cblol")  # só CBLOL

# autenticando ----

auth(
  user = 'yasmelinss.bsky.social',
  password = read_lines("senha.txt"),
  overwrite = TRUE
)

# buscando skeets ----

## primeira tentativa: tudo de uma vez ----

skeets.cblol.tudo <-
  search_post(
    q = termos.busca,
    since = inicio.busca,
    until = final.busca
  )
# ué, só 184 skeets?!?

skeets.cblol.cblol <-
  search_post(
    q = "cblol",
    since = inicio.busca,
    until = final.busca
  )
  # 184 skeets

skeets.cblol.hash.cblol <-
  search_post(
    q = '"#cblol"',
    since = inicio.busca,
    until = final.busca
  )
  # 189 skeets

skeets.cblol.cblol$uri |> length()
skeets.cblol.hash.cblol$uri |> length()
intersect(
  skeets.cblol.cblol$uri,
  skeets.cblol.hash.cblol$uri
) |> length()
  # o mesmo resultado em ambos quando busca com '"#cblol"'

# não parece confiável tentar extrair tudo de uma vez

## segunda tentativa: fatiando ----

### fatiando por dia ----

dias.buscas <- seq(inicio.busca, final.busca)

skeets.cblol.por.dia <-
  seq(inicio.busca, final.busca) |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 1 * ddays(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 1 * ddays()
            )
        )
      }
    )
  )

n.skeets.por.dia <-
  skeets.cblol.por.dia |>
  map_dfr(
    function(bloco)
      tibble(
        dia = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

dias.a.refinar <-
  n.skeets.por.dia |>
  filter(n.skeets >= 100) |>
  pull(dia)

skeets.dias.ok <-
  skeets.cblol.por.dia[!dias.buscas %in% dias.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os dias com excesso de postagem ----

blocos.12h.buscas <-
  expand_grid(
    dia = dias.a.refinar,
    hora = 0:1 * 12 * dhours()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.12h <-
  blocos.12h.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 12 * dhours(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 12 * dhours()
            )
        )
      }
    )
  )

n.skeets.por.12h <-
  skeets.cblol.por.12h |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.12h.a.refinar <-
  n.skeets.por.12h |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.12h.ok <-
  skeets.cblol.por.12h[!blocos.12h.buscas %in% blocos.12h.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 12h com excesso de postagem ----

blocos.6h.buscas <-
  expand_grid(
    dia = blocos.12h.a.refinar,
    hora = 0:1 * 6 * dhours()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.6h <-
  blocos.6h.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 6 * dhours(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 6 * dhours()
            )
        )
      }
    )
  )

n.skeets.por.6h <-
  skeets.cblol.por.6h |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.6h.a.refinar <-
  n.skeets.por.6h |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.6h.ok <-
  skeets.cblol.por.6h[!blocos.6h.buscas %in% blocos.6h.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 6h com excesso de postagem ----

blocos.3h.buscas <-
  expand_grid(
    dia = blocos.6h.a.refinar,
    hora = 0:1 * 3 * dhours()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.3h <-
  blocos.3h.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 3 * dhours(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 3 * dhours()
            )
        )
      }
    )
  )

n.skeets.por.3h <-
  skeets.cblol.por.3h |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.3h.a.refinar <-
  n.skeets.por.3h |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.3h.ok <-
  skeets.cblol.por.3h[!blocos.3h.buscas %in% blocos.3h.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 3h com excesso de postagem ----

blocos.1h.buscas <-
  expand_grid(
    dia = blocos.3h.a.refinar,
    hora = 0:2 * dhours()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.1h <-
  blocos.1h.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 1 * dhours(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 1 * dhours()
            )
        )
      }
    )
  )

n.skeets.por.1h <-
  skeets.cblol.por.1h |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.1h.a.refinar <-
  n.skeets.por.1h |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.1h.ok <-
  skeets.cblol.por.1h[!blocos.1h.buscas %in% blocos.1h.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 1h com excesso de postagem ----

blocos.30min.buscas <-
  expand_grid(
    dia = blocos.1h.a.refinar,
    hora = 0:1 * 30 * dminutes()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.30min <-
  blocos.30min.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 30 * dminutes(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 30 * dminutes()
            )
        )
      }
    )
  )

n.skeets.por.30min <-
  skeets.cblol.por.30min |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.30min.a.refinar <-
  n.skeets.por.30min |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.30min.ok <-
  skeets.cblol.por.30min[!blocos.30min.buscas %in% blocos.30min.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 30min com excesso de postagem ----

blocos.10min.buscas <-
  expand_grid(
    dia = blocos.30min.a.refinar,
    hora = 0:2 * 10 * dminutes()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.10min <-
  blocos.10min.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 10 * dminutes(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 10 * dminutes()
            )
        )
      }
    )
  )

n.skeets.por.10min <-
  skeets.cblol.por.10min |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.10min.a.refinar <-
  n.skeets.por.10min |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.10min.ok <-
  skeets.cblol.por.10min[!blocos.10min.buscas %in% blocos.10min.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 10min com excesso de postagem ----

blocos.5min.buscas <-
  expand_grid(
    dia = blocos.10min.a.refinar,
    hora = 0:2 * 5 * dminutes()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.5min <-
  blocos.5min.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 5 * dminutes(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 5 * dminutes()
            )
        )
      }
    )
  )

n.skeets.por.5min <-
  skeets.cblol.por.5min |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.5min.a.refinar <-
  n.skeets.por.5min |>
  filter(n.skeets >= 100) |>
  pull(quando)

skeets.5min.ok <-
  skeets.cblol.por.5min[!blocos.5min.buscas %in% blocos.5min.a.refinar] |>
  map(\(x) x$skeets) |>
  list_rbind()

### refinando os blocos de 5min com excesso de postagem ----

blocos.1min.buscas <-
  expand_grid(
    dia = blocos.5min.a.refinar,
    hora = 0:4 * 1 * dminutes()
  ) |>
  mutate(quando = dia + hora) |>
  pull(quando)

skeets.cblol.por.1min <-
  blocos.1min.buscas |>
  map(
    insistently(
      \(inicio.bloco) {
        list(
          inicio = inicio.bloco,
          final = inicio.bloco + 1 * dminutes(),
          skeets =
            search_post(
              q = "cblol",
              since = inicio.bloco,
              until = inicio.bloco + 1 * dminutes()
            )
        )
      }
    )
  )

n.skeets.por.1min <-
  skeets.cblol.por.1min |>
  map_dfr(
    function(bloco)
      tibble(
        quando = bloco$inicio,
        n.skeets = nrow(bloco$skeets)
      )
  )

blocos.1min.a.refinar <-
  n.skeets.por.1min |>
  filter(n.skeets >= 100) |>
  pull(quando)

  ###### finalmente não precisou mais refinar ----

skeets.1min.ok <-
  skeets.cblol.por.1min |>
  map(\(x) x$skeets) |>
  list_rbind()


### juntando os blocos de skeets ----

skeets <-
  bind_rows(
    skeets.dias.ok,
    skeets.12h.ok,
    skeets.6h.ok,
    skeets.3h.ok,
    skeets.1h.ok,
    skeets.30min.ok,
    skeets.10min.ok,
    skeets.5min.ok,
    skeets.1min.ok
  )

nrow(skeets)

# pra liberar espaço
rm(
  skeets.dias.ok,
  skeets.12h.ok,
  skeets.6h.ok,
  skeets.3h.ok,
  skeets.1h.ok,
  skeets.30min.ok,
  skeets.10min.ok,
  skeets.5min.ok,
  skeets.1min.ok
)

# buscando threads desses skeets (inclui replies e reskeets) ----

# juntando todos os skeets ----

# buscando users que deram like em todos esses skeets ----

# juntando todos os users, vindos de threads ou de likes ----

# salvando tudo ----



