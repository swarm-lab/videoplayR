#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using namespace Rcpp;

class Video {
  public:
    Video(std::string filename);
    bool check;
    double current_frame();
    void set_current_frame(int n);
    arma::cube next_frame();
    arma::cube get_frame(int n);
    int length();
    int fps();
    NumericVector dim();
    void show_frame(int n);

  protected:
    VideoCapture inputVideo;
    arma::cube frame_to_R();
    cv::Mat frame;
    void next_frame_cv();
    void get_frame_cv(int n);
};

Video::Video(std::string filename) {
  inputVideo.open(filename);
    
  if (!inputVideo.isOpened()) {
    throw std::range_error("Could not open the video.");
  } else {
    check = true;
  }
}

double Video::current_frame() {
  return(inputVideo.get(CV_CAP_PROP_POS_FRAMES));
}

void Video::set_current_frame(int n) {
  inputVideo.set(CV_CAP_PROP_POS_FRAMES, n);
}

arma::cube Video::frame_to_R() {
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

void Video::next_frame_cv() {
  if (inputVideo.get(CV_CAP_PROP_POS_FRAMES) == inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    Rcout << "Warning. This is the last frame of the video. Calling this function again will loop back to the first frame." << "\n";
  }
  
  inputVideo >> frame;
}

arma::cube Video::next_frame() {
  next_frame_cv();
  return(frame_to_R());
}

void Video::get_frame_cv(int n) {
   if (n > inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    throw std::range_error("The requested frame does not exist. Try with a lower frame number.");
  }
  
  inputVideo.set(CV_CAP_PROP_POS_FRAMES, n);
  
  inputVideo >> frame;
}

arma::cube Video::get_frame(int n) {
  get_frame_cv(n);
  return(frame_to_R());
}

int Video::length() {
  return(inputVideo.get(CV_CAP_PROP_FRAME_COUNT));
}

int Video::fps() {
  return(inputVideo.get(CV_CAP_PROP_FPS));
}

NumericVector Video::dim() {
  return(NumericVector::create(inputVideo.get(CV_CAP_PROP_FRAME_HEIGHT), inputVideo.get(CV_CAP_PROP_FRAME_WIDTH)));
}

void Video::show_frame(int n) {
  get_frame_cv(n);
  
  namedWindow("Frame", CV_WINDOW_NORMAL | CV_WINDOW_KEEPRATIO | CV_GUI_NORMAL);
  imshow("Frame", frame);
  
  Rcout << "Hit any key to close the display." << "\n";
  
  waitKey(0);
  
  destroyWindow("Frame");
}

RCPP_MODULE(Video) {  
  class_<Video>("Video")
    .constructor<std::string>()
    .field_readonly("check", &Video::check, "If true, the video has been imported properly and can be read.")
    .method("current_frame", &Video::current_frame, "Returns position of the current video frame.")
    .method("set_current_frame", &Video::set_current_frame, "Position the reader at an arbitrary frame in the video.")
    .method("next_frame", &Video::next_frame, "Grabs next video frame.")
    .method("get_frame", &Video::get_frame, "Grabs a specific video frame.")
    .method("length", &Video::length, "Returns total number of frames in the video.")
    .method("fps", &Video::fps, "Returns the framerate of the video.")
    .method("dim", &Video::dim, "Returns the dimensions in pixels of the video.")
    .method("show_frame", &Video::show_frame, "Display a specific video frame.")
  ;
}