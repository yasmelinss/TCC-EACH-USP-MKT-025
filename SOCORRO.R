library(dplyr)
library(lubridate)
library(ggplot2)



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

#gráfico de densidade POR DIA E HORA
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

ggplot(posts_por_dia_e_hora, aes(x = dia, y = hora, fill = n)) +
  geom_tile() +
  scale_fill_viridis_c(option = "magma") +
  labs(
    title = "Mapa de calor de postagens por hora e dia",
    x = "Hora do dia",
    y = "Data"
  ) +
  theme_minimal()

#Including or excluding observations with the filter function
install.packages("Hmisc")
library(Hmisc)

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
