load_video <- function(filename) {
  mod <- Module("vp", PACKAGE = "videoplayR")
  new(mod$Video, normalizePath(filename))
}