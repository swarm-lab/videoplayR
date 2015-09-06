# ------
#' Display vpImage object
#' 
#' This function opens a graphics device and display the image contained in a 
#' vpImage object. 
#'
#' @param image A vpImage object to display. 
#' 
#' @return This function does not return anything.
#' 
#' @details \code{imshow} opens a regular graphics device, meaning that it is 
#' possible to overlay lines and points over the image, like with any regular
#' plot. The bottom left corner of the image is set at \{1,1\}.
#' 
#' If the type of the vpImage object is "numeric", then its values are rescaled
#' between 0 and 1, with 0 representing the minimum value of the original image
#' and 1 representing its maximum. 
#' 
#' @seealso \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
imshow <- function(image) {
  img <- img2r(image)
  imgType <- image$type
  imgDims <- image$dim
  
  if (imgType == "numeric") {
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
  
  rasterImage(img, xleft = 1, xright = imgDims[2], ybottom = 1, ytop = imgDims[1])
  par(op)
}
