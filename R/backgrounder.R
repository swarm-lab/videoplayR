# ------
#' Generate a background image from a video
#' 
#' This function computes the background image of a video. It tries to determine
#' the background value of each pixel by approximating its central value, either 
#' as the mean or as the median of a given number n of images spread throughout 
#' the video. 
#'
#' @param video A vpVideo object from which a background image need to be 
#' computed.
#' @param n The number of images to extract from the video in order to compute 
#' the background image. The images are taken at evenly spaced intervals 
#' throughout the video. The default is 10. Larger numbers will result in better 
#' accuracy, but might take longer to compute. 
#' @param type The type of computation to be performed in order to obtain the 
#' background image. The possible values are "mean" (default) and "median". 
#' "mean" is faster but is usually less accurate than "median". 
#' @param color A logical value indicating if the the background image should be
#' color (TRUE) or grayscale (FALSE, default). Grayscale background image are 
#' faster to compute. 
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{backgrounder} function is 
#' not a persistent object, but a pointer to a C++ object that cannot be saved 
#' for reuse in a different session.
#' 
#' @seealso \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_vid/Walk3.mp4", package = "videoplayR")
#' vid <- readVid(filename)
#' imshow(getFrame(vid, 125))
#' bg <- backgrounder(vid, n = 100, type = "median", color = TRUE)
#' imshow(bg)
backgrounder <- function(video, n = 10, type = "mean", color = FALSE) {
  if (color) {
    bg <- .backgrounder_col(video = video, n = n, type = type)
  } else {
    bg <- .backgrounder_gray(video = video, n = n, type = type)
  }
  
  r2img(bg)
}

.backgrounder_col <- function(video, n = 10, type = "mean") {
  if (class(video) != "Rcpp_vpVideo") {
    stop("This is not a Video object.")
  } 
  
  if (n > video$length) {
    stop("n should be smaller than the total number of frames in the video.")
  }
  
  frames <- round(seq.int(1, video$length - 1, length.out = n))
  
  if (type == "mean") {
    
    mat <- array(0, dim = c(video$dim, 3))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      frame <- getFrame(video, frames[i])
      mat <- mat + img2r(frame)
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing average image.")
    
    print("Done.")
    
    return(mat / n)
    
  } else if (type == "median") {
    
    mat <- array(0, dim = c(video$dim, 3))
    stack.r <- array(NA, dim = c(video$dim, n))
    stack.g <- array(NA, dim = c(video$dim, n))
    stack.b <- array(NA, dim = c(video$dim, n))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      frame <- getFrame(video, frames[i])
      img <- img2r(frame)
      stack.r[, , i] <- img[, , 1]
      stack.g[, , i] <- img[, , 2]
      stack.b[, , i] <- img[, , 3]
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing median image. This is a slow process, please be patient.")
    
    print("   Median red:")
    mat[, , 1] <- pbapply::pbapply(stack.r, c(1, 2), median.default)
    
    print("   Median green:")
    mat[, , 2] <- pbapply::pbapply(stack.g, c(1, 2), median.default)
    
    print("   Median blue:")
    mat[, , 3] <- pbapply::pbapply(stack.b, c(1, 2), median.default)
    
    print("Done.")
    
    return(mat)
    
  } else {
    
    stop("'type' should be 'mean' or 'median'")
    
  }  
}

.backgrounder_gray <- function(video, n = 10, type = "mean") {
  if (class(video) != "Rcpp_vpVideo") {
    stop("This is not a Video object.")
  } 
  
  if (n > video$length) {
    stop("n should be smaller than the total number of frames in the video.")
  }
  
  frames <- round(seq.int(1, video$length - 1, length.out = n))
  
  if (type == "mean") {
    
    mat <- array(0, dim = video$dim)
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      frame <- getFrame(video, frames[i])
      frame <- ddd2d(frame)
      mat <- mat + img2r(frame)
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing average image.")
    
    print("Done.")
    
    return(mat / n)
    
  } else if (type == "median") {
    
    mat <- array(0, dim = video$dim)
    stack <- array(NA, dim = c(video$dim, n))
    
    print("Loading images:")
    pb <- pbapply::startpb(0, n - 1)
    for (i in 1:length(frames)) {
      frame <- getFrame(video, frames[i])
      frame <- ddd2d(frame)
      stack[, , i] <- img2r(frame)
      pbapply::setpb(pb, i)
    }
    pbapply::closepb(pb)
    
    print("Computing median image. This is a slow process, please be patient.")
    
    mat <- pbapply::pbapply(stack, c(1, 2), median.default)
    
    print("Done.")
    
    return(mat)
    
  } else {
    
    stop("'type' should be 'mean' or 'median'")
    
  }  
}