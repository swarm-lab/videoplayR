get_frame <- function(n, video) {
  if (video$check) {
    video$get_frame(n)
  } else {
    stop("This is not a Video object.")
  }
}