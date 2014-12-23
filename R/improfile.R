improfile <- function(img, start, end) {
  br <- bresenham_line(start[1], start[2], 0, end[1], end[2], 0, 1)
  
  if (length(dim(img)) == 2) {
    data.frame(x = br[, 1], y = br[, 2], 
               i = unlist(apply(br, 1, function(x, mat) {mat[x[2], x[1]]}, mat = img)))
  } else {
    data.frame(x = br[, 1], y = br[, 2], 
               ir = unlist(apply(br, 1, function(x, mat) {mat[x[2], x[1]]}, mat = img[,,1])),
               ig = unlist(apply(br, 1, function(x, mat) {mat[x[2], x[1]]}, mat = img[,,2])),
               ib = unlist(apply(br, 1, function(x, mat) {mat[x[2], x[1]]}, mat = img[,,3])))
  }
}