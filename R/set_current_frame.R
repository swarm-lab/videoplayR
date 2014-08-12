set_current_frame <- function(video, n) {
  if (video$check) {
    video$set_current_frame(n)
  } else {
    stop("This is not a Video object.")
  }
}