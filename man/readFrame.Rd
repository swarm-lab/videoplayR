\name{readFrame}
\alias{readFrame}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Read the nth frame of a video file. 
}
\description{
readFrame grabs the nth frame of any video file that can be read by the OpenCV
library.
}
\usage{
readFrame(n, source)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{
The position in the video file of the frame to grab.
}
  \item{source}{
The location of the video file. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
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
function (n, source) 
{
    .Call("videoplayR_readFrame", PACKAGE = "videoplayR", n, 
        source)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
