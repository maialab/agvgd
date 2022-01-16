nr_lines_per_seq <- function(alignment, line_width) {

  ncol(alignment) %/% line_width + as.logical(ncol(alignment) %% line_width)
}
