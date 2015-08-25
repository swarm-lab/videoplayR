#include <RcppArmadillo.h>
// [[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;

template <typename T> int sign(T val) {
  return (T(0) < val) - (val < T(0));
}

// [[Rcpp::export]]
arma::umat bresenham_line(double x1, double y1, double z1,
double x2, double y2, double z2) {
  arma::vec vertex(3, arma::fill::zeros);
  vertex(0) = x1;
  vertex(1) = y1;
  vertex(2) = z1;
  
  double dx = x2 - x1;
  double dy = y2 - y1;
  double dz = z2 - z1;
  
  double delta = 1;
  double x_inc = delta * sign(dx);
  double l = std::abs(dx) / delta;
  
  double y_inc = delta * sign(dy);
  double m = std::abs(dy) / delta;
  
  double z_inc = delta * sign(dz);
  double n = std::abs(dz) / delta;
  
  double dx2 = 2 * l;
  double dy2 = 2 * m;
  double dz2 = 2 * n;
  
  double err_1, err_2;
  int ii;
  arma::umat Mat;
  if ((l >= m) && (l >= n)) {
    err_1 = dy2 - l;
    err_2 = dz2 - l;
    Mat.set_size(l + 1, 3);
    Mat.fill(0);
    ii = 0;
    for (int i = 0; i < l; i++) {
      Mat(ii, 0) = vertex(0);
      Mat(ii, 1) = vertex(1);
      Mat(ii, 2) = vertex(2);
      if (err_1 > 0) {
        vertex(1) = vertex(1) + y_inc;
        err_1 = err_1 - dx2;
      }
      if (err_2 > 0) {
        vertex(2) = vertex(2) + z_inc;
        err_2 = err_2 - dx2;
      }
      err_1 = err_1 + dy2;
      err_2 = err_2 + dz2;
      vertex(0) = vertex(0) + x_inc;
      ii += 1;
    }
  }
  else if ((m >= l) && (m >= n)) {
    err_1 = dx2 - m;
    err_2 = dz2 - m;
    Mat.set_size(m + 1, 3);
    Mat.fill(0);
    ii = 0;
    for (int i = 0; i < m; i++) {
      Mat(ii, 0) = vertex(0);
      Mat(ii, 1) = vertex(1);
      Mat(ii, 2) = vertex(2);
      if (err_1 > 0) {
        vertex(0) = vertex(0) + x_inc;
        err_1 = err_1 - dy2;
      }
      if (err_2 > 0) {
        vertex(2) = vertex(2) + z_inc;
        err_2 = err_2 - dy2;
      }
      err_1 = err_1 + dx2;
      err_2 = err_2 + dz2;
      vertex(1) = vertex(1) + y_inc;
      ii += 1;
    }
  }
  else {
    err_1 = dy2 - n;
    err_2 = dx2 - n;
    Mat.set_size(n + 1, 3);
    Mat.fill(0);
    ii = 0;
    for (int i = 0; i < n; i++) {
      Mat(ii, 0) = vertex(0);
      Mat(ii, 1) = vertex(1);
      Mat(ii, 2) = vertex(2);
      if (err_1 > 0) {
        vertex(1) = vertex(1) + y_inc;
        err_1 = err_1 - dz2;
      }
      if (err_2 > 0) {
        vertex(0) = vertex(0) + x_inc;
        err_2 = err_2 - dz2;
      }
      err_1 = err_1 + dy2;
      err_2 = err_2 + dx2;
      vertex(1) = vertex(2) + z_inc;
      ii += 1;
    }
  }
  Mat(ii, 0) = vertex(0);
  Mat(ii, 1) = vertex(1);
  Mat(ii, 2) = vertex(2);
  
  return(Mat);
}

// [[Rcpp::export]]
NumericVector ellipse(arma::vec x, arma::vec y) {
  arma::mat M(x.n_elem, 2); 
  M.col(0) = x;
  M.col(1) = y;
  
  double xC = arma::mean(x);
  double yC = arma::mean(y);
  
  arma::mat covMat = cov(M);
  
  arma::vec eigval;
  arma::mat eigvec;
  arma::eig_sym(eigval, eigvec, covMat);
  arma::uvec eigidx = arma::sort_index(eigval);
    
  double alpha = atan(eigvec(1, 1) / eigvec(0, 1));
  
  double a, b;
  if (eigidx(0) == 0) {
    a = sqrt(2 * eigval(1) * R::qf(0.99, 2, x.n_elem - 1, 1, 0));
    b = sqrt(2 * eigval(0) * R::qf(0.99, 2, x.n_elem - 1, 1, 0));
  } else {
    a = sqrt(2 * eigval(0) * R::qf(0.99, 2, x.n_elem - 1, 1, 0));
    b = sqrt(2 * eigval(1) * R::qf(0.99, 2, x.n_elem - 1, 1, 0));
  }
  
  return NumericVector::create(_["xC"] = xC, _["yC"] = yC, _["alpha"] = alpha, _["a"] = a, _["b"] = b);
}



