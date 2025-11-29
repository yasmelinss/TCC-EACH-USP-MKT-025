library(dplyr)
library(lubridate)
library(ggplot2)

skeets <-
  readRDS("Dados/skeets-cblol.rds") |>
  mutate(
    indexed_at = as.POSIXct(
      indexed_at
      )
    )


mapa_densidade <-
  ggplot(
    skeets,
    aes(
      x = indexed_at
    )
  ) +
    geom_density(
      fill = "steelblue",
      alpha = 1
    ) +
    labs(
      title = "Densidade de Postagens ao Longo do Tempo",
      x = "Data",
      y = "Frequência de postagens"
    ) +
    scale_y_continuous(
      breaks = seq(0, 2, by = 5),
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


ggsave(
  "img/densidade.png",
  plot = mapa_densidade,
  width = 4,      # largura em polegadas
  height = 4,      # altura em polegadas
  dpi = 300        # resolução
)

