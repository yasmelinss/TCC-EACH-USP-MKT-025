library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)


# lendo arquivo ----
skeets <-
  base::readRDS("Dados/skeets-cblol.rds") |>
  dplyr::mutate(indexed_at = base::as.POSIXct(indexed_at))

#somar 1 ao objeto

# separando apenas coluna de dia e hora e contando ----
posts_por_dia_e_hora <-
  skeets |>
  dplyr::mutate(
    dia = base::as.Date(indexed_at),
    hora = lubridate::hour(indexed_at)
  ) |>
  dplyr::count(dia, hora)


# criando estrutura do mapa ----

mapa_calor <-
  ggplot2::ggplot(
    posts_por_dia_e_hora,
    ggplot2::aes(
      x = dia,
      y = hora,
      fill = n
    )
  ) +

  ggplot2::geom_tile() +

  ggplot2::scale_fill_viridis_c(
    option = "inferno",
    trans = "log10"
  ) +

  ggplot2::labs(
    title = "Mapa de calor de postagens por hora e dia",
    x = "Data",
    y = "Hora do dia"
  ) +

  ggplot2::theme_minimal() +

  ggplot2::theme(
    axis.text.x = ggplot2::element_text(
      angle = 45,
      hjust = 1
    )
  ) +

  ggplot2::geom_vline(
    xintercept = base::as.POSIXct(c("2024-08-30", "2024-10-08")),
    color = "red",
    linewidth = 0.9,
    linetype = "dashed"
  ) +

  ggplot2::scale_x_date(
    date_labels = "%d/%m/%Y",
    date_breaks = "7 days"
  ) +

  ggplot2::annotate(
    geom = "rect",
    xmin = base::as.Date("2024-09-06"),
    xmax = base::as.Date("2024-09-07") + 1,
    ymin = 13,
    ymax = 19,
    colour = "green",
    fill = scales::alpha("white", 0),
    linewidth = 1
  )


# exportando imagem ----
ggplot2::ggsave(
  filename = "img/mapa_de_calor3.png",
  plot = mapa_calor,
  width = 8,
  height = 3,
  dpi = 300
)
2
