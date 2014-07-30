#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector videoDim(std::string source) {
  VideoCapture inputVideo(source); 
  if (!inputVideo.isOpened()) {
    throw std::range_error("Error. Could not open the video.");
  }
  
  return(NumericVector::create(inputVideo.get(CV_CAP_PROP_FRAME_HEIGHT), inputVideo.get(CV_CAP_PROP_FRAME_WIDTH)));
}
