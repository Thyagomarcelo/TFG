library(readxl)
library(dplyr)

dados <- read_excel("D:/R_codes/LIDAR_teste/Data/InformacoesEucalipto.xlsx", sheet = "Sheet 1")


# Defina as fórmulas como funções
formula1 <- function(DAP, H) {
  exp(-5.95150 + 1.18123 * log(DAP^2 * H))
}

formula2 <- function(DAP, H) {
  exp(-4.54731 + 2.13859 * log(DAP) + 1.0236 * log(H))
}

formula3 <- function(DAP, H, p) {
  exp(-2.977 + log(p * DAP^2 * H))
}

# Suponha que p é um valor constante, por exemplo, p = 1
p <- 1

# Calcule o estoque de carbono para cada fórmula
dados$estoque_formula1 <- with(dados, formula1(DAP, H))
dados$estoque_formula2 <- with(dados, formula2(DAP, H))
dados$estoque_formula3 <- with(dados, formula3(DAP, H, p))

# Visualize os resultados
print(dados)