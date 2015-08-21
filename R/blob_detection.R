blob_detection <- function(bw_image, min_size = 0, max_size = Inf) {
  cc <- .Call("ccl", bw_image, PACKAGE = "videoplayR")
  
  data.frame(id = cc[which(cc > 0)], which(cc > 0, arr.ind = TRUE)) %>%
    dplyr::rename(x = col, y = row) %>%
    dplyr::select(id, x, y) %>%
    dplyr::group_by(id) %>%
    dplyr::mutate(filter = ifelse(length(id) <= max_size & length(id) >= min_size, TRUE, FALSE)) %>%
    dplyr::filter(filter == TRUE) %>%
    dplyr::select(-filter) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(id = sapply(.$id, function(x) which(unique(.$id) %in% x)))
}