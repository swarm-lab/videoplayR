load_video <- function(filename) {
  mod <- Module("Video", PACKAGE = "videoplayR")
  new(mod$Video, normalizePath(filename))
}