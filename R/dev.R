#' Deviation function
#'
#' @description
#' This function calculates the deviation in the sense of the Grantham deviation
#' as introduced by Tavtigian et al. (2006). Essentially, if `x` lies within the
#' range \[`min`, `max`\], then `dev()` returns 0. If `x` is either below `min`, or
#' above `max`, then `dev()` returns the absolute difference between `x` and
#' `min` or `max`, respectively.
#'
#' \if{html}{\figure{dev-def.svg}{dev definition}}
#' \if{latex}{\figure{dev-def.png}{options: width=0.5in}}
#'
#' Inputs are recycled in the sense of [vctrs::vec_recycle()].
#'
#' @details
#' Here's a plot showcasing `dev()` with `min = -4` and `max = 3`:
#'
#' ```{r dev-plot, fig.asp=2/(1+sqrt(5))}
#' x <- -10:10; min <- -4; max <- 3
#' plot(x, y = dev(x, min, max), type = 'l', xlab = 'x', ylab = 'deviation')
#' ```
#'
#' @param x A numeric vector.
#' @param min A numeric vector.
#' @param max A numeric vector.
#'
#' @return A numeric vector of deviations.
#'
#' @examples
#' # `dev()` returns absolute differences from either min or max (whichever is
#' # closest).
#' dev(10, min = -4, max = 4)
#' dev(-10, min = -4, max = 4)
#'
#' # `x` can be a vector
#' dev(-10:10, min = -4, max = 4)
#'
#' # `min` and `max` can also be vectors, they will be recycled
#' dev(-10:10, min = -4:16, max = 4:24)
#'
#' # If `x` contains `NA` values, then `dev()` will return `NA` for
#' # those cases
#' dev(c(10, NA), min = -4, max = 4)
#'
#' # For each calculation of deviation, only either `min` or `max` is used. If
#' # the unused parameter is `NA` it won't affect the calculation:
#' dev(c(10, 3), min = c(NA, -4), max = 4)
#' dev(c(10, -5), min = -4, max = c(4, NA))
#'
#' @seealso [gd()]
#' @md
#' @export
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
