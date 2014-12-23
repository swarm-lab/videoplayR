\name{length_video}
\alias{length_video}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Count the number of frames in a video file. 
}
\description{
length_video counts the total number of frames contained in a video file. 
}
\usage{
length_video(video)
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
length_video returns a scalar value corresponding to the total number of frames
in the video file. 
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
# Download sample video from mplayerhq
download.file("http://samples.mplayerhq.hu/MPEG-4/turn-on-off.mp4", "test.mp4")

# Load video in memory
test <- load_video("test.mp4")

# Retrieve video length
length_video(test)

# Delete sample video (optional)
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
