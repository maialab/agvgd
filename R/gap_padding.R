gap_padding <- function(x, len, gap = '-') {
  n <- length(x)
  n_gaps <- max(0, len - n)
  c(x, rep(gap, n_gaps))
}
