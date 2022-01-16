as_three_letter <- function(x) {

  y <- x
  # grantham::as_three_letter converts "-" and "X" to NA,
  # align_gvgd::as_three_letter preserves them.
  y <- grantham::as_three_letter(x)
  y[x == '-'] <- '-'
  y[x == 'X'| x == 'x'] <- 'X'

  return(y)
}
