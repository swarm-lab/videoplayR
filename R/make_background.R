make_background <- function(video, n = 10, type = "mean", color = FALSE) {
  if (color) {
    make_background_col(video = video, n = n, type = type)
  } else {
    make_background_bw(video = video, n = n, type = type)
  }
}

make_background_col <- function(video, n = 10, type = "mean") {
  if (!video$check) {
    stop("This is not a Video object.")
  } 
  
  if (n > video$length()) {
    stop("n should be smaller than the total number of frames in the video.")
  }
  
  frames <- round(seq.int(1, video$length() - 1, length.out = n))
  
  if (type == "mean") {
    
    mat <- array(0, dim = c(video$dim(), 3))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      mat <- mat + video$get_frame(frames[i])
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing average image.")
    
    print("Done.")
    
    return(mat / n)
    
  } else if (type == "median") {
    
    mat <- array(0, dim = c(video$dim(), 3))
    mat.r <- array(NA, dim = c(video$dim(), n))
    mat.g <- array(NA, dim = c(video$dim(), n))
    mat.b <- array(NA, dim = c(video$dim(), n))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      mat <- video$get_frame(frames[i])
      mat.r[, , i] <- mat[, , 1]
      mat.g[, , i] <- mat[, , 2]
      mat.b[, , i] <- mat[, , 3]
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing median image. This is a slow process, please be patient.")
    
    print("   Median red:")
    mat[, , 1] <- pbapply::pbapply(mat.r, c(1, 2), median.default)
    
    print("   Median green:")
    mat[, , 2] <- pbapply::pbapply(mat.g, c(1, 2), median.default)
    
    print("   Median blue:")
    mat[, , 3] <- pbapply::pbapply(mat.b, c(1, 2), median.default)
    
    print("Done.")
    
    return(mat)
    
  } else {
    
    stop("'type' should be 'mean' or 'median'")
    
  }  
}

make_background_bw <- function(video, n = 10, type = "mean") {
  if (!video$check) {
    stop("This is not a Video object.")
  } 
  
  if (n > video$length()) {
    stop("n should be smaller than the total number of frames in the video.")
  }
  
  frames <- round(seq.int(1, video$length() - 1, length.out = n))
  
  if (type == "mean") {
    
    mat <- array(0, dim = video$dim())
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      mat <- mat + col2bw(video$get_frame(frames[i]))
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing average image.")
    
    print("Done.")
    
    return(mat / n)
    
  } else if (type == "median") {
    
    mat <- array(0, dim = video$dim())
    img <- array(NA, dim = c(video$dim(), n))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      img[, , i] <- col2bw(video$get_frame(frames[i]))
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing median image. This is a slow process, please be patient.")
    
    mat <- pbapply::pbapply(img, c(1, 2), median.default)
    
    print("Done.")
    
    return(mat)
    
  } else {
    
    stop("'type' should be 'mean' or 'median'")
    
  }  
}