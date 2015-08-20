background_subtraction <- function(image, background) {
  if (!all.equal(dim(image), dim(background))) {
    stop("The video and the background image do not have the same dimensions.")
  }
  
  abs(image - background)
}