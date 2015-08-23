thresholding <- function(image, threshold = 75) {
  if (length(dim(image)) == 3) {
    image <- col2gray(image)
  }
  
  image >= threshold
}