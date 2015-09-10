SEXP ddd2d(SEXP image) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr( env.get(".pointer") );
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  if (o->image.channels() != 3) {
    throw std::range_error("This image does not have exactly 3 channels.");
  } else {
    cv::Mat d;
    cv::cvtColor(o->image, d, cv::COLOR_BGR2GRAY);
    
    Rcpp::XPtr<vpImage> ptr(new vpImage(d), true);
    Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
    return maker (typeid(vpImage).name(), ptr);
  }
}

SEXP d2ddd(SEXP image) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr( env.get(".pointer") );
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  if (o->image.channels() != 1) {
    throw std::range_error("This image does not have exactly 1 channel.");
  } else {
    cv::Mat d;
    cv::cvtColor(o->image, d, cv::COLOR_GRAY2BGR);
    
    Rcpp::XPtr<vpImage> ptr(new vpImage(d), true);
    Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
    return maker (typeid(vpImage).name(), ptr);
  }
}

SEXP thresholding(SEXP image, double thres, std::string type) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr( env.get(".pointer") );
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  cv::Mat toBin;
  cv::Mat bin;
  
  if (o->image.channels() > 1) {
    cv::cvtColor(o->image, toBin, cv::COLOR_BGR2GRAY);
  } else {
    toBin = o->image;
  }
  
  if (type == "binary") {
    cv::threshold(toBin, bin, thres, 1, 0);
  } else if (type == "inverted") {
    cv::threshold(toBin, bin, thres, 1, 1);
  } else {
    throw std::range_error("Unknown thresholding type.");
  }
  
  Rcpp::XPtr<vpImage> ptr(new vpImage(bin), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpImage).name(), ptr);
}

SEXP blend(SEXP image1, SEXP image2, std::string operation) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj1(image1);
  Rcpp::S4 s4obj2(image2);
  
  if (!s4obj1.is(rtypename.c_str()) || !s4obj2.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env1(s4obj1), env2(s4obj2);
  Rcpp::XPtr<vpImage> xptr1(env1.get(".pointer"));
  Rcpp::XPtr<vpImage> xptr2(env2.get(".pointer"));
  vpImage *o1 = static_cast<vpImage*> (R_ExternalPtrAddr(xptr1));
  vpImage *o2 = static_cast<vpImage*> (R_ExternalPtrAddr(xptr2));
  
  cv::Mat res;
  
  if (operation == "+" || operation == "addition") {
    cv::add(o1->image, o2->image, res);
  } else if (operation == "-" || operation == "subtraction") {
    cv::subtract(o1->image, o2->image, res);
  } else if (operation == "*" || operation == "multiplication") {
    cv::multiply(o1->image, o2->image, res);
  } else if (operation == "/" || operation == "division") {
    cv::divide(o1->image, o2->image, res);
  } else {
    throw std::range_error("This operation is not supported.");
  }
  
  Rcpp::XPtr<vpImage> ptr(new vpImage(res), true);
  Rcpp::Function maker = Rcpp::Environment::Rcpp_namespace()["cpp_object_maker"];
  return maker (typeid(vpImage).name(), ptr);
}

Rcpp::NumericVector ellipse(std::vector<cv::Point> points) {
  int n = points.size();
  arma::mat M(n, 2); 
  for (int i = 0; i < points.size(); ++i) {
    M(i, 0) = points[i].x;
    M(i, 1) = points[i].y;
  }
  
  double xC = arma::mean(M.col(0));
  double yC = arma::mean(M.col(1));
  
  arma::mat covMat = cov(M);
  
  arma::vec eigval;
  arma::mat eigvec;
  arma::eig_sym(eigval, eigvec, covMat);
  arma::uvec eigidx = arma::sort_index(eigval);
  
  double alpha = atan(eigvec(1, 1) / eigvec(0, 1));
  
  double a, b;
  if (eigidx(0) == 0) {
    a = sqrt(2 * eigval(1) * R::qf(0.99, 2, n - 1, 1, 0));
    b = sqrt(2 * eigval(0) * R::qf(0.99, 2, n - 1, 1, 0));
  } else {
    a = sqrt(2 * eigval(0) * R::qf(0.99, 2, n - 1, 1, 0));
    b = sqrt(2 * eigval(1) * R::qf(0.99, 2, n - 1, 1, 0));
  }
  
  return Rcpp::NumericVector::create(Rcpp::_["xC"] = xC, Rcpp::_["yC"] = yC, 
                                     Rcpp::_["alpha"] = alpha, Rcpp::_["a"] = a, Rcpp::_["b"] = b);
}

Rcpp::DataFrame blobDetector(SEXP image) {
  std::string rtypename("Rcpp_vpImage");
  Rcpp::S4 s4obj(image);
  
  if (!s4obj.is(rtypename.c_str())) {
    Rf_error((std::string("object is not of the type ")+rtypename).c_str());
  }
  
  Rcpp::Environment env(s4obj);
  Rcpp::XPtr<vpImage> xptr(env.get(".pointer"));
  vpImage *o = static_cast<vpImage*> (R_ExternalPtrAddr(xptr));
  
  std::vector<std::vector<cv::Point> > contours;
  cv::findContours(o->image.clone(), contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
  
  int n = contours.size();
  Rcpp::NumericVector id(n), x(n), y(n), area(n), alpha(n), major(n), minor(n);
  cv::RotatedRect ell;
  for (int i = 0; i < n; ++i) {
    ell = cv::minAreaRect(contours[i]);
    id[i] = i + 1;
    x[i] = ell.center.x;
    y[i] = -ell.center.y + o->dim[0];
    
    if (ell.size.height > ell.size.width) {
      alpha[i] = -ell.angle - 90;
      major[i] = ell.size.height;
      minor[i] = ell.size.width;
    } else {
      alpha[i] = -ell.angle;
      major[i] = ell.size.width;
      minor[i] = ell.size.height;
    }
    
    area[i] = cv::contourArea(contours[i]); 
  }
  
  return(Rcpp::DataFrame::create(Rcpp::_("id") = id, Rcpp::_("x") = x, Rcpp::_("y") = y, 
                                         Rcpp::_("alpha") = alpha, Rcpp::_("major") = major,
                                         Rcpp::_("minor") = minor, Rcpp::_("area") = area));
}



















