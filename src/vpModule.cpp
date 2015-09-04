#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include "opencv2/opencv.hpp"
#include "vpImage.hpp"
#include "vpVideo.hpp"
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
  
  Rcpp::function("_readImg", &_readImg, Rcpp::List::create(Rcpp::_["filename"]), "Doc.");
  Rcpp::function("_writeImg", &_writeImg, Rcpp::List::create(Rcpp::_["filename"], Rcpp::_["image"]), "Doc.");
  Rcpp::function("_readVid", &_readVid, Rcpp::List::create(Rcpp::_["filename"]), "Doc.");
  Rcpp::function("getFrame", &getFrame, "Doc.");
  Rcpp::function("_img2r", &_img2r, "Converts image to R matrix or array.");
  Rcpp::function("r2img", &r2img, Rcpp::List::create(Rcpp::_["array"], Rcpp::_["numeric"] = false), "Doc.");
  Rcpp::function("ddd2d", &ddd2d, "Doc.");
  Rcpp::function("d2ddd", &d2ddd, "Doc.");
  Rcpp::function("thresholding", &thresholding, "Doc.");
  Rcpp::function("blend", &blend, "Doc.");
  Rcpp::function("blobDetector", &blobDetector, "Doc.");
}
