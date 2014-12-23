\name{bresenham_line}
\alias{bresenham_line}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Find pixels and voxels along a line. 
}
\description{
Given a starting and an ending point, this function finds all the pixels (2D matrix) or voxels (3D matrix) along the line connecting them. 
}
\usage{
bresenham_line(x1, y1, z1, x2, y2, z2, delta)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x1}{
X coordinate of the starting point.
}
  \item{y1}{
Y coordinate of the starting point.
}
  \item{z1}{
Z coordinate of the starting point.
}
  \item{x2}{
X coordinate of the ending point.
}
  \item{y2}{
Y coordinate of the ending point.
}
  \item{z2}{
Z coordinate of the ending point.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
\code{bresenham_line} returns matrix with three columns corresponding to the X, Y, and Z coordinates of the pixels/voxels along the line. 
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
pix <- bresenham_line(0, 0, 0, 10, 10, 0)
plot(0:10, 0:10, type = "l")
points(pix[,1], pix[,2], col = "red")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
