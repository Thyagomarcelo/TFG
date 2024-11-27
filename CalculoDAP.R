# Load packages
library(lidR)
library(openxlsx)

las <- readLAS(files = "D:/R_codes/LIDAR_teste/Data/MixedEucaNat_normalized.laz", filter = "-set_withheld_flag 0")

# Segmentar árvores
las <- segment_trees(las = las, algorithm = li2012())

# Calcular a altura das árvores segmentadas
tree_heights <- tree_metrics(las, ~max(Z), attribute = "treeID")

tree_heights

# Converter o resultado em data.frame
tree_heights_df <- as.data.frame(tree_heights)

tree_heights_df$Altura <- tree_heights_df$V1

# Adicionar colunas para calcular o DAP com as diferentes fórmulas
tree_heights_df$DAP_parabolico <- 127.2 - 7.88 * tree_heights_df$Altura + 0.141 * tree_heights_df$Altura^2
tree_heights_df$DAP_linha_reta <- -15.7 + 1.118 * tree_heights_df$Altura
tree_heights_df$DAP_stofel <- exp(-3.1179 + 1.7646 * log(tree_heights_df$Altura))
tree_heights_df$DAP_curtis <- 142.2 - 423 * (1 / log(tree_heights_df$Altura))

tree_heights_df$DAP_parabolico_CoefPrev <- 2.841892 - 0.02509714 * tree_heights_df$Altura + 0.02671905 * tree_heights_df$Altura^2

tree_heights_df$DAP_parabolico_Teste3Anos <- 3.5451 - 0.0853  * tree_heights_df$Altura + 0.0330 * tree_heights_df$Altura^2

p <- 0.771

tree_heights_df$Carbono1_DAP_parabolico <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_parabolico^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_parabolico <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_parabolico) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_parabolico <- exp(-2.977 + log(p * tree_heights_df$DAP_parabolico^2 * tree_heights_df$Altura))

tree_heights_df$Carbono1_DAP_linha_reta <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_linha_reta^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_linha_reta <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_linha_reta) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_linha_reta <- exp(-2.977 + log(p * tree_heights_df$DAP_linha_reta^2 * tree_heights_df$Altura))

tree_heights_df$Carbono1_DAP_stofel <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_stofel^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_stofel <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_stofel) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_stofel <- exp(-2.977 + log(p * tree_heights_df$DAP_stofel^2 * tree_heights_df$Altura))

tree_heights_df$Carbono1_DAP_curtis <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_curtis^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_curtis <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_curtis) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_curtis <- exp(-2.977 + log(p * tree_heights_df$DAP_curtis^2 * tree_heights_df$Altura))

tree_heights_df$Carbono1_DAP_parabolico_CoefPrev <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_parabolico_CoefPrev^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_parabolico_CoefPrev <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_parabolico_CoefPrev) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_parabolico_CoefPrev <- exp(-2.977 + log(p * tree_heights_df$DAP_parabolico_CoefPrev^2 * tree_heights_df$Altura))

tree_heights_df$Carbono1_DAP_parabolico_Teste3Anos <- exp(-5.95150 + 1.18123 * log(tree_heights_df$DAP_parabolico_Teste3Anos^2 * tree_heights_df$Altura))
tree_heights_df$Carbono2_DAP_parabolico_Teste3Anos <- exp(-4.54731 + 2.13859 * log(tree_heights_df$DAP_parabolico_Teste3Anos) + 1.0236 * log(tree_heights_df$Altura))
tree_heights_df$Carbono3_DAP_parabolico_Teste3Anos <- exp(-2.977 + log(p * tree_heights_df$DAP_parabolico_Teste3Anos^2 * tree_heights_df$Altura))


# Salvar as alturas e os DAPs das árvores em um arquivo XLSX
write.xlsx(tree_heights_df, "D:/R_codes/LIDAR_teste/data/InformacoesEucalipto22.xlsx", rowNames = FALSE)