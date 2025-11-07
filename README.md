# TCC-EACH-USP-MKT-025

Repositório criado para hospedar o Trabalho de Conclusão de Curso de Yasmin e Thales, graduandos em Marketing na USP

Professor orientador: Marcelo Ventura

# TO-DO List

Sprint da semana:

- [/] Criar novo arquivo "extracao.qmd"
  - [ ] pra cada post, extrair 10 replies e 10 reposts
  - [ ] manuseio dos dados 
    - [ ] ids, handles (usuario, postagem, like, repost, reply)
    - [ ] ligar pro lelão para explicar como fazer os dataframes de relacionamento
  - [ ] montar os respectivos grafos
    - [ ] usuarios que se seguem
    - [ ] usuarios que são seguidos
    - [ ] usuarios + numero de replies que cada usuario deu (proximidade maior quanto mais replies)
    - [ ] usuarios + numero de reposts que cada usuario deu (proximidade maior quanto mais reposts)
    - [ ] usuarios + numero de interações (replies + reposts + likes) que cada usuario deu
  - [/] fazer gráfico dos grafos acima
  - Yas
- [/] Código de como fazer
  - [ ] análise de frequência e exploratória: contagem de palavras, bigramas, visualização
  - [ ] análise de conectividade: análise de índices de conexão, de centralidade
  - Yas
- [/] Justificativa
  - Thales
- [ ] aprimorar redação 
  - [ ] Metodologia
  - Thales


Backlog:

- [ ] Terminar as revisões com base no feedback do orientador
  - [ ] Pacote atrrr
- [ ] Manuseio de dados
  - [ ] Descobrir como conectar perfis
  - [ ] Descobrir como conectar postagens
  - [ ] Descobrir como plotar uma rede e conectar as pessoas
  - Yas
- [/] Metodologia -- ler artigos e escrever dentro dos tópicos
  - [-] análise de sentimentos (???)
  - Thales
- [ ] Mandar e-mail para Pesquisa Games Brasil (talvez mais pra frente)
  - Thales



Concluído:

- [X] Realçar quais seções precisam de revisão
  - Thales
  - concluido em 21/10
- [X] Reescrever e incluir as referências da Jane
  - [X] Problema de Pesquisa
  - [X] Influenciadores Digitais
  - [X] Marketing de Redes Sociais
  - [X] Indústria de E-sports
  - [X] Indústria de Games
  - [X] Metodologia
  - Thales
  - concluido em 21/10
- [X] Metodologia -- ler artigos e escrever dentro dos tópicos
  - [X] análise de frequência e exploratória: contagem de palavras, bigramas, visualização
  - Thales
  - concluído 24/10
- [/] Criar novo arquivo "extracao.qmd"
  - [X] replicar as 4 vignettes do pacote `{atrrr}`, exceto as partes redundantes, com os dados do LOL
  - [X] extrair 10 usuários
  - [X] para cada um dos 10 usuarios acima, extrair 10 seguidores
  - [X] para cada um dos 10 usuarios acima, extrair 10 seguindo
  - [X] pra cada usuário acima extrair 10 posts
  - Yas
  - concluído em 30/10
- [x] Dar uma ajeitada geral no código do arquivo teste-raspagem-3.qmd
  - [x] Arrumar prints para JSON
  - Yas
  - concluido em 21/10
- [x] Extrair dados 
  - [x] de perfis 
  - [x] de postagens
  - [x] de replies
  - [x] de likes
  - [x] de seguindo
  - [x] de seguidores
  - Yas
  - concluído em 21/10
- [X] Trocar todas as funções do {bskyr} pelo {atrrr}
  - Yas
  - concluído em 21/10
- [/] Terminar as revisões com base no feedback do orientador
  - [/] Indústria de Games
  - [X] Pacote {bskyr} do R
  - Thales
  - concluído em 14/10
- [X] Fundamentação teórica - Buscar Jane
  - Thales
  - concluído em 14/10
- [X] Dar uma ajeitada geral no código do arquivo teste-raspagem-2.qmd
  - [X] Arrumar prints para JSON
  - [X] Arrumar labels dos chunks (tirar eval true)
  - [X] Filtragem de variaveis (sem gpt)
  - [X] Verificar novamente likes, reply e comments de outras contas a partir da postagem
  - Yas
  - concluído em 14/10
