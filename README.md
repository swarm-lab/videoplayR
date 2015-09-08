videoplayR
=========

`videoplayR` is an R package that provides a few functions (for now) to manipulate 
video and image files with R. It requires the installation of OpenCV. 

### Package overview

This package uses the [OpenCV C++ library](http://opencv.org/) to provide R users 
with some basic functions to read and manipulate video and image files. As of now, 
`videoplayR` can:

* Load can access video and image files. 
* Grab frames from videos and convert them to images.
* Convert images to R matrices and arrays.
* Convert R matrices and arrays to images. 
* Display images in the default R graphics device. 
* Perform basic image processing operations such as thresholding, flattening,
    blending.
* Perfom simple background reconstruction and blob detection.

### General information

`videoplayR` requires the installation of the OpenCV library to compile and run. 
For the moment, the package can only be installed on Mac and Linux computers. 

Installation instructions for OpenCV and `videoplayR`, as well as a brief tutorial 
for the different functions of the package are available on Rpubs at the following 
address: [http://rpubs.com/sjmgarnier/videoplayR](http://rpubs.com/sjmgarnier/videoplayR). 

Issues and suggestions can be reported here: 
[https://github.com/swarm-lab/videoplayR/issues](https://github.com/swarm-lab/videoplayR/issues)

Pull requests can be submitted here: 
[https://github.com/swarm-lab/videoplayR/pulls](ttps://github.com/swarm-lab/videoplayR/pulls)

#### Author(s)

Simon Garnier - [@sjmgarnier](https://twitter.com/sjmgarnier) - <garnier@njit.edu>

#### References

This package uses the OpenCV library to read and process video files. More 
information about OpenCV can be found at: [http://opencv.org/](http://opencv.org/)

