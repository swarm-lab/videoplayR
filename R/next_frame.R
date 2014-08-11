next_frame <- function(video) {
  if (video$check) {
    video$next_frame()
  } else {
    stop("This is not a Video object.")
  }
}