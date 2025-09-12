# função para instalar o seguinte pacote
install.packages("tidyverse")
library("tidyverse")

# para criar essa seta basta (alt + -)
# <- 
  
(7 == 9) & (9 <= 8) # operador E
(7 == 7) | (9 <= 8) # operador OU
!(9 <= 8) # operador NÃO

# criando um vetor numerico (pode ser de outro tipo, mas dentro de um 
# vetor precisa ser td do msm tipo)
vetor_numerico <- c(9, 10, 20, 32)

# vetor de caracteres
vetor_caracter <- c('bianca', 'maria', 'flavia', 'marcos')

# vetor logico
vetor_logico <- c(TRUE, TRUE, FALSE)


# combinando os vetores criados acima (transforma no mais generico
# entre os valores possiveis)
vetor_combinado <- c(vetor_caracter,
                     vetor_numerico,
                     vetor_logico,
                     'boo')

# saber o tipo ou a classe de um objeto
typeof(vetor_logico)
class(vetor_numerico)

# conversão de classe de um objeto
x <- 10
typeof(x)
x <- as.logical(x)
typeof(x)

# criando objeto com atributo (um vetor numerico mas com
# atributo caracter)
notas <- c('maria' = 9.9,
           'bianca' = 10,
           'jao' = 8.9)

# me devolve o nome dos atributos
names(notas)

# para saber o tamanho do vetor 
length(notas)

# cria uma sequencia de from ate to, e o by me indica de quantos em quantos
seq(from = 2, to = 20,, by = 2)

#  cria uma sequencia de from ate to, e o length.ou
# me indica quantos numeros eu quero
seq(from = 2, to = 20, length.out = 5)

#  cria uma sequencia de from, by para de quantos em quantos
# e o length.ou para quantos numeros eu quero
seq(from = 2, by = 2, length.out = 5)

# repete o numero quantas vezes eu quero
rep(9, 6)

# repete a sequencia quantas vezes eu quero
rep(2:5, times = 3)

# repete a sequencia, mas cada numero repetidas vezes
rep(2:5, each = 3)

# gera valores aleatorios dentro da sequencia estabelecida,
# de tamanho tb estabelecido e com ou sem reposição
sample(1:20, size = 10, replace = FALSE)
sample(c('c', 'n', 'm'), size = 10, replace = TRUE)

#selecionar elementos dentro de um vetor
notas_novo <- c('Bianca' = 10,
                'Maria' = 9.9,
                'André' = 7.9,
                'Alanis' = 8)
notas_novo[1:3] # um intervalo
notas_novo[2] # uma posição
notas_novo[c(2,4)] # um conjunto
notas_novo[-3] # para remover

# seleção com mascara logica
mask <- notas_novo > 9
notas_novo[mask]

# modificar ou adicionando novos objetos nosvetores
notas['Alanis'] <- 9 # adicionando
notas_novo['Alanis'] <- 9 # modificando
notas_novo['Julia'] <- NA # adicionando desconhecido

# adicionando novos componentes
append(notas_novo, value = c('Pedro' = 3.9))
# add after se quiser que adicione em um lugar especifico
append(notas_novo, value = c('Pedro' = 3.9),
       after = 2)

# os elementos de uma matriz precisa serem do msm tipo
# criando uma matriz
matriz <- matrix(data = c(1, 8, 19, 32, 45, 20),
                 nrow = 3, ncol = 2)

# acessar elementos da matriz (precisa indicar linha e coluna, 
# respectivamente)
matriz[1, 2]


# seleção por mascara logica
matriz[matriz >= 20]

# criando lista (mais flexivel e pode ter diferentes tipos juntos)
minha_lista <- list(10, 'dez', TRUE, 20)

#acessando elementos da lista
minha_lista[[1]]
minha_lista[c(1,4)]

# posso nomear cada 'gaveta' da lista
lista_nomeada <- list('numeros' = c(21, 30, 4),
                      'caracter' = c('dez', 'vinte'),
                      'logico' = TRUE,
                      'complexo' = 1+10i)

# posso acessar pelo nome da 'gaveta'
lista_nomeada$complexo

# me da um resump da dataframe (tabela)
str(iris)

# factor estabalece uma ordem 
fator <- factor(c('alta', 'baixa', 'media', 'alta', 'media'),
                levels = c('baixa', 'media', 'alta'),
                ordered = TRUE)

# cria uma tabela com os dados acima
table(fator)

# criando um data.frame
dados <- data.frame(Letras = letters[1:6],
                    Numeros = 1:6,
                    Logico =  rep(c(TRUE, FALSE),
                                  each = 3 ))

# para acessar elementos do dataframe basta usar [], o primeiro 
# elemento referente a linha e o segundo a coluna, ou pelo nome
# com $nomedacoluna
dados$Letras
dados$Numeros

# dados referentes ao dataframe
head(dados)
tail(dados)
dim(dados)
nrow(dados)
ncol(dados)
names(dados)
colnames(dados)
rownames(dados)
