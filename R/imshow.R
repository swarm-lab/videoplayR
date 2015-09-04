imshow <- function(image, rescale = TRUE) {
  img <- img2r(image)
  imgType <- image$type
  imgDims <- image$dim
  
  if (imgType == "numeric" & rescale == TRUE) {
    rg <- range(img)
    if (rg[1] != rg[2]) {
      img <- (img - rg[1]) / (rg[2] - rg[1])  
    } else {
      img[] <- 1
    }
  } else if (imgType == "rgb" | imgType == "grayscale") {
    img <- img / 255
  }
  
  op <- par(mar = rep(0, 4))
  plot(NA, xlim = c(1, imgDims[2]), ylim = c(1, imgDims[1]), asp = 1, xaxt = "n", 
       yaxt = "n", ann = FALSE, bty = "n", xaxs = "i", yaxs = "i")
  
  if (imgDims[3] == 3) {
    img <- img[imgDims[1]:1,,]
  } else {
    img <- img[imgDims[1]:1,]
  }
  
  rasterImage(img, xleft = 1, xright = imgDims[2], ybottom = 1, ytop = imgDims[1])
  par(op)
}
