fps <- function(video) {
  if (video$check) {
    video$fps()
  } else {
    stop("This is not a Video object.")
  }
}