library(lidR)
library(openxlsx)

las <- readLAS(files = "D:/CONGONHAS/NUVEM DE PONTOS 3/CNG_L9_C12.las")

# Detectar árvores
ttops <- locate_trees(las = las, algorithm = lmf(ws = 3, hmin = 5))

# Visualize
plot(las)

add_treetops3d(x = x, ttops = ttops, radius = 0.5)

# Segmentar árvores
las <- segment_trees(las = las, algorithm = li2012())

# Calcular a altura das árvores segmentadas
tree_heights <- tree_metrics(las, ~max(Z), attribute = "treeID")

# Exibir as alturas das árvores
print(tree_heights)

# Converter o resultado em data.frame para facilitar a escrita no Excel
tree_heights_df <- as.data.frame(tree_heights)

# Salvar as alturas das árvores em um arquivo XLSX
write.xlsx(tree_heights_df, "D:/R_codes/LIDAR_teste/data/teste2.xlsx", rowNames = FALSE)

# Imprima uma mensagem de sucesso
cat("As alturas das árvores foram calculadas e salvas com sucesso.")

