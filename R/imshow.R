imshow <- function(img) {
  dims <- dim(img)
  op <- par(mar = rep(0, 4))
  plot(NA, xlim = c(1, dims[2]), ylim = c(1, dims[1]), asp = 1, xaxt = "n", 
       yaxt = "n", ann = FALSE, bty = "n", xaxs = "i", yaxs = "i")
  rasterImage(img[dims[1]:1, ] / 255, xleft = 1, xright = dims[2], ybottom = 1, ytop = dims[1])
  par(op)
}