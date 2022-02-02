#' @export
print.align_mat <- function(x, ...) {
  print_align_mat(x, ...)
}

#' @keywords internal
print_align_mat <- function(x, line_width = 50, poi = NULL, ...) {

  alignment <- x

  # Highlighting positions of interest.
  if(!is.null(poi) && rlang::is_integerish(poi)) {
    if(!all(dplyr::between(poi, 1, ncol(alignment)))) {
      stop('For this alignment, `poi` values must be between ', 1, ' and ', ncol(alignment), '.')
    }
    alignment[, poi] <- crayon::bold(alignment[, poi])
  }

  split_alignment <- split_by_width(alignment = alignment, line_width = line_width)
  annotations <- line_annotation(alignment = alignment, line_width = line_width)
  annotated_split_alignment <- matrix(paste(annotations, split_alignment), nrow = nrow(split_alignment))

  annotated_split_alignment2 <- annotated_split_alignment
  nr <- nrow(annotated_split_alignment)
  nc <- ncol(annotated_split_alignment)

  # Adding newline between blocks
  for(j in seq_len(ncol(annotated_split_alignment) - 1L)) {
    annotated_split_alignment2[nr, j] <- paste(annotated_split_alignment[nr, j], '\n')
  }

  cat(annotated_split_alignment2, sep = '\n')
  invisible(x)
}

