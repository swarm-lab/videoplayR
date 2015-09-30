#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include "opencv2/opencv.hpp"
#include "vpImage.hpp"
#include "vpVideo.hpp"
#include "vpStream.hpp"
#include "io.hpp"
#include "imgProc.hpp"

RCPP_MODULE(vp) {  
  Rcpp::class_<vpImage>("vpImage")
  .field_readonly("type", &vpImage::type, "Returns image type.")
  .field_readonly("dim", &vpImage::dim, "Returns the dimensions in pixels of the image.")
  .method("img2r", &vpImage::img2r, "Converts image to R matrix or array.")
  ;
  
  Rcpp::class_<vpVideo>("vpVideo")
    .field_readonly("length", &vpVideo::length, "Returns total number of frames in the video.")
    .field_readonly("fps", &vpVideo::fps, "Returns the framerate of the video.")
    .field_readonly("dim", &vpVideo::dim, "Returns the dimensions in pixels of the video.")
  ;
  
  Rcpp::class_<vpStream>("vpStream")
    .field_readonly("dim", &vpStream::dim, "Returns the dimensions in pixels of the video stream.")
  ;
  
  Rcpp::function("_readImg", &_readImg, Rcpp::List::create(Rcpp::_["filename"]), "Load image file in memory.");
  Rcpp::function("_writeImg", &_writeImg, Rcpp::List::create(Rcpp::_["filename"], Rcpp::_["image"]), "Save image object to file.");
  Rcpp::function("_readVid", &_readVid, Rcpp::List::create(Rcpp::_["filename"]), "Load video file in memory.");
  Rcpp::function("readStream", &readStream, Rcpp::List::create(Rcpp::_["cam"] = 0), "Open camera stream.");
  Rcpp::function("release", &release, Rcpp::List::create(Rcpp::_["stream"]), "Release open video stream.");
  Rcpp::function("getFrame", &getFrame, Rcpp::List::create(Rcpp::_["video"], Rcpp::_["frame"]), "Grab a specific frame from a video.");
  Rcpp::function("nextFrame", &nextFrame, Rcpp::List::create(Rcpp::_["stream"]), "Grab next frame from a video stream.");
  Rcpp::function("_img2r", &_img2r, Rcpp::List::create(Rcpp::_["image"]), "Convert a vpImage object to a matrix or an array.");
  Rcpp::function("r2img", &r2img, Rcpp::List::create(Rcpp::_["array"], Rcpp::_["numeric"] = false), "Convert a matrix or an array to a vpImage object.");
  Rcpp::function("ddd2d", &ddd2d, Rcpp::List::create(Rcpp::_["image"]), "Flatten a 3-channels image to 1 channel.");
  Rcpp::function("d2ddd", &d2ddd, Rcpp::List::create(Rcpp::_["image"]), "Expand a 1-channel image to 3 channels.");
  Rcpp::function("thresholding", &thresholding, Rcpp::List::create(Rcpp::_["image"], Rcpp::_["thres"], Rcpp::_["type"]), "Convert image to binary image .");
  Rcpp::function("blend", &blend, Rcpp::List::create(Rcpp::_["image1"], Rcpp::_["image2"], Rcpp::_["operation"]), "Element-wise operations on image objects .");
  Rcpp::function("blobDetector", &blobDetector, Rcpp::List::create(Rcpp::_["image"]), "Find blobs in binary image.");
}
