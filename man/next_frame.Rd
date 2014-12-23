\name{next_frame}
\alias{next_frame}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read the next frame of a video file. 
}
\description{
next_frame grabs the next frame of a \code{\link{Video}} object. 
}
\usage{
next_frame(n, video)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{
A scalar (integer) value indicating the position in the video file of the frame 
to grab.
}
  \item{video}{
A \code{\link{Video}} object. 
}
}
\details{
In a \code{\link{Video}} object, frames are read sequentially because of the way decompression algorithms work. This method is the faster way to grab frames from the video in a sequential order (e.g., within a 'for' loop). Do not use the \code{\link{get_frame}} function for this purpose because it would be slower. 
}
\value{
next_frame returns a 3 dimensional matrix with 3 layers. Each layer corresponds 
to the R, G or B layer of the video frame respectively. 
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Simon Garnier <garnier@njit.edu> - \href{http://twitter.com/sjmgarnier}{@sjmgarnier}
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
library(grid)

# Download sample video from mplayerhq
download.file("http://samples.mplayerhq.hu/MPEG-4/turn-on-off.mp4", "test.mp4")

# Load video in memory
test <- load_video("test.mp4")

# Read 10 frames and display the 10th one
for (i in 1:10) {
  frame <- next_frame(test)
}

grid.raster(frame / 255, interpolate = FALSE)

# Delete sample video (optional)
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
