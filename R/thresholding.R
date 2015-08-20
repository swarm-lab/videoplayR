thresholding <- function(image, threshold = 75) {
  flat <- image[, , 1] + image[, , 2] + image[, , 2]
  flat[flat < threshold] <- 0
  flat[flat >= threshold] <- 1
  flat
}