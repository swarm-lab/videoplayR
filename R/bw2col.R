bw2col <- function(image) {
  if (length(dim(image)) != 2) {
    stop("This is not a a black and white image.")
  }
  
  bw <- array(0, dim = c(dim(image), 3))
  bw[, , 1] <- image
  bw[, , 2] <- image
  bw[, , 3] <- image
  
  bw
}