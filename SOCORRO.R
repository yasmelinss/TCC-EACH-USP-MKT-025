#Este é um script de teste TODO bagunçado não leve em consideração


library(dplyr)
library(lubridate)
library(ggplot2)
library(Hmisc)
library(tidyverse)



skeets <-
  readRDS("skeets-cblol.rds") |>
  mutate(indexed_at = as.POSIXct(indexed_at))


posts_por_dia <-
  skeets |>
  mutate(
    dia = as.Date(indexed_at)
  ) |>
  count(dia)

posts_por_dia_e_hora <-
  skeets |>
    mutate(
      dia = as.Date(indexed_at),
      hora = hour(indexed_at)
    ) |>
  count(dia, hora)

#gráfico de densidade POR DIA
ggplot(
  posts_por_dia,
  aes(x = dia)
) +
  geom_density(
    fill = "steelblue",
    alpha = 0.4
  ) +
  labs(
    title = "Densidade de Postagens ao Longo do Tempo",
    x = "Data",
    y = "Quantidade de postagens diárias"
  )

#gráfico de densidade POR DIA (mas considera HORA)
ggplot(
  posts_por_dia_e_hora,
  aes(
    x = dia
  )
) +
  geom_density(
    fill = "steelblue",
    alpha = 0.4
  ) +
  labs(
    title = "Densidade de Postagens ao Longo do Tempo",
    x = "Data",
    y = "Quantidade de postagens diárias"
  ) +
  scale_y_continuous(
    breaks = seq(0, 0.002, by = 0.0005),
    expand = expansion(mult = c(0, 0.01))
  ) +
  scale_x_datetime(
    date_labels = "%d/%m/%Y",
    date_breaks = "10 days"
  ) +

  geom_vline(
    xintercept = as.POSIXct(c("2024-08-31", "2024-10-08")),
    color = "red",
    linewidth = 0.9,
    linetype = "dashed"

  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



#gpt

gpt_todos_os_indexed_at <-
  skeets |>
    mutate(
      indexed_at = as.POSIXct(
        indexed_at
      )
    )


horas <- tibble::tibble(
  y = seq(1, 24),
  horario = seq("1", "24")
)


#gráfico de densidade TUDO?

ggplot(
  gpt_todos_os_indexed_at,
  aes(
    x = indexed_at
  )
) +

geom_density(
  fill = "steelblue",
  alpha = 0.4
  ) +
  labs(
    title = "Densidade de Postagens ao Longo do Tempo",
    x = "Data",
    y = "Densidade"
  ) +
  scale_y_continuous(
    breaks = seq(0, 0.002, by = 0.0005),
    expand = expansion(mult = c(0, 0.01))
  ) +
  scale_x_datetime(
    date_labels = "%d/%m/%Y",
    date_breaks = "7 days"
  ) +

geom_vline(
  xintercept = as.POSIXct(c("2024-08-31", "2024-10-08")),
  color = "red",
  linewidth = 0.9,
  linetype = "dashed"

) +
theme_bw() +
theme(axis.text.x = element_text(angle = 45, hjust = 1))


#o que o gpt tá fazendo????
# Ele pega só os dias, mas não pega as HORAS, então ele tá fazendo por quantidade de posts em dias, e não em horários, por isso "não há" eixo Y



#somar camadas do ggplot2
#scale_y_continuous()
#aumenatar dpi na hora de exportar
#procurar theme_*() do ggplot2
#
#@Yas , o que conseguir adiantar seu manuseio e da análise das postagens também será legal
#Uma coisa que me ocorreu é fazer um density plot das date_time das postagens




#Mapa de calor

mapa_calor <-
  ggplot(
    posts_por_dia_e_hora,
    aes(
      x = dia,
      y = hora,
      fill = n
    )
  ) +
  geom_tile() +
  scale_fill_viridis_c(
    option = "inferno",
    trans = "log10",
  ) +
  labs(
    title = "Mapa de calor de postagens por hora e dia",
    x = "Data",
    y = "Hora do dia"
  ) +
  theme_minimal() +
  # coord_fixed(ratio = 0.05) +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1,
      )
  ) +
  geom_vline(
    xintercept = as.POSIXct(c("2024-08-30", "2024-10-08")),
    color = "red",
    linewidth = 0.9,
    linetype = "dashed"
  ) +
  scale_x_date(
    date_labels = "%d/%m/%Y",
    date_breaks = "7 days"
  ) +
  annotate(
    "rect",
    xmin = as.Date("2024-09-06"),
    xmax = as.Date("2024-09-07") + 1,
    ymin = 13,
    ymax = 19,
    colour = "green",                   # borda visível
    fill = scales::alpha("white", 0),   # preenchimento 100% transparente
    linewidth = 1
  )

