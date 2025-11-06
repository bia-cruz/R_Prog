

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

# simulação de utilização de lubridate
banco_de_dados %>%
  mutate(data = dmy(data)) %>%
  select(data) 

banco_de_dados %>%
  mutate(data = dmy(data)) %>%
  mutate(ano = year(data),
         mes = month(data),
         dia = day(data)) %>%
  select(data, ano, mes, dia)

# podemos também calcular a diferença entre duas datas
banco_de_dados %>%
  mutate(data = dmy(data)) %>%
  mutate(dias_desde_acidente = difftime(Sys.Date(), data, units = "days")) %>%
  select(data, dias_desde_acidente)

# podemos também subtrair ou somar dias de uma data
banco_de_dados %>%
  mutate(data = dmy(data)) %>%
  mutate(data_mais_10_dias = data + lubridate::days(10)) %>%
  select(data, data_mais_10_dias)

# podemos extrair hora, minuto, segundos...
data <- ymd_hms("2023-08-21 15:30:45")
ano <- year(data)
mes <- month(data)
dia <- day(data)
hora <- hour(data)
minuto <- minute(data)
segundos <- second(data)

# podemos converter o fuso horário
data_ny <- ymd_hms("2025-10-21 12:00:00", tz = "America/New_York")
data_london <- with_tz(data_ny, tz = "Europe/London")

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


# tidy data: variavel forma coluna e observação linha
## existe dois tipos: wide e long7
library(tidyverse)
table1 <- table1

# pivot: serve para trocar tabelas de wide pra long ou o contrário

# transformar dados long -> wide usando pivot_wider(), que utiliza os 
# seguintes argumentos: names_from, que éa coluna que contem os nomes
# das variaveis que sera transformadas em colunas; e values_from, que 
# é os valores que serão transformados em colunas
table1 %>%
  select(-population) %>%
  pivot_wider(names_from = year,
              values_from = cases)

# pivotando mais de uma variável
table1 %>%
  pivot_wider(names_from = year,
              values_from = c(cases, population))

# pivot_longer é utilizado para transformar de wide para long
# e utiliza os seguites argumentos: cols, que é as colunas que serão empilhadas;
# names_to, que é a coluna que conterá os nomes da variaveis empilhadas;
# values_to, que é a coluna que conterá os valores da variaveis empilhadas;
# values_fill, que é o valor que preencherá as cédulas vazias; 
# values_fn, que é a função que será aplicada aos valores empilhados

table1 %>%
  pivot_longer(cols = c(cases, population),
               names_to = "variable",
               values_to = "total")

# separate: serve para separar observações de uma coluna em duas
table3

#vamos separar a coluna rate em outras duas
table3 %>%
  separate(rate, into = c('cases', 'population'))

# unite: serve para juntar observações de diferentes colunas em uma só
# vamos fazer o processo inverso do separate
table1 %>%
  unite(rate, cases, population, sep = "/")


# exercicio 3: 
install.packages("nycflights13")
require(nycflights13)

flights %>%
  count(origin, dest) %>%
  pivot_wider(names_from = origin,
              values_from = n,
              values_fill = 0)

str_length() # retorna o comprimento da string
str_to_lower() # converte uma string para minúsculas
str_to_upper() # converte uma string para maiúsculas
str_sub() # extrai uma substring de uma string
str_replace() # substitui uma parte de uma string por outra
str_detect() # verifica se uma string contém um padrão especifico

library(stringr)
texto <- "Vai, Corinthians!"
str_length(texto)
str_to_lower(texto)
str_to_upper(texto)
str_sub(texto, 1,3)
str_replace(texto, "Vai,", "Aqui é")
str_detect(texto, "Corinthians")

# regex básico: serve para buscar padrões ou manipular strings
# . corresponde a qualquer caractere
# ^ inicio de string
# $ fim de string
# * zero ou mais ocorrencias do caractere anterior
# ? zero ou uma ocorrencia do caractere anterior
# [] conjunto de caracteres
# | operador "ou"

# exemplos do regex
str_detect("bisnaguinha", "b.s")
str_detect("bisnaguinha", "^b")
str_detect("bbisnaguinha", "b*i")
str_detect("bisnaguinha", "[nag]")

# concatenando tabelas
df1 <- tibble(
  r.a = c(256, 487, 965,
          125, 458, 874, 963),
  nome = c('joão', 'vanessa', 'tiago',
           'luana', 'gisele', 'pedro', 
           'andré'),
  curso = c('mat', 'mat', 'est', 'est', 
            'est', 'mat','est'),
  prova1 = c(80, 75, 95, 70, 45, 55, 30),
  prova2 = c(90, 75, 80, 85, 50, 75, NA),
  prova3 = c(80, 75, 75, 50, NA, 90, 30),
  faltas = c(4, 4, 0, 8, 16, 0, 20))
view(df1)

df_extra <- tibble(
 r.a = c(256, 965, 285, 125, 874, 321, 669, 967),
 nome = c('joao', 'tiago', 'tiago', 'luana', 
          'pedro', 'mia', 'luana', 'andré'),
 idade = c(18, 18, 22, 21, 19, 18, 19, 20),
 bolsista = c('S', 'N', 'N', 'S', 'N', 'N', 'S', 'N'))
view(df_extra)

# concatenação de linhas e colunas
# linhas:
bind_rows(df1[1:3, c(1, 3, 5)],
          df1[5:7, c(1, 3, 5, 4)],
          df1[4, c(1, 0, 5, 4)])

# colunas:
bind_cols(df1[, c(1:3)],
          df1[, c(6:7)])

# full_join = união
full_join(df1, df_extra,
          by = c('r.a' = 'r.a', 'nome'))

# inner_join = intersecção
inner_join(df1,
           df_extra,
           by = c('r.a' = 'r.a',
                  'nome'))
# todos que estão na 1a tabela
left_join(df1, df_extra,
          by = c('r.a' = 'r.a', 
                 'nome'))

# todos os que estão na 2a tabela
right_join(df1, df_extra,
           by = c('r.a' = 'r.a',
                  'nome'))

# os da 2a que não estão na 1a
anti_join(df1, df_extra,
          by = c('r.a' = 'r.a',
                 'nome'))

# para exportar dados (simulação)
## para arquivos de texto pleno
write.csv(df1,
          file = "nome_do_arquivo.csv")

## criando planilhas eletronicas
library(writexl)
write_xlsx(df1, "nome_do_arquivo.xlsx")

## arquivo binário do R
save(df1,
     file = "nome_do_arquivo.RData")
## para carregar o arquivo
load("nome_do_arquivo.RData")