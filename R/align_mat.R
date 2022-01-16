#' @export
`[.align_mat` <- function(x, i, j, ...) {
  structure(NextMethod('[', drop = FALSE), class = "align_mat")
}

remove_align_mat_class <- function(m) {
  m_classes <- class(m)
  if ('align_mat' %in% m_classes) {
    class(m) <- setdiff(class(m), 'align_mat')
  }
  return(m)
}

add_align_mat_class <- function(m) {
  m_classes <- class(m)
  if (!('align_mat' %in% m_classes)) {
    class(m) <- c('align_mat', class(m))
  }
  return(m)
}

is_align_mat_class <- function(m) {
  'align_mat' %in% class(m)
}
