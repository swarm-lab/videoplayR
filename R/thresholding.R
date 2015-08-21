thresholding <- function(image, threshold = 75) {
  if (length(dim(image)) == 3) {
    image <- col2gray(image)
  }
  image[image < threshold] <- 0
  image[image >= threshold] <- 1
  image
}