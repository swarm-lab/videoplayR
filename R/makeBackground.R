makeBackground <- function(source, n = 10, type = "mean") {
  n.frames <- countFrames(source)
  frames <- seq(1, n.frames, length.out = n)
  
  if (type == "mean") {
    
    mat <- array(0, dim = c(videoDim(source), 3))
    
    for (i in 1:length(frames)) {
      mat <- mat + readFrame(frames[i], source)
    }
    
    return(mat / n)
    
  } else if (type == "median") {
    
    mat <- array(0, dim = c(videoDim(source), 3))
    mat.r <- array(NA, dim = c(videoDim(source), n))
    mat.g <- array(NA, dim = c(videoDim(source), n))
    mat.b <- array(NA, dim = c(videoDim(source), n))
    
    for (i in 1:length(frames)) {
      mat <- readFrame(frames[i], source)
      mat.r[, , i] <- mat[, , 1]
      mat.g[, , i] <- mat[, , 2]
      mat.b[, , i] <- mat[, , 3]
    }
    
    mat[, , 1] <- apply(mat.r, c(1, 2), median)
    mat[, , 2] <- apply(mat.g, c(1, 2), median)
    mat[, , 3] <- apply(mat.b, c(1, 2), median)
    
    return(mat)
    
  } else {
    
    stop("'type' should be 'mean' or 'median'")
    
  }  
}

test <- makeBackground("/Users/simongarnier/Desktop/D4TC09.avi", type = "median")
grid.raster(test / 255, interpolate = FALSE)

truc <- apply(test, c(1, 2), median)
