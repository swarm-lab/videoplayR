current_frame <- function(video) {
  if (video$check) {
    video$current_frame()
  } else {
    stop("This is not a Video object.")
  }
}