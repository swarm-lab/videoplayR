\name{countFrames}
\alias{countFrames}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Count the number of frames in a video file. 
}
\description{
countFrames counts the total number of frames contained in a video file. 
}
\usage{
countFrames(source)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{source}{
A character string indicating the location of the video file. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
countFrames returns a scalar value corresponding to the total number of frames
in the video file. 
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
countFrames("test.mp4")

# Delete sample video
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
