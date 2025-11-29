library(igraph)
library(dplyr)
library(readr)
library(tidygraph)
library(ggraph)
library(dplyr)
library(ggrepel)

#leia se não tiver lido
#vetor.matrizes.dias.likes <-
#  list.files(
#    path = "Dados/matrizes-dia",
#    pattern = "\\.rds$",
#    full.names = TRUE
#  )

#quem deu like + quem recebeu like + quantos(peso)
# actor.influencer.num
# actor.influenced.num
# quantos
dia85.edges <-
  readRDS(vetor.matrizes.dias.likes[[85]])

# Carregar matriz de likes (arestas direcionadas)
#actor.influenced.num,
#handle.x,
#arestas.influenced,
#actor.influencer.num,
#handle.y,
#arestas.influencer,
#saldo.arestas,
#spread.arestas


dia.85.nodes <-
  readRDS("Dados/matrizes-likes-dia-in-out-degree/dia85.rds")

g85 <- tbl_graph(nodes = dia.85.nodes,
                edges = dia85.edges,
                directed = TRUE)

ggraph(g85, layout = "fr") +
  geom_edge_fan(aes(width = weight),
                alpha = 0.4, show.legend = FALSE) +
  geom_node_point(aes(size = saldo.arestas,
                      color = saldo.arestas)) +
  geom_node_text(aes(label = label),
                 repel = TRUE, size = 3) +
  scale_size_continuous(range = c(4,12)) +
  theme_void() +
  labs(title = "Grafo de Likes — Dia 85")