ggsave(
  "Imagens/mapa_de_calor2.png",
  plot = mapa_calor,
  width = 8,      # largura em polegadas
  height = 3,      # altura em polegadas
  dpi = 300        # resolução
)

#configurações de exportação específica: width: 800, height: 300.


#Including or excluding observations with the filter function

dia1 <- as.Date(c("2024-08-29"))

data.dia1 <-
  data |>
    filter(as.Date(indexed_at) == dia1)




#pega um período específico
data.dia1 <- data |>
  filter(indexed_at >= ymd_hms("2024-08-29 00:00:00"),
         indexed_at <  ymd_hms("2024-08-30 00:00:00"))

# 1 grupo, posso separar por grupos e pegar as quantidades somadas de alguam coisa
#n de x coisa per group

#seria algo como quantidade de posts por dia.





#mapa user activity

#o que eu quis dizer com isso????



library(ggraph)
#> Loading required package: ggplot2
library(tidygraph)
#>
#> Attaching package: 'tidygraph'
#> The following object is masked from 'package:stats':
#>
#>     filter

# Create graph of highschool friendships
graph <- as_tbl_graph(highschool) |>
  mutate(Popularity = centrality_degree(mode = 'in'))

# plot using ggraph
ggraph(graph, layout = 'kk') +
  geom_edge_fan(aes(alpha = after_stat(index)), show.legend = FALSE) +
  geom_node_point(aes(size = Popularity)) +
  facet_edges(~year) +
  theme_graph(foreground = 'steelblue', fg_text_colour = 'white')











# MÉTRICAS

library(dplyr)

skeets <-
  readRDS("skeets-cblol.rds")

library(dplyr)

metricas_vertices <- skeets |>
  mutate(
    across(
      c(likes_dados, likes_recebidos, replies_dados, replies_recebidos, n_postagens),
      ~ coalesce(.x, 0)
    )
  )




# REPLIES E QUOTES
#Assim, já dá pra calcular alguma métrica de dinâmica entre os actors



#uri, author_handle, reply_count, repost_count, like_count, quote_count, in_reply_to, in_reply_root, quotes.


#tirando os NA
quotes <- skeets[!is.na(skeets$quotes), ]


#é um quote que contêm a query CBLOL.


quotes_comuns <- quotes[!is.na(quotes$in_reply_to), ]


são quotes que se respondem.



Estabelecendo grandezas

Likes - peso 1
replie - peso 2
repost - peso 2
quote -peso 3
post próprio - peso 4


Já com relação às métricas dos vértices
(que dariam larguras das bolinha e uma posição de maior
centralidade ou "perifericidade" na representação gráfica do grafo)


#SOMA LIKES
skeets <-
  readRDS("Dados/skeets-cblol.rds")

likes_dados <-
  skeets |>
   filter(like_count > 0) |>
  count(like_count) |>
  mutate(produto = like_count * n)

likes_dados |>
  summarise(total = sum(produto))



#Lendo os LIKES


library(dplyr)
library(purrr)

caminho_pasta <- "Dados/likes/likes"

df_final_tidy <- list.files(path = caminho_pasta, pattern = "\\.rds$", full.names = TRUE) |>
  map(readRDS) |>
  list_rbind()

head(df_final_tidy)
dim(df_final_tidy)







