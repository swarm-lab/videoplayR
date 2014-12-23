\name{col2bw}
\alias{col2bw}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert color pictures to black and white. 
}
\description{
This function converts an RGB color picture (3 dimensional array) into a black and white picture (2 dimensional array). The conversion is achieved by a weighted averaging of the (R)ed, (G)reen and (B)lue components of the color picture.
}
\usage{
col2bw(image, r = 1, g = 1, b = 1)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{image}{
A 3 dimensional array representing an RGB image. 
}
  \item{r, g, b}{
The weight of each color component ((R)ed, (G)reen and (B)lue) in the final black and white image. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
col2bw returns a 2 dimensional matrix. 
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
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x) 
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
