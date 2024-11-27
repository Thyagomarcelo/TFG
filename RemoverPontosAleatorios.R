# Load packages
library(lidR)
library(sf)
library(terra)

las <- readLAS(files = "D:/R_codes/LIDAR_teste/Data/MixedEucaNat_normalized.laz", filter = "-set_withheld_flag 0")
col <- height.colors(50)
col1 <- pastel.colors(900)

# Definir a faixa de altura desejada
min_height <- 0
max_height <- 1100

# Aplicar o filtro de altura usando filter_poi
las_filtered <- filter_poi(las, Z >= min_height & Z <= max_height)

# Generate CHM
chm <- rasterize_canopy(las = las_filtered, res = 0.5, algorithm = p2r(0.15))
plot(chm, col = col)

# Generate kernel and smooth chm
kernel <- matrix(1, 3, 3)
schm <- terra::focal(x = chm, w = kernel, fun = median, na.rm = TRUE)
plot(schm, col = col)

# Detect trees
ttops <- locate_trees(las = schm, algorithm = lmf(ws = 2.5))
ttops


plot(chm, col = col)
plot(ttops, col = "black", add = TRUE, cex = 0.5)

plot(las)


# Segment trees using dalponte
las <- segment_trees(las = las_filtered, algorithm = dalponte2016(chm = schm, treetops = ttops))


# Visualize all trees
plot(las, color = "treeID")

# Segment using li
las <- segment_trees(las = las, algorithm = li2012())

plot(las, color = "treeID")
# This algorithm does not seem pertinent for this dataset.

# Generate metrics for each delineated crown
metrics <- crown_metrics(las = las, func = ~list(n = length(Z)))
metrics