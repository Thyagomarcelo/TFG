# Idades e coeficientes fornecidos
idade <- c(3, 4, 5, 6, 7, 8)
beta_0 <- c(3.5451, 1.9076, 8.6453, 10.7099, 11.2765, 3.3012)
beta_1 <- c(-0.0853, 0.2998, -0.1751, -0.5189, -0.3570, 0.1642)
beta_2 <- c(0.0330, 0.0124, 0.0181, 0.0288, 0.0200, 0.0187)

# Ajustar modelos de regressão para cada coeficiente
modelo_beta0 <- lm(beta_0 ~ idade)
modelo_beta1 <- lm(beta_1 ~ idade)
modelo_beta2 <- lm(beta_2 ~ idade)


# Previsão para idade de 1 ano
idade_nova <- data.frame(idade = 1)

# Previsão para cada coeficiente
beta0_previsto <- predict(modelo_beta0, idade_nova)
beta1_previsto <- predict(modelo_beta1, idade_nova)
beta2_previsto <- predict(modelo_beta2, idade_nova)

# Exibir resultados
cat("Coeficientes previstos para 1 ano:\n")
cat("Beta 0:", beta0_previsto, "\n")
cat("Beta 1:", beta1_previsto, "\n")
cat("Beta 2:", beta2_previsto, "\n")

# Gráfico para Beta 0
plot(idade, beta_0, main = "Beta 0 vs Idade", xlab = "Idade", ylab = "Beta 0")
abline(modelo_beta0, col = "red")

# Gráfico para Beta 1
plot(idade, beta_1, main = "Beta 1 vs Idade", xlab = "Idade", ylab = "Beta 1")
abline(modelo_beta1, col = "red")

# Gráfico para Beta 2
plot(idade, beta_2, main = "Beta 2 vs Idade", xlab = "Idade", ylab = "Beta 2")
abline(modelo_beta2, col = "red")