- [X] Criar uma nova conta no BLSKY para teste
  - Yas
  - concluído em 14/10
- [X] Estudar o pacote atrrr
  - Yas
  - concluído em 14/10
- [X] Analisar e documentar o output de cada seção
  - [X] Seção SETUP
  - [X] Seção CONVERSÃO
  - [X] Seção PERFIL
  - [X] Seção POSTS
  - [X] Seção CURTIDAS
  - [X] Seção COMENTÁRIOS
  - Yas
  - concluído em 14/10
- [X] Revisão Bibliográfica 
  - [X] Ambiente computacional estatístico R
  - Thales
  - concluído 07/10
- [/] Analisar e documentar o output de cada seção
  - [X] Seção USUÁRIO
  - [X] Eliminar as que não vai usar
  - concluído em 30/09
  - Yas
- [/] Terminar as revisões com base no feedback do orientador
  - [X] Indústria E-sports e League of Legends
  - [X] Justificativa
  - concluído em 30/09
  - Thales
- [/] Metodologia -- ler artigos e escrever dentro dos tópicos
  - [X] análise de conectividade: análise de índices de conexão, de centralidade
  - concluído em 30/09
  - [X] raspagem de dados: obtenção automatizada de mensagens
  - [X] pré-processamento de texto: tokenização, remoção de stopwords, normalização
  - concluído em 23/09
  - Thales
- [X] Elaborar um novo documento de teste de raspagem
  - [X] passar o que já foi feito pro novo documento de forma consolidada
  - [X] extrair os replies individuais, os forward individuais, comentários etc.
  - [X] extrair lista de seguindo e seguidores por perfil/user
  - concluído em 30/09
  - Yas
- [X] Extrair uma postagem específica e comparar os dados retornados pela função com os dados presentes no bluesky 
  - [X] ver se falta alguma informação que a função não retorna ou retorna truncada. 
  - [-] se sim, descobrir como corrigir isso para trazer a informação completa
  - concluído em 23/09
  - Yas
- [X] arrumar o markdown do `teste-raspagem.qmd`
  - [X] separar os chunks
  - [X] botar os comentários, os `cat()` e os `print()` como texto em markdown  fora dos chunks
  - [X] botar nomes descritivos para as seções
  - Yas
  - concluído em 23/09
- [X] colocar os tópicos concluídos de mais recente para mais antigo
  - Thales
  - concluído em 23/09
- [x] Revisar todo o teste-raspagem.qmd
  - [x] indentar o código
  - [x] colocar json onde precisa
  - [x] passar o comentário de dentro pra fora
  - [x] corrigir os unnamed chunks
  - [x] corrigir os markdowns ao longo do texto
  - Yas
  - concluído em 12/09
- [X] Verificar se não estamos esquecendo de incluir alguma etapa
    - Yas e Thales
    - concluído em 10/09
- [X] Revisão Bibliográfica - ciência de dados - ler artigos   
    - Thales
    - concluído em 10/09
- [X] Testar outras funções da biblioteca e documentar os outputs
    - Yas
    - concluído em 10/09
- [X] Refinar e mudar de local o output (raspagem.qmd)
    - Yas
    - concluído em 10/09
- [X] Problema de Pesquisa - refinar e definir objetivos
    - Thales
    - concluído em 10/09
- [X] Teste de seguidores em comum e documentação
    - Yas e Thales
    - concluído em 09/09
- [X] Descrever propriamente problema de pesquisa
    - Thales 
    - concluído em 01/09
- [x] Ler, interpretar e documentar a estrutura de raspagem
    - Yas
    - concluído em 01/09
- [x] Escrever a respeito do bskyr em Metodologia
    - Yas
- [X] Call com a Branca
    - concluído em 21/06/2025
- [X] Teste de raspagem de dados no BlueSky
    - concluído em 15/08/2025
- [X] Definição do novo tema
    - concluído em 18/06/2025
- [X] Criação do repositório e familiarização com Git/GitHub
    - concluído em 18/06/2025





# Links Úteis
[Comandos em Markdown](https://docs.pipz.com/central-de-ajuda/learning-center/guia-basico-de-markdown#open)

# Contagem Regressiva
[contagem](https://yasmelinss.github.io/contagem_regressiva/)
