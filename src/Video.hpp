class Video {
public:
  Video(std::string filename);
  bool check;
  double current_frame();
  void set_current_frame(int n);
  arma::cube next_frame_color();
  arma::mat next_frame_gray();
  arma::cube get_frame_color(int n);
  arma::mat get_frame_gray(int n);
  int length();
  int fps();
  Rcpp::NumericVector dim();

protected:
  cv::VideoCapture inputVideo;
  cv::Mat frame;
  void next_frame_cv();
  void get_frame_cv(int n);
  arma::cube frame_to_R_color();
  arma::mat frame_to_R_gray();
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

arma::cube Video::frame_to_R_color() {
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

arma::mat Video::frame_to_R_gray() {
  cv::Mat gray_frame;
  cv::cvtColor(frame, gray_frame, cv::COLOR_BGR2GRAY);
  
  arma::mat reframe(gray_frame.rows, gray_frame.cols);
  
  for(int i = 0; i < gray_frame.rows; i++) {
    for(int j = 0; j < gray_frame.cols; j++) {
      reframe(i, j) = gray_frame.at<uint8_t>(i, j);
    }
  }
  
  return(reframe);
}

void Video::next_frame_cv() {
  if (inputVideo.get(CV_CAP_PROP_POS_FRAMES) == inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    Rcpp::Rcout << "Warning. This is the last frame of the video. Calling this function again will loop back to the first frame." << "\n";
  }
  
  inputVideo >> frame;
}

arma::cube Video::next_frame_color() {
  next_frame_cv();
  return(frame_to_R_color());
}

arma::mat Video::next_frame_gray() {
  next_frame_cv();
  return(frame_to_R_gray());
}

void Video::get_frame_cv(int n) {
  if (n > inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    throw std::range_error("The requested frame does not exist. Try with a lower frame number.");
  }
  
  inputVideo.set(CV_CAP_PROP_POS_FRAMES, n);
  
  inputVideo >> frame;
}

arma::cube Video::get_frame_color(int n) {
  get_frame_cv(n);
  return(frame_to_R_color());
}

arma::mat Video::get_frame_gray(int n) {
  get_frame_cv(n);
  return(frame_to_R_gray());
}

int Video::length() {
  return(inputVideo.get(CV_CAP_PROP_FRAME_COUNT));
}

int Video::fps() {
  return(inputVideo.get(CV_CAP_PROP_FPS));
}

Rcpp::NumericVector Video::dim() {
  return(Rcpp::NumericVector::create(inputVideo.get(CV_CAP_PROP_FRAME_HEIGHT), inputVideo.get(CV_CAP_PROP_FRAME_WIDTH)));
}