videoplayR
==========

`videoplayR` is an R package that provides a few functions (for now) to 
manipulate video files with R. It requires the installation of OpenCV 2.4.x. 

### Package overview

#### Description
This package uses the OpenCV library to provide R users with some basic 
functions to read and manipulate video files.

As of now, `videoplayR` can:
* Count the number of frames in a video.
* Extract the framerate of a video. 
* Extract the dimensions of a video. 
* Grab any frame from a video. 
* Grab frames sequentially at high speed. 

#### Installation
`videoplayR` requires the installation of the OpenCV library (>2.4.x) to compile 
and run. OpenCV can be installed on Linux, Mac and Windows compatible computers.
You should be able to find the instructions to install OpenCV on your computer 
thanks to a simple Google search (or ask me if you really can't find the 
information).

Once OpenCV is installed on your computer, you can install `videoplayR` by 
running the following commands in R:

```{r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("swarm-lab/videoplayR")
```

#### Author(s)
Simon Garnier - [@sjmgarnier](https://twitter.com/sjmgarnier) - 
<garnier@njit.edu>

#### References
This package uses the OpenCV library to read and process video files. More 
information about OpenCV can be found at: http://opencv.org/

