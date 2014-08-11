\name{dim_video}
\alias{dim_video}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Retrieve the dimensions of a video file. 
}
\description{
dim_video retrieves the dimensions (widht and height in pixels) of a video file.
}
\usage{
dim_video(video)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{video}{
A \code{\link{Video}} object. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
dim_video returns a 2-element vector corresponding to the number of rows (height)
and columns (width) of the video. 
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
# Download sample video from mplayerhq
download.file("http://samples.mplayerhq.hu/MPEG-4/turn-on-off.mp4", "test.mp4")

# Load video in memory
test <- load_video("test.mp4")

# Retrieve video dimensions
dim_video(test)

# Delete sample video (optional)
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
