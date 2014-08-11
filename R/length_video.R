length_video <- function(video) {
  if (video$check) {
    video$length()
  } else {
    stop("This is not a Video object.")
  }
}