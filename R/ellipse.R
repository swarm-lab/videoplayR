ellipse <- function(x, y) {
  N <- length(x)

  #' Calculate normalized second central moments for the region. 1/12 is the 
  #' normalized second central moment of a pixel with unit length.
  uxx <- sum(x ^ 2) / N + 1 / 12
  uyy <- sum(y ^ 2) / N + 1 / 12
  uxy <- sum(x * y) / N
  
  #' Calculate major axis length, minor axis length, and eccentricity.
  common <- sqrt((uxx - uyy) ^ 2 + 4 * uxy ^ 2)
  majorAxisLength <- 2 * sqrt(2) * sqrt(uxx + uyy + common)
  minorAxisLength <- 2 * sqrt(2) * sqrt(uxx + uyy - common)
  eccentricity <- 2 * sqrt((majorAxisLength / 2) ^ 2 - (minorAxisLength / 2) ^ 2) / majorAxisLength
  
  #' Calculate orientation.
  if (uyy > uxx) {
    num <- uyy - uxx + sqrt((uyy - uxx) ^ 2 + 4 * uxy ^ 2);
    den <- 2*uxy
  } else {
    num <- 2 * uxy;
    den <- uxx - uyy + sqrt((uxx - uyy) ^ 2 + 4 * uxy ^ 2);
  }
  
  if (num == 0 & den == 0) {
    orientation <- 0
  } else {
    orientation <- atan(num / den)
  } 
  
  data.frame(majorAxisLength = majorAxisLength,
             minorAxisLength = minorAxisLength,
             orientation = orientation,
             eccentricity = eccentricity)
}