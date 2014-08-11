dim_video <- function(video) {
  if (video$check) {
    video$dim()
  } else {
    stop("This is not a Video object.")
  }
}