install.packages("httr")
require("httr")
# get serve para fazer requisição
# post serve para enviar dados para API via http post
# put serve para atualizar recursos
# delete serve para remover recursos
# add_headers serve para adicionar cabeçalhos, como tokens
# content serve para extrair e interpretar conteúdo da resposta


install.packages("jsonlite")
require("jsonlite")
install.packages("dplyr")
require("dplyr")

# carregando banco de dados 'USArrests' para estudo de manipulação
dados <- USArrests
View(dados)
head(dados)


# indetação sem pipe (%>%)
x <- c(-2:2)
x
sort(cos(unique(x)), decreasing = TRUE)

# indentação utilizando pipe (%>%)
require(magrittr)
x %>%
  unique() %>%
  cos() %>%
  sort(decreasing = TRUE)

# atribuição com pipe
x <- 1:10
x %>% log()

# função MUTATE: serve para criar novas variáveis
# vamos utilizar para criar a variável "danger", se assault for maior que 200
dados <- dados %>%
  mutate(Danger = ifelse(Assault %in% 
                           c(200:1000),
                         "dangerous", "safe"))
         
View(dados)

# utilizando a função select
## seleção por indices das variaveis

dados3 <- dados %>%
  select(3:4)
glimpse(dados3)

## podemos também utilizar o : com os nomes das variaveis

dados4 <- dados %>%
  select(UrbanPop:danger)
glimpse(dados4)

## podemos utilizar "starts_with(), ends_with(), contains(), matches()" 
## para selecionar variaveis que atendam a um padrão

dados5 <- dados %>%
  select(starts_with("d"))
glimpse(dados5)

## podemos remover veriaveis com o -

dados6 <- dados %>%
  select(-Rape)
glimpse(dados6)

## podemos selecionar variaveis de um mesmo tipo/criterio especifico

dados7 <- dados %>%
  select_if(is.integer)
glimpse(dados7)

## podemos utilizar também o 'any_of() e all_of()'
variaveis <- c("Assault", "Danger", "Murder", "Country")
dados8 <- dados %>%
  select(all_of(variaveis))
glimpse(dados8)


dados9 <- dados %>%
  select(any_of(variaveis))
glimpse(dados9)


install.packages("carData", repos = "https://cran.rstudio.com/")
library(carData)

# filter: filtrar observações (==, !=, <, >, <=, >=)
## podemos combinar com (& e |)
dados10 <- dados %>%
  filter(Murder >= 10)

dados11 <- dados %>%
  filter(Murder >= 10 & Assault >= 200)

dados12 <- dados %>%
  filter(Danger %in% "safe")
View(dados12)

## para negação usamos %ni% <- negate(%in%)
## para buscar padrões utiliza %like% ou grepl

# arrange: utilizado para ordenar observações

## ordenando em ordem decrescente 
dados13 <- dados %>%
  arrange(desc(Murder))
View(dados13)

# slice: serve para fatiar linhas
dados14 <- dados %>%
  select(1:4) %>%
  slice(1:3)
  
dados_storms <- storms
View(dados_storms)

# exercicio 1
## letra a

dados_storms %>%
  filter(status == "tropical depression") %>%
  nrow()

## letra b

dados_storms %>%
  filter(status == "tropical depression" & wind >= 40) %>%
  nrow()

## letra c
dados_storms %>%
   select_if(is.numeric) %>%
   arrange(pressure)

# rename: serve para renoear colunas (variavéis)
## vamos renoar a variavél wind para velocidade_wind

rename_storm <- storms %>%
  rename(velocidade_wind = wind)

View(rename_storm) 

# relocate: serve para realocar colunas (variavéis)
## vamos realocar a variavel wind para a oitava posição
relocate_storms <- storms %>%
  relocate(wind, .after = 7)

View(relocate_storms)

# transmute: serve para transformar dados
## vamos criar uma nova variavel chamada wind_10 que é a velocidade do vento
## dividida por 10
 
transmute_storms <- storms %>%
  transmute(wind_10 = wind / 10)

View(transmute_storms)

# replace_NA: serve para alterar valores na
replace_storms <- storms %>%
  mutate(category = replace_na(category, 0))

# cut: serve para classificar dados
## vamos classificar a variável wind em 3 categorias: weak, medium and strong
cut_storms <- storms %>%
  mutate(wind_cat = cut(wind,
                        breaks = c(-Inf, 50, 120, Inf),
                        labels = c("fraco", "médio", "forte"))) %>%
  relocate(wind_cat, .after = wind)


View(cut_storms)

# summarise: serve para sumarizar dados
## vamos representar como seria sumarizar o número total de algo 
## é possível summarizar mais de uma variavel por vez (fazer media tb)

nome_variavel <- nome_bancodedados %>%
  summarise(nome_do_que_esta_somando = sum(variavel_que_quer_somar, na.rm = TRUE))


# group_by: serve para agrupar dados 
## vamos agrupar o banco de dados storms pela variavel ano (year)

## se já não estivesse já separado poderiamos usar o lubridate, com a função
## dmy(), transformando string em data e ai a função year para extrair o ano 
group_storms <- storms %>%
  group_by(year)

glimpse(group_storms)
View(group_storms)


# exercicio 2: utilizando o banco de dados starwars
## letra a:
star <- starwars
View(star)
star %>%
  summarise(n_especies = n_distinct(species))

## letra a (segunda parte):
star %>%
  group_by(species) %>%
  summarise(freq_especies = n()) %>%
  arrange(desc(freq_especies))

## letra b:
star %>%
  filter(sex %in% c("female", "male")) %>%
  group_by(sex) %>%
  summarise(media_altura = mean(height, na.rm = TRUE))

## letra c:
star %>%
  filter(sex == "male") %>%
  group_by(species) %>%
  summarise(media_peso = mean(mass, na.rm = TRUE))

## letra d:
star %>%
  group_by(species) %>%
  filter(mass == max(mass, na.rm = TRUE)) %>%
  select(species, name, mass)
