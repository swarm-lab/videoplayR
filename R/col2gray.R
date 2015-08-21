col2gray <- function(image, r = 1, g = 1, b = 1) {
  if (length(dim(image)) != 3 & dim(image)[3] != 3) {
    stop("This is not a color image.")
  }
  
  if (r + g + b != 3) {
    s <- r + g + b
    r <- 3 * r / s
    g <- 3 * g / s
    b <- 3 * b / s
  }
  
  round((image[, , 1] * r + image[, , 2] * g + image[, , 3] * b) / 3)
}