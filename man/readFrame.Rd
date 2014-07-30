\name{readFrame}
\alias{readFrame}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read the nth frame of a video file. 
}
\description{
readFrame grabs the nth frame of any video file that can be read by the OpenCV
library (v2).
}
\usage{
readFrame(n, source)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{
A scalar (integer) value indicating the position in the video file of the frame 
to grab.
}
  \item{source}{
A character string indication the location of the video file. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
readFrame returns a 3 dimensional matrix with 3 layers. Each layer corresponds 
to the R, G or B layer of the video frame respectively. 
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Simon Garnier <garnier@njit.edu> - @sjmgarnier
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

# Read 10th frame and display it
test <- readFrame(10, "test.mp4")
grid.raster(test / 255, interpolate = FALSE)

# Delete sample video
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
