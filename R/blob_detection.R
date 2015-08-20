blob_detection <- function(bw_image, min_size = 0, max_size = Inf) {
  cc <- .Call("ccl", bw_image, PACKAGE = "videotrackR")
  
  tab <- data.frame(which(cc > 0, arr.ind=T),
                    group = cc[which(cc > 0)])
  
  idx <- which(table(tab$group) <= max_size & table(tab$group) >= min_size)
  
  tab[tab[, 3] %in% idx, ]
}