col2gray <- function(image, r = 1, g = 1, b = 1) {
  if (length(dim(image)) != 3 & dim(image)[3] != 3) {
    stop("This is not a color image.")
  }
  
  s <- r + g + b
  
  image[, , 1] * r / s + image[, , 2] * g / s + image[, , 3] * b / s
}