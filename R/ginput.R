ginput <- function(n, m, video) {
  if (video$check) {
    mat <- video$ginput(n, m)
    data.frame(x = mat[, 1], y = mat[, 2])
  } else {
    stop("This is not a Video object.")
  }
}