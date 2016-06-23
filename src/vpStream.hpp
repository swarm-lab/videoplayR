class vpStream {
public:
  vpStream(int cam);
  void nextFrame();
  void release();
  void set(std::string property, double value);
  cv::Mat frame;
  Rcpp::NumericVector dim;
  double brightness, contrast, saturation, hue, gain, exposure; 

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
  this->brightness = this->inputStream.get(CV_CAP_PROP_BRIGHTNESS);
  this->contrast = this->inputStream.get(CV_CAP_PROP_CONTRAST);
  this->saturation = this->inputStream.get(CV_CAP_PROP_SATURATION);
  this->hue = this->inputStream.get(CV_CAP_PROP_HUE);
  this->gain = this->inputStream.get(CV_CAP_PROP_GAIN);
  this->exposure = this->inputStream.get(CV_CAP_PROP_EXPOSURE);
}

void vpStream::nextFrame() {
  this->inputStream >> this->frame;
}

void vpStream::release() {
  this->inputStream.release();
}

void vpStream::set(std::string property, double value) {
  if (property.compare("brightness") == 0) {
    this->inputStream.set(CV_CAP_PROP_BRIGHTNESS, value);
    this->brightness = this->inputStream.get(CV_CAP_PROP_BRIGHTNESS);
  } else if (property.compare("contrast") == 0) {
    this->inputStream.set(CV_CAP_PROP_CONTRAST, value);
    this->contrast = this->inputStream.get(CV_CAP_PROP_CONTRAST);
  } else if (property.compare("saturation") == 0) {
    this->inputStream.set(CV_CAP_PROP_SATURATION, value);
    this->saturation = this->inputStream.get(CV_CAP_PROP_SATURATION);
  } else if (property.compare("hue") == 0) {
    this->inputStream.set(CV_CAP_PROP_HUE, value);
    this->hue = this->inputStream.get(CV_CAP_PROP_HUE);
  } else if (property.compare("gain") == 0) {
    this->inputStream.set(CV_CAP_PROP_GAIN, value);
    this->gain = this->inputStream.get(CV_CAP_PROP_GAIN);
  } else if (property.compare("exposure") == 0) {
    this->inputStream.set(CV_CAP_PROP_EXPOSURE, value);
    this->exposure = this->inputStream.get(CV_CAP_PROP_EXPOSURE);
  } else {
    throw std::range_error("This property is not supported.");
  }
}









