get_frame <- function(n, video, color = FALSE) {
  if (video$check) {
    switch((!color) + 1,
           video$get_frame_color(n),
           video$get_frame_gray(n))
    
  } else {
    stop("This is not a Video object.")
  }
}