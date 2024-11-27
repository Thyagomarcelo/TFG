library(lidR)

file_list <- list.files(path = "D:/CONGONHAS/NUVEM DE PONTOS", pattern = "\\.las$", full.names = TRUE)
las_data <- do.call(rbind, lapply(file_list, readLAS))

plot(las, color = "Classification")

# Generate a DTM using the TIN (Triangulated Irregular Network) algorithm
dtm_tin <- rasterize_terrain(las = las, res = 1, algorithm = tin())

# Normalize the LiDAR data using DTM-based normalization
nlas_dtm <- normalize_height(las = las, algorithm = dtm_tin)


tall_trees <- filter_poi(nlas_dtm, Z > 20)

# Criar um modelo digital de terreno usando o algoritmo knnidw
dtm <- grid_terrain(nlas_dtm, res = 1, algorithm = knnidw())

# Calcular a métrica de altura máxima por célula da grade
metrics <- grid_metrics(nlas_dtm, ~max(Z), res = 1)

# Filtrar células com altura máxima superior a 20 metros
areas_with_tall_trees <- metrics[metrics$V1 > 20, ]


print(areas_with_tall_trees)