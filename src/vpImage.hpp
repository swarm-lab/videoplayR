class vpImage {
public:
  vpImage(std::string filename);
  vpImage(cv::Mat cv_image);
  arma::cube img2r();
  cv::Mat image;
  std::string type;
  Rcpp::NumericVector dim;
  
protected:
  void setImgType();
  std::string getImgType(int imgTypeInt);
};

vpImage::vpImage(std::string filename) {
  this->image = cv::imread(filename);
  
  if (!this->image.data) {
    throw std::range_error("Could not open the image file.");
  }
  
  this->setImgType();
  this->dim = Rcpp::NumericVector::create(this->image.rows, this->image.cols, this->image.channels());
}

vpImage::vpImage(cv::Mat cvImage) {
  this->image = cvImage;
  this->setImgType();
  this->dim = Rcpp::NumericVector::create(this->image.rows, this->image.cols, this->image.channels());
}

void vpImage::setImgType() {
  std::string imgType = this->getImgType(this->image.type());
  
  if (imgType == "CV_8UC3") {
    this->type = "rgb";
  } else if (imgType == "CV_8U") {
    double min, max;
    minMaxIdx(image, &min, &max);
    if (max > 1) {
      this->type = "grayscale";
    } else {
      this->type = "binary";
    }
  } else {
    this->type = "numeric";
  }
}

std::string vpImage::getImgType(int imgTypeInt) {
  int numImgTypes = 35; // 7 base types, with five channel options each (none or C1, ..., C4)
  
  int enum_ints[] = {CV_8U,  CV_8UC1,  CV_8UC2,  CV_8UC3,  CV_8UC4,
                     CV_8S,  CV_8SC1,  CV_8SC2,  CV_8SC3,  CV_8SC4,
                     CV_16U, CV_16UC1, CV_16UC2, CV_16UC3, CV_16UC4,
                     CV_16S, CV_16SC1, CV_16SC2, CV_16SC3, CV_16SC4,
                     CV_32S, CV_32SC1, CV_32SC2, CV_32SC3, CV_32SC4,
                     CV_32F, CV_32FC1, CV_32FC2, CV_32FC3, CV_32FC4,
                     CV_64F, CV_64FC1, CV_64FC2, CV_64FC3, CV_64FC4};
  
  std::string enum_strings[] = {"CV_8U",  "CV_8UC1",  "CV_8UC2",  "CV_8UC3",  "CV_8UC4",
                                "CV_8S",  "CV_8SC1",  "CV_8SC2",  "CV_8SC3",  "CV_8SC4",
                                "CV_16U", "CV_16UC1", "CV_16UC2", "CV_16UC3", "CV_16UC4",
                                "CV_16S", "CV_16SC1", "CV_16SC2", "CV_16SC3", "CV_16SC4",
                                "CV_32S", "CV_32SC1", "CV_32SC2", "CV_32SC3", "CV_32SC4",
                                "CV_32F", "CV_32FC1", "CV_32FC2", "CV_32FC3", "CV_32FC4",
                                "CV_64F", "CV_64FC1", "CV_64FC2", "CV_64FC3", "CV_64FC4"};
  
  for(int i=0; i<numImgTypes; i++) {
    if(imgTypeInt == enum_ints[i]) return enum_strings[i];
  }
  return "unknown image type";
}

arma::cube vpImage::img2r() {
  arma::cube r_image;
  
  switch (this->image.channels()) {
    case 1:
      r_image.set_size(this->image.rows, this->image.cols, 1);
      
      for(int i = 0; i < this->image.rows; i++) {
        for(int j = 0; j < this->image.cols; j++) {
          r_image(i, j, 0) = this->image.at<uint8_t>(i, j);
        }
      }
      return(r_image);
      
    case 3:
      r_image.set_size(this->image.rows, this->image.cols, 3);
      
      for(int i = 0; i < this->image.rows; i++) {
        for(int j = 0; j < this->image.cols; j++) {
          r_image(i, j, 0) = this->image.at<cv::Vec3b>(i, j)[2];
          r_image(i, j, 1) = this->image.at<cv::Vec3b>(i, j)[1];
          r_image(i, j, 2) = this->image.at<cv::Vec3b>(i, j)[0];
        }
      }
      return(r_image);
      
    default:
      throw std::range_error("Cannot convert this image to an R matrix or array.");
      break;
  }
} 
