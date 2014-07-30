#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace Rcpp;

// [[Rcpp::export]]
arma::cube readFrame(int n, std::string source) {
  VideoCapture inputVideo(source); 
  if (!inputVideo.isOpened()) {
    throw std::range_error("Error. Could not open the video.");
  }
  if (n > inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    throw std::range_error("The requested frame does not exist. Try with a lower frame number.");
  }
  
  cv::Mat frame;
  for (int i = 0; i < n - 1; i++) {
    inputVideo.grab();
  }
  
  inputVideo >> frame;
  
  arma::cube reframe(frame.rows, frame.cols, 3);
  for(int i = 0; i < frame.rows; i++) {
    for(int j = 0; j < frame.cols; j++) {
      reframe(i, j, 0) = frame.at<cv::Vec3b>(i, j)[2];
      reframe(i, j, 1) = frame.at<cv::Vec3b>(i, j)[1];
      reframe(i, j, 2) = frame.at<cv::Vec3b>(i, j)[0];
    }
  }
  
  return(reframe);
}
