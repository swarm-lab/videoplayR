\name{col2bw}
\alias{col2bw}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert black and white pictures to color. 
}
\description{
This function converts a black and white picture (2 dimensional array) into an RGB color picture (3 dimensional array). The conversion is achieved by creating a 3 dimensional array with 3 layers filled with the black and white picture.
}
\usage{
bw2col(image)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{image}{
A 2 dimensional array representing a black and white image. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
bw2col returns a 3 dimensional matrix. 
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
