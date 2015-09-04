SEXP _readImg(std::string filename) {
  cv::Mat cvImage = cv::imread(filename);

  Rcpp::XPtr<vpImage> ptr(new vpImage::vpImage(cvImage), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpImage).name(), ptr);
}

void _writeImg(std::string filename, SEXP image) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr( env.get(".pointer") );
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  imwrite(filename, o->image);
}

SEXP _readVid(std::string filename) {
  Rcpp::XPtr<vpVideo> ptr(new vpVideo::vpVideo(filename), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpVideo).name(), ptr);
}

SEXP getFrame(SEXP video, int frame) {
  std::string rtypename("Rcpp_vpVideo");
  Rcpp::S4 s4obj(video);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpVideo> xptr( env.get(".pointer") );
  vpVideo *o = static_cast<vpVideo*> (R_ExternalPtrAddr(xptr));
  
  o->setFrame(frame);
  cv::Mat image = o->frame;
  
  Rcpp::XPtr<vpImage> ptr(new vpImage::vpImage(image), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpImage).name(), ptr);
}

arma::cube _img2r(SEXP image) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr( env.get(".pointer") );
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  arma::cube r_image;
  
  switch (o->image.channels()) {
  case 1:
    r_image.set_size(o->image.rows, o->image.cols, 1);
    
    if (o->type == "numeric") {
      for(int i = 0; i < o->image.rows; i++) {
        for(int j = 0; j < o->image.cols; j++) {
          r_image(i, j, 0) = o->image.at<double>(i, j);
        }
      }
    } else {
      for(int i = 0; i < o->image.rows; i++) {
        for(int j = 0; j < o->image.cols; j++) {
          r_image(i, j, 0) = o->image.at<uint8_t>(i, j);
        }
      }
    }
    
    return(r_image);
    
  case 3:
    r_image.set_size(o->image.rows, o->image.cols, 3);
    if (o->type == "numeric") {
      for(int i = 0; i < o->image.rows; i++) {
        for(int j = 0; j < o->image.cols; j++) {
          r_image(i, j, 0) = o->image.at<cv::Vec3d>(i, j)[2];
          r_image(i, j, 1) = o->image.at<cv::Vec3d>(i, j)[1];
          r_image(i, j, 2) = o->image.at<cv::Vec3d>(i, j)[0];
        }
      }
    } else {
      for(int i = 0; i < o->image.rows; i++) {
        for(int j = 0; j < o->image.cols; j++) {
          r_image(i, j, 0) = o->image.at<cv::Vec3b>(i, j)[2];
          r_image(i, j, 1) = o->image.at<cv::Vec3b>(i, j)[1];
          r_image(i, j, 2) = o->image.at<cv::Vec3b>(i, j)[0];
        }
      }
    }
    
    return(r_image);
    
  default:
    throw std::range_error("Cannot convert this image to an R matrix or array.");
  break;
  }
} 

SEXP r2img(Rcpp::NumericVector array, bool numeric) {
  Rcpp::IntegerVector arrayDims = array.attr("dim");
  int nDims = arrayDims.size();
  cv::Mat cvImage;
  
  if (nDims == 2) {
    if (numeric) {
      cvImage.create(arrayDims[0], arrayDims[1], CV_64FC1);
      for(int i = 0; i < arrayDims[0]; i++) {
        for(int j = 0; j < arrayDims[1]; j++) {
          cvImage.at<double>(i, j) = array[arrayDims[0] * j + i];
        }
      }
    } else {
      cvImage.create(arrayDims[0], arrayDims[1], CV_8UC1);
      Rcpp::IntegerVector arrayInt = Rcpp::as<Rcpp::IntegerVector>(array);
      for(int i = 0; i < arrayDims[0]; i++) {
        for(int j = 0; j < arrayDims[1]; j++) {
          cvImage.at<uint8_t>(i, j) = (uint8_t)arrayInt[arrayDims[0] * j + i];
        }
      }
    }
    
  } else if (nDims == 3) {
    if (numeric) {
      cvImage.create(arrayDims[0], arrayDims[1], CV_64FC3);
      for(int i = 0; i < arrayDims[0]; i++) {
        for(int j = 0; j < arrayDims[1]; j++) {
          cvImage.at<cv::Vec3d>(i, j)[2] = (double_t)array[arrayDims[0] * j + i];
          cvImage.at<cv::Vec3d>(i, j)[1] = (double_t)array[(arrayDims[0] * j + i) + arrayDims[0] * arrayDims[1]];
          cvImage.at<cv::Vec3d>(i, j)[0] = (double_t)array[(arrayDims[0] * j + i) + 2 * arrayDims[0] * arrayDims[1]];
        }
      }
    } else {
      cvImage.create(arrayDims[0], arrayDims[1], CV_8UC3);
      Rcpp::IntegerVector arrayInt = Rcpp::as<Rcpp::IntegerVector>(array);
      for(int i = 0; i < arrayDims[0]; i++) {
        for(int j = 0; j < arrayDims[1]; j++) {
          cvImage.at<cv::Vec3b>(i, j)[2] = (uint8_t)arrayInt[arrayDims[0] * j + i];
          cvImage.at<cv::Vec3b>(i, j)[1] = (uint8_t)arrayInt[(arrayDims[0] * j + i) + arrayDims[0] * arrayDims[1]];
          cvImage.at<cv::Vec3b>(i, j)[0] = (uint8_t)arrayInt[(arrayDims[0] * j + i) + 2 * arrayDims[0] * arrayDims[1]];
        }
      }
    }
  } else {
    throw std::range_error("The array must 2 or 3 dimensional.");
  }
  
  Rcpp::XPtr<vpImage> ptr(new vpImage::vpImage(cvImage), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpImage).name(), ptr);
}
