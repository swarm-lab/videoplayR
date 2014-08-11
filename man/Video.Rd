\name{Video}
\alias{Video}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Video file object. 
}
\description{
C++ object of class Video containing an OpenCV video object. This object comes with a set of methods to grab frames and information from a video file. 
}
\usage{
Video$dim()
Video$length()
Video$fps()
Video$next_frame()
Video$get_frame(n)
}
\details{
A Video object comes with a set of methods to grab frames and information from a video file. These methods are:

  - dim(): Retrieves the dimensions in pixels of the video.
  
  - length(): Retrieves the length of the video (total number of frames).
  
  - fps(): Retrieves the framerate of the video (in frames per second).
  
  - next_frame(): Grabs the next frame of the video. 
  
  - get_frame(n): Grabs frame n of the video. 
  
Note that wrapper functions are provided for each of these methods: \code{\link{dim_video}}, \code{\link{length_video}}, \code{\link{fps}}, \code{\link{next_frame}}, \code{\link{get_frame}}. See their respective documentation for more information about the usage of the Video methods. 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
