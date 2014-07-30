library(grid)

test <- readFrame(1000, "test/D4TC09.avi")

grid.raster(test / 255, interpolate = FALSE)
 