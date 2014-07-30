videoplayR
==========

videoplayR is an R package that provides a few functions (for now) to manipulate
video files with R. It requires the installation of OpenCV 2.4.x. 

### Package overview

#### Description
This package uses the OpenCV library to provide R users with some basic 
functions to read and manipulate video files.

As of now, videoplayR can:
* Count the number of frames in a video.
* Extract the framerate of a video. 
* Extract the dimensions of a video. 
* Grab any frame from a video. 

#### Installation
```videoplayR```

In R, run:
```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("morpionZ/videoplayR")
```

#### Author(s)
Simon Garnier <garnier@njit.edu>

#### References
This package uses the OpenCV library to read and process video files. More 
information about OpenCV can be found at: http://opencv.org/

