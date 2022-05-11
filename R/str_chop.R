#' Chop a string into sub-strings of fixed width
#'
#' @param x A single string. This function is not vectorised, so `x` must be of
#'   length 1.
#' @param width Length of the chopped pieces.
#'
#' @return A character vector of sub-strings of length `width`.
#'
#' @md
#' @keywords internal
str_chop <- function(x, width = 50) {

  if(!(is.character(x) && identical(length(x), 1L)))
    stop("`x` must be a scalar string.")

  if (width < 1)
    stop("`width` must be a positive whole number.")

  if(identical(nchar(x), 0L))
    return(character())

  substring(x, seq(1, nchar(x), width), seq(width, nchar(x) + width - 1, width))
}
