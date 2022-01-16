pad_seq_names <- function(x, width = Inf) {
  len <- nchar(x)
  max_len <- min(width, max(len))

  x1 <- substring(x, 1, max_len)
  x2 <- stringr::str_pad(x1, width = max_len, side = 'right')

  return(x2)
}
