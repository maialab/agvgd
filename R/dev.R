dev <- function(x, min, max) {

  lst <- vctrs::vec_recycle_common(x = x, min = min, max = max)
  x <- lst$x
  min <- lst$min
  max <- lst$max

  # If any of the three inputs is NA, then the final result will be NA.
  is_na <- is.na(x) | is.na(min) | is.na(max)

  x_below_min <- x < min & !(is.na(x) | is.na(min))
  x_above_max <- x > max & !(is.na(x) | is.na(max))

  y <- x
  y[is_na] <- NA_real_
  y[x_below_min] <- min[x_below_min] - x[x_below_min]
  y[x_above_max] <- x[x_above_max] - max[x_above_max]
  y[!(is_na|x_below_min|x_above_max)] <- 0

  return(y)
}
