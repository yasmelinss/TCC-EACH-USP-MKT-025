data <-
  readRDS("skeets-cblol.rds") |>
    mutate(indexed_at = as.POSIXct(indexed_at))

ggplot(
  data,
  aes(x = indexed_at)
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

somar camadas do ggplot2
scale_y_continuous()
aumenatar dpi na hora de exportar
procurar theme_*() do ggplot2

@Yas , o que conseguir adiantar seu manuseio e da análise das postagens também será legal
Uma coisa que me ocorreu é fazer um density plot das date_time das postagens
