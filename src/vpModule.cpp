#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include "Video.hpp"

RCPP_MODULE(vp) {  
  Rcpp::class_<Video>("Video")
  .constructor<std::string>()
  .field_readonly("check", &Video::check, "If true, the video has been imported properly and can be read.")
  .method("current_frame", &Video::current_frame, "Returns position of the current video frame.")
  .method("set_current_frame", &Video::set_current_frame, "Position the reader at an arbitrary frame in the video.")
  .method("next_frame_color", &Video::next_frame_color, "Grabs next color video frame.")
  .method("next_frame_gray", &Video::next_frame_gray, "Grabs next grayscale video frame.")
  .method("get_frame_color", &Video::get_frame_color, "Grabs a specific color video frame.")
  .method("get_frame_gray", &Video::get_frame_gray, "Grabs a specific grayscale video frame.")
  .method("length", &Video::length, "Returns total number of frames in the video.")
  .method("fps", &Video::fps, "Returns the framerate of the video.")
  .method("dim", &Video::dim, "Returns the dimensions in pixels of the video.")
  ;
}