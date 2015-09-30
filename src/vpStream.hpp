class vpStream {
public:
  vpStream(int cam);
  void nextFrame();
  void release();
  cv::Mat frame;
  Rcpp::NumericVector dim;
  
protected:
  cv::VideoCapture inputStream;
};

vpStream::vpStream(int cam) {
  this->inputStream.open(cam);
  
  if (!this->inputStream.isOpened()) {
    throw std::range_error("Could not open video stream.");
  }
  
  this->dim = Rcpp::NumericVector::create(this->inputStream.get(CV_CAP_PROP_FRAME_HEIGHT), 
                                          this->inputStream.get(CV_CAP_PROP_FRAME_WIDTH));
}

void vpStream::nextFrame() {
  this->inputStream >> this->frame;
}

void vpStream::release() {
  this->inputStream.release();
}
