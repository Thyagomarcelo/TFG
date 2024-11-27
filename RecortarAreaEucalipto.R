# Instalação do pacote lidR, caso ainda não esteja instalado
if (!requireNamespace("lidR", quietly = TRUE)) {
  install.packages("lidR")
}

# Carregar o pacote lidR
library(lidR)

# Defina o caminho para o arquivo LIDAR
lidar_file <- "D:/CONGONHAS/NUVEM DE PONTOS/CNG_L10_C12.las"

# Leia o arquivo LIDAR
lidar_data <- readLAS(lidar_file)

# Defina as coordenadas do polígono para recorte
coords <- matrix(c(616864.7, 7732462.1,
                   616934.1, 7732508.1,
                   616934.1 ,7732368.0,
                   616864.7, 7732339.0), 
                 ncol = 2, byrow = TRUE)

# Crie um objeto SpatialPolygons para definir a área de recorte
library(sp)
polygon <- SpatialPolygons(list(Polygons(list(Polygon(coords)), "1")))

# Recorte o dado LIDAR usando a área definida
lidar_cropped <- clip_roi(lidar_data, polygon)

# Verifique se o recorte foi bem-sucedido
if (is.empty(lidar_cropped)) {
  stop("Nenhum dado LIDAR encontrado na área especificada")
}

# Salve o dado LIDAR recortado em um novo arquivo
writeLAS(lidar_cropped, "D:/CONGONHAS/AreaEucaliptoCongonhas.las")

# Imprima uma mensagem de sucesso
cat("O dado LIDAR foi recortado e salvo com sucesso.")

plot(lidar_cropped)

# Segmentar árvores
las <- segment_trees(las = lidar_cropped, algorithm = li2012())

# Calcular a altura das árvores segmentadas
tree_heights <- tree_metrics(las, ~max(Z), attribute = "treeID")

# Exibir as alturas das árvores
print(tree_heights)

metrics <- crown_metrics(las = las, func = ~list(n = length(Z)))
metrics

# Supondo que 'metrics' seja um data frame
write.csv(metrics, file = "D:/R_codes/LIDAR_teste/Data/crown_metrics.csv", row.names = FALSE)