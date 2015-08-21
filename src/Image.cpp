#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace Rcpp;

// [[Rcpp::export]]
arma::cube load_image_cv(std::string filename) {
  cv::Mat image_cv = imread(filename);

//   if (!image_cv.data) {
//     throw std::range_error("Could not open the image file.");
//   }
  
  arma::cube image(image_cv.rows, image_cv.cols, 3);
  for(int i = 0; i < image_cv.rows; i++) {
    for(int j = 0; j < image_cv.cols; j++) {
      image(i, j, 0) = image_cv.at<cv::Vec3b>(i, j)[2];
      image(i, j, 1) = image_cv.at<cv::Vec3b>(i, j)[1];
      image(i, j, 2) = image_cv.at<cv::Vec3b>(i, j)[0];
    }
  }
  
  return(image);
}