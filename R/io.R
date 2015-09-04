# ------
#' Load image file in memory
#' 
#' This function reads an image file and return a vpImage object that can be 
#' manipulated using the \code{\link{videoplayR}} image and video manipulation 
#' toolbox. This function supports the following image formats: 
#' \itemize{
#'  \item{Windows bitmaps - *.bmp, *.dib}
#'  \item{JPEG files - *.jpeg, *.jpg, *.jpe}
#'  \item{Portable Network Graphics - *.png}
#'  \item{Portable image format - *.pbm, *.pgm, *.ppm}
#'  \item{TIFF files - *.tiff, *.tif}
#' }
#'
#' @param filename A character string of the path to the image file.
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{readImg} function is not a 
#' persistent object, but a pointer to a C++ object that cannot be saved for 
#' reuse in a different session.
#' 
#' @seealso \code{\link{writeImg}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
readImg <- function(filename) {
  `_readImg`(normalizePath(filename))
}

# ------
#' Save image object to file
#' 
#' This function write a vpImage object to an image file on the computer's drive.
#' This function can save image files in the following formats: 
#' \itemize{
#'  \item{Windows bitmaps - *.bmp, *.dib}
#'  \item{JPEG files - *.jpeg, *.jpg, *.jpe}
#'  \item{Portable Network Graphics - *.png}
#'  \item{Portable image format - *.pbm, *.pgm, *.ppm}
#'  \item{TIFF files - *.tiff, *.tif}
#' }
#' The image format is chosen based on the \code{filename} extension.
#'
#' @param filename A character string of the path to the image file.
#' @param image The vpImage object to save. 
#' 
#' @return This function does not return anythin.
#' 
#' @seealso \code{\link{readImg}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' writeImg("test_img.png", img)
writeImg <- function(filename, image) {
  `_readImg`(normalizePath(filename), image)
}

# ------
#' Load video file in memory
#' 
#' This function reads a video file and return a vpVideo object that can be 
#' manipulated using the \code{\link{videoplayR}} image and video manipulation 
#' toolbox. This function should support most video formats and codecs listed at
#' \link{http://www.fourcc.org/codecs.php}.
#' 
#' @param filename A character string of the path to the video file.
#' 
#' @return This function returns a vpVideo object.
#' 
#' @details The vpVideo object created by the \code{readVid} function is not a 
#' persistent object, but a pointer to a C++ object that cannot be saved for 
#' reuse in a different session.
#' 
#' @seealso \code{\link{readImg}}, \code{\link{getFrame}}, \code{\link{vpVideo}}
#' 
#' @examples
#' filename <- system.file("sample_vid/SampleVideo_1080x720_5mb.mp4", package = "videoplayR")
#' vid <- readVideo(filename)
#' frame <- getFrame(vid, 1)
#' imshow(frame)
readVid <- function(filename) {
  `_readVid`(normalizePath(filename))
}

# ------
#' Grab a specific frame from a video
#' 
#' This function grabs a specific frame from a vpVideo object and returns a 
#' vpImage object that can be manipulated using the \code{\link{videoplayR}} 
#' image and video manipulation toolbox.
#' 
#' @param video The vpVideo object from which the frame should be grabbed. 
#' @param frame The position in the video of the frame to be grabbed. 
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{grabFrame} function is not a 
#' persistent object, but a pointer to a C++ object that cannot be saved for 
#' reuse in a different session.
#' 
#' @seealso \code{\link{readVid}}, \code{\link{vpVideo}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_vid/SampleVideo_1080x720_5mb.mp4", package = "videoplayR")
#' vid <- readVideo(filename)
#' frame <- getFrame(vid, 1)
#' imshow(frame)
"getFrame"

# ------
#' Convert a vpImage object to a matrix or an array
#' 
#' This function converts a vpImage object to a 2D matrix or a 3D array that can 
#' be used in R. Binary, grayscale, and 2D numeric vpImage objects will be 
#' converted to 2D matrices. RGB and 3D numeric vpImage objects will be 
#' converted to 3D arrays. 
#' 
#' @param image The vpImage object to convert. 
#' 
#' @return This function returns either a 2D matrix or a 3D arrays depending on
#' the input vpImage object.
#' 
#' @seealso \code{\link{r2img}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imgMat <- img2r(img)
#' imgMat
img2r <- function(image) {
  res <- `_img2r`(image)
  
  if (dim(res)[3] == 1) {
    res[,, 1]
  } else {
    res
  }
}

# ------
#' Convert a matrix or an array to a vpImage object
#' 
#' This function converts a 2D matrix or a 3D array to a vpImage object to that 
#' can be manipulated using the \code{\link{videoplayR}} image and video 
#' manipulation toolbox. Binary matrices will be converted to binary vpImage 
#' objects. Integer matrices with values in [0, 255] will be converted to 
#' grayscale vpImage objects. Numeric matrics will be converted to 2D numeric 
#' vpImage objects. 3D integer arrays with values in [0, 255] will be converted 
#' to RGB vpImage objects. 3D numeri arrays will be converted to 3D numeric 
#' vpImage objects. 
#' 
#' @param array The matrix or array  to convert. 
#' @param numeric A logical value indicating if the matrix or array should be 
#' treated as a numeric object. If FALSE (default), the matrix or array will be 
#' casted to an integer matrix or array. If TRUE, the matrix or array will be 
#' converted to a numeric vpImage object. 
#' 
#' @return This function returns a vpImage object.
#' 
#' @seealso \code{\link{img2r}}, \code{\link{vpImage}}
#' 
#' @examples
#' gradient <- function(x1, x2) { x1 + x2 }
#' x <- 0:127
#' mat <- myfunc(outer(rep(1, length(x)), x), x)
#' img <- r2img(mat)
#' imshow(img)
"r2img"

# ------
#' Image object.
#' 
#' A vpImage object is an R container for an OpenCV image. vpImage objects can 
#' be generated by the following \code{\link{videoplayR}} functions: 
#' \code{\link{readImg}}, \code{\link{getFrame}}. They can be displayed using 
#' the \code{\link{inshow}} function. 
#' 
#' @format A vpImage object contains two fields:
#' \itemize{
#'  \item{\code{$type}: the type of image stored in the object. There are 4 types of image types:
#'    \itemize{
#'      \item{\code{binary}: 1 channel image with integer pixel values of 0 or 1 only.}
#'      \item{\code{grayscale}: 1 channel image with integer pixel values in [0, 255].}
#'      \item{\code{rgb}: 3 channels image with integer pixel values in [0, 255].}
#'      \item{\code{numeric}: 1 or 3 channels image with unconstrained pixel values.}
#'    }
#'  }
#'  \item{"dim": the dimensions in pixels (width x height x depth) of the image.}
#' }
#' 
#' @usage NULL
#' 
#' @seealso \code{\link{readImg}}, \code{\link{getFrame}}, \code{\link{imshow}}
"vpImage"

# ------
#' Video object.
#' 
#' A vpVideo object is an R container for an OpenCV video. vpVideo objects can 
#' be generated by the \code{\link{readVid}} function in the 
#' \code{\link{videoplayR}} library. 
#' 
#' @format A vpVideo object contains three fields:
#' \itemize{
#'  \item{"length": the number of frames in the video.}
#'  \item{"fps": the framerate of the video.}
#'  \item{"dim": the dimensions in pixels (width x height) of the video.}
#' }
#' 
#' @usage NULL
#' 
#' @seealso \code{\link{readVid}}, \code{\link{getFrame}}
"vpVideo"
