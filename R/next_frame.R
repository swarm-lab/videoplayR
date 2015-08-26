next_frame <- function(video, color = FALSE) {
  if (video$check) {
    switch((!color) + 1,
           video$next_frame_color(),
           video$next_frame_gray())
    
  } else {
    stop("This is not a Video object.")
  }
}