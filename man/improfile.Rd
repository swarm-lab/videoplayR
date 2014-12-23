\name{improfile}
\alias{improfile}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Return pixel intensity along a line. 
}
\description{
This function is a simplified version of the \href{http://www.mathworks.com/help/images/ref/improfile.html}{improfile function in Matlab}. Given a start and an end point, this function returns the intensity of the pixels along the line connecting them.
}
\usage{
improfile(img, start, end)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{img}{
A matrix or array representing a color or grayscale image as returned by \code{\link{get_frame}} for instance. 
}
  \item{start}{
A two-element vector corresponding to the x and y coordinates of the line's starting point. 
}
  \item{end}{
A two-element vector corresponding to the x and y coordinates of the line's ending point. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
If \code{img} is a grayscale image, \code{improfile} returns a data frame with 3 columns corresponding to the x and y coordinates of the pixels along the line, and to the grayscale intensity of these pixels. 

If \code{img} is a color image (RGB), \code{improfile} returns a data frame with 5 columns corresponding to the x and y coordinates of the pixels along the line, and to the intensity of these pixels in the R, G and B channels. 
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

# Read 10th frame and display it
frame <- get_frame(10, test)
grid.raster(frame / 255, interpolate = FALSE)

# Measure pixel intensity along video diagonal
start <- c(1, 1)
end <- dim(frame)[2:1]
prof <- improfile(frame, start, end)

# Plot pixel intensity as a function of distance from starting point
d <- sqrt((prof$x - start[1])^2 + (prof$y - start[2])^2)
plot(prof$ir ~ d, type = "l", col = "red", xlab = "Distance (in pixels)", ylab = "Intensity")
lines(prof$ig ~ d, col = "green")
lines(prof$ib ~ d, col = "blue")

# Delete sample video (optional)
file.remove("test.mp4")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
