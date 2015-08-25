blob_properties <- function(blob) {
  a <- dplyr::group_by(blob, id) %>%
    dplyr::summarize(x = mean(x),
                     y = mean(y), 
                     area = length(id))
  
  b <- dplyr::group_by(blob, id) %>%
    dplyr::do(as.data.frame(as.list(ellipse(.$x, .$y))))
    
  merge(a, b)
}