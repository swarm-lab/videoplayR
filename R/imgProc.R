# ------
#' Flatten a 3-channels image to 1 channel
#' 
#' This function converts a 3-channels image (rgb or numeric) to a 1-channel 
#' image (binary, grayscale or numeric) by computing the average of the 3 
#' channel values for each pixel. For instance, this function can be used to 
#' convert an rgb image to grayscale.
#'
#' @param image A 3-channels vpImage object to convert to 1 channel.
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{ddd2d} function is not a 
#' persistent object, but a pointer to a C++ object that cannot be saved for 
#' reuse in a different session.
#' 
#' @seealso \code{\link{d2ddd}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
#' imshow(ddd2d(img))
"ddd2d"

# ------
#' Expand a 1-channel image to 3 channels
#' 
#' This function converts a 1-channel image (binary, grayscale or numeric) to a 
#' 3-channels image (rgb or numeric) by triplicating the current channel. For 
#' instance, this function can be used to convert a 1-channel binary mask to a
#' 3-channels mask. 
#'
#' @param image A 1-channel vpImage object to convert to 3 channels.
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{d2ddd} function is not a 
#' persistent object, but a pointer to a C++ object that cannot be saved for 
#' reuse in a different session.
#' 
#' @seealso \code{\link{ddd2d}}, \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
#' mat <- matrix(0, nrow = img$dim[1], ncol = img$dim[2])
#' mat[80:640, 250:650] <- 1
#' mask <- d2ddd(r2img(mat))
#' imshow(blend(img, mask, "*"))
"d2ddd"

# ------
#' Convert image to binary image 
#' 
#' This function converts an image (rgb, grayscale or numeric) to binary by 
#' applying a thresholding function to it. 3-channels images (rgb and numeric)
#' are first converted to 1-channel images (grayscale or numeric) prior to 
#' applying the thresholding function.
#'
#' @param image A vpImage object to convert to a binary image.
#' @param thres The threshold value to separate the pixels of the image in two 
#' groups.
#' @param type The type of thresholding function to apply to the image. If set 
#' to \code{"binary"}, then the pixels above \code{thres} are replaced with ones
#' and those below are replaced with zeros. If set to \code{"inverted"}, then 
#' the pixels above \code{thres} are replaced with zeros and those below are 
#' replaced with ones.
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{thresholding} function is 
#' not a persistent object, but a pointer to a C++ object that cannot be saved 
#' for reuse in a different session.
#' 
#' @seealso \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
#' bin <- thresholding(img, 128, "binary")
#' imshow(bin)
#' inv <- thresholding(img, 128, "inverted")
#' imshow(inv)
"thresholding"

# ------
#' Element-wise operations on image objects 
#' 
#' This function performs element-wise operations on vpImage objects. Currently
#' available operations are addition ("+"), subtraction ("-"), mutliplication 
#' ("*") and division ("/"). 
#'
#' @param image1 First vpImage object.
#' @param image2 Second vpImage object.
#' @param operation A character string describing the operation to be performed.
#' Available operations are: 
#' \itemize{
#'  \item{"addition" or "+"}
#'  \item{"subtraction" or "-"}
#'  \item{"multiplication" or "*"}
#'  \item{"division" or "/"}
#' }
#' 
#' @return This function returns a vpImage object.
#' 
#' @details The vpImage object created by the \code{thresholding} function is 
#' not a persistent object, but a pointer to a C++ object that cannot be saved 
#' for reuse in a different session.
#' 
#' @seealso \code{\link{vpImage}}
#' 
#' @examples
#' filename <- system.file("sample_img/SampleVideo_1080x720_5mb.png", package = "videoplayR")
#' img <- readImg(filename)
#' imshow(img)
#' mat <- matrix(0, nrow = img$dim[1], ncol = img$dim[2])
#' mat[80:640, 250:650] <- 1
#' mask <- d2ddd(r2img(mat))
#' imshow(blend(img, mask, "*"))
"blend"

# ------
#' Find blobs in binary image
#' 
#' This function finds blobs in binary images. A blob is defined as a group of 
#' 8-connected white pixels on a black background. 
#'
#' @param image A binary vpImage object, for instance one obtained from the 
#' \code{\link{thresholding}} function.
#' 
#' @return This function returns a data frame with one row per blob detected in 
#' the image and seven columns corresponding to the seven following properties 
#' of each blob:
#' \itemize{
#'  \item{"id": identity of the blob.}
#'  \item{"x": x coordinate of the center of the ellipse approximating the shape 
#'  of the blob.}
#'  \item{"y": y coordinate of the center of the ellipse approximating the shape 
#'  of the blob.}
#'  \item{"alpha": orientation in degrees of the major axis of the ellipse.}
#'  \item{"major": length of the major axis of the ellipse.}
#'  \item{"minor": length of the minor axis of the ellipse.}
#'  \item{"area": area of the polygon containing the blob.}
#' }
#' 
#' @seealso \code{\link{thresholding}}
#' 
#' @examples
#' require(plotrix)
#' filename <- system.file("sample_img/dots.jpg", package = "videoplayR")
#' img <- readImg(filename)
#' bw <- thresholding(img, 200, "inverted")
#' blobs <- blobDetector(bw)
#' 
#' imshow(img)
#' points(y ~ x, data = blob, col = "red", pch = 20)
#' draw.ellipse(blob$x, blob$y, blob$major / 2, blob$minor / 2, blob$alpha, border = "red")
"blobDetector"















