blob_properties <- function(blob, time) {
  data.frame(time = time,
             id = unique(blob$group),
             x = aggregate(col ~ group, data = blob, FUN = mean)[, 2],
             y = aggregate(row ~ group, data = blob, FUN = mean)[, 2],
             size = aggregate(col ~ group, data = blob, FUN = length)[, 2])
}

