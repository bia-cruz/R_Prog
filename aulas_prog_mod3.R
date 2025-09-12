# estrutura IF ELSE (execução do código
# conforme seu valor lógico)

faltas <- 15
notas <- 20

if (notas >= 70 & faltas <= 15) {
  result <- 'Aprovado'
} else if (notas < 40) {
  result <- 'Reprovado por nota'
} else if (notas < 70 & faltas <= 15) {
  result <- 'Exame Final'
} else {
  result <- 'Reprovado por falta'
}
result


# exercício (saudação conforme horário)

horario <- 10

if (horario >= 6 & horario < 12) {
  saudacao <- 'Bom Dia'
} else if (horario >= 12 & horario < 18) {
  saudacao <- 'Boa Tarde'
} else if (horario >= 18 & horario < 23) {
  saudacao <- 'Boa Noite'
} else {
  stop('Não enviar mensagem!')
}
saudacao


# estrutura SWITCH parecido com o IF ELSE mas confere 
# mais clareza e é mais comum para testar um valor contra
#um conjunto de strings (tem condição final ou de escape)

animal <- 'cachorro'

som <- switch(animal, 
              'cachorro' = 'au au',
              'gato' = 'miau',
              'vaca' = 'muuu'
)

som


# exercício sobre tipos de média
tipo <- 'aritmetica'

x <- 1:10 

switch(tipo,
       'aritmetica' = {
         mean(x)
       },
       'harmonica' = {
         length(x)/sum(1/x)
       },
        'geometrica' = {
          prod(x)^(1/length(x))
        },
        {
          NA_real_
        })


# versões vetoriais de IF ELSE

#versão com IF ELSE
notas2 <- c('joao' = 50, 'ana' = 89,
            'mario' = 28)
ifelse(notas2 >= 70, 'Aprovado',
       ifelse(notas2 >= 40, 'Exame',
              'Reprovado'))

#versão com SWITCH VETORIAL
dplyr::case_when(notas2 >= 70 ~ 'Aprovado',
                 notas2 >= 40 ~ 'Exame',
                 TRUE ~ 'Reprovado')


# estrutura de loop FOR, executar instruções por um número
# previamente conhecido de vezes ou então por uma série conhecida
# de elementos

tx_juros <- 0.01
n_meses <- 12
rend <- numeric(n_meses)
rend[1] <- 100
for (i in 2:n_meses) {
  rend[i] <- rend[i - 1] *(1 + tx_juros)
}
rend

y <- c(3, 2, 2, 1, NA, 0, 4, 1)
s <- 0
for (i in y) {
  if (s > 10) break
  if (is.na(i)) next
  s <- s + i 
  print(s)
}
s

for (i in 1:10) {
  print(i^2)
}


# estrutura WHILE, usado quando precisa executar instruções por um 
# numero desconhecido de vezes (a condição é testada antes da execução)

n_numbers <- 12
total <- 0
i <- 1L
while (i <n_numbers) {
  u <- total + runif(1)
  if (sum(u) > 4) break
  total <- u
  i <- i + 1L
}
total


# estrutura REPEAT, usado quando precisa executar instruções por um 
# numero desconhecido de vezes ou até que uma condição seja atentida

total <- 0
i <- 1L

repeat {
  u <- total + runif(1)
  if (sum(u) > 4) break
  total <- u
  i <- i + 1L
}
total

# exercício sobre lançamentos de dados
# quantas tentativas são necessárias para conseguir uma sequencia
n_max <- 100
tentativas <- 1
while (tentativas < n_max) {
  l1 <- sample(1:6, 3, replace = TRUE) #joga os dados
  l1_ordenado <- sort(l1) #ordena o l1
  print(l1_ordenado)
  seque <- sum(ifelse(diff(l1_ordenado) == 1, TRUE, FALSE))
  if(seque == 2) break
  tentativas <- tentativas + 1
}
tentativas

# exercício - número médio de tentativas

output <- c()
for (i in 1:1000) {
  n_max <- 100
  tentativas <- 1
  while (tentativas < n_max) {
    l1 <- sample(1:6, 3, replace = TRUE) #joga os dados
    l1_ordenado <- sort(l1) #ordena o l1
    print(l1_ordenado)
    seque <- sum(ifelse(diff(l1_ordenado) == 1, TRUE, FALSE))
    if(seque == 2) break
    tentativas <- tentativas + 1
  }
  output[i] <- tentativas
}

mean(output)
hist(output)


# FUNÇÕES, encapsulam uma tarefa composta de várias instruções
# pegando valores de entrada e gerando uma saída
# permitem o reuso de código e preservam ele

imc <- function(peso, altura) {
  imc <- peso/altura^2
  limits <- c(0, 18.5, 25, 30, Inf)
  labels <- c('Magreza', 'Adequado', 
              'Pré-Obeso', 'Obesidade')
  classif <- labels[findInterval(imc, vec = limits)]
  return(list(IMC = imc, Classificação = classif))
}
imc(80, 1.90)

## Tratando exceções

calcula_imc <- function(altura, peso = 80) {
  if(altura < 0) stop("Altura deve ser maior do que zero.")
  if(peso < 0) stop("Peso deve ser maior do que zero.")
  imc <- peso/(altura^2)
  limits <- c(0, 18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, limits)]
  return(list(IMC = imc, Classificao = classif))
}

## Funções sem argumentos
calcula_imc <- function() {
  if(altura < 0) stop("Altura deve ser maior do que zero.")
  if(peso < 0) stop("Peso deve ser maior do que zero.")
  imc <- peso/(altura^2)
  limits <- c(0, 18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, limits)]
  return(list(IMC = imc, Classificao = classif))
}
peso <- 70
altura <- 1.70
calcula_imc()

## Uso dos ... (serve para os parametros, para não precisar repeti-los toda vez)

calcula_imc_numero <- function(peso, altura) {
  imc <- peso/(altura^2)
  return(imc)
}

calcula_imc <- function(...) {
  imc <- calcula_imc_numero(...)
  limits <- c(0, 18.5, 25, 30, Inf)
  labels <- c("Magreza", "Adequado", "Pré-obeso", "Obesidade")
  classif <- labels[findInterval(imc, limits)]
  return(list(IMC = imc, Classificao = classif))
}



# exercício - fórmula de báskara

baskara <- function(a, b, c) {
  delta <- b^2 - 4 * a * c
  x <- (-b + c(-1,1) * sqrt(delta))/(2 * a)
  return(x)
}

baskara(a = 1, b= 4, c= 1)
curve(x^2 + 4*x + 1, from = -2, to = 2)

# exercício - lançamento de dados (mas agr com função)

joga_dados <- function(n_dados, n_max, n_simulacao) {
  output <- c()
  for(i in 1:n_simulacao) {
    tentativas <- 1
    while(tentativas < n_max) {
      l1 <- sample(1:6, n_dados, replace = TRUE) # joga os dados
      l1_ordenado <- sort(l1) # ordenada
      seque <- sum(ifelse(diff(l1_ordenado) == 1, TRUE, FALSE))
      if(seque == c(n_dados-1)) break
      tentativas <- tentativas + 1
    } 
    output[i] <- tentativas
  }
  return(output)
}

jogadas <- joga_dados(n_dados = 5, n_max = 100, n_simulacao = 1000)
jogadas <- joga_dados(n_dados = 4, n_max = 100, n_simulacao = 1000)
mean(jogadas)


