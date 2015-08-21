blob_properties <- function(blob) {
  dplyr::group_by(blob, id) %>%
    dplyr::summarize(x = mean(x),
                     y = mean(y), 
                     size = length(id)) 
}