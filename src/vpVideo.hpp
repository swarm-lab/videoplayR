class vpVideo {
public:
  vpVideo(std::string filename);
  void setFrame(int n);
  void release();
  cv::Mat frame;
  int length;
  int fps;
  Rcpp::NumericVector dim;

protected:
  cv::VideoCapture inputVideo;
};

vpVideo::vpVideo(std::string filename) {
  this->inputVideo.open(filename);
  
  if (!this->inputVideo.isOpened()) {
    throw std::range_error("Could not open the video.");
  }
  
  this->length = this->inputVideo.get(CV_CAP_PROP_FRAME_COUNT);
  this->fps = this->inputVideo.get(CV_CAP_PROP_FPS);
  this->dim = Rcpp::NumericVector::create(this->inputVideo.get(CV_CAP_PROP_FRAME_HEIGHT), 
                                          this->inputVideo.get(CV_CAP_PROP_FRAME_WIDTH));
}

void vpVideo::setFrame(int n) {
  if (n > this->inputVideo.get(CV_CAP_PROP_FRAME_COUNT)) {
    throw std::range_error("The requested frame does not exist. Try with a lower frame number.");
  }
  this->inputVideo.set(CV_CAP_PROP_POS_FRAMES, n);
  this->inputVideo >> this->frame;
}

void vpVideo::release() {
  this->inputVideo.release();
}

