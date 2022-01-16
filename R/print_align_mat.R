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

#' #' @keywords internal
#' print_align_mat <- function(x, line_width = 100, ...) {
#'
#'   x <- remove_align_mat_class(x)
#'   pretty_alignment(x, line_width = line_width)
#'   invisible(x)
#' }

# str_partition <- function(x, line_width = 30) {
#
#   n_chars <- length(x)
#   if(n_chars <= line_width)
#     return(list(x))
#
#   n_lines <- n_chars %/% line_width
#   last_line_width <- n_chars %% line_width
#
#   f <- c(rep(seq_len(n_lines), each = line_width), rep(n_lines + 1, last_line_width))
#
#   split(x, f)
#
# }
#
# alignment_lines <- function(x, line_width = 30) {
#   str_part <- str_partition(x, line_width = line_width)
#   purrr::map_chr(str_part, ~ paste(., collapse = ''))
# }
#
# # `x` is a vector of strings
# pretty_alignment_block <- function(x, start, pad) {
#   fmt <- paste0('% ', pad, 'd', ' ')
#
#   # `seq_names_fmt`: pretty sequence names padded with spaces on the right side.
#   seq_names_fmt <- pretty_seq_names(names(x))
#   lines <- paste(seq_names_fmt, sprintf(fmt, start),  x, '\n', sep = '')
#
#   # lines_with_newline <- paste0(paste0(lines, collapse = '\n'), collapse = '\n')
#   lines_with_newline <- paste0(paste0(lines, collapse = ''), collapse = '\n')
#
#   lines_with_newline
#   #paste0(lines_with_newline[length(lines_with_newline)], '\n\n')
# }
#
# # Returns a matrix of "alignment lines"
# # Rows are alignment lines
# # Columns are species (named)
# #
# alignment <- function(m, line_width = 30) {
#   m2 <- t(apply(m, 1, alignment_lines, line_width))
#
#   m2
# }
#
# pretty_alignment <- function(m, line_width = 30) {
#   m2 <- alignment(m, line_width = line_width)
#
#   start_positions <- cumsum(rep(line_width, ncol(m2))) - (line_width - 1)
#   pad <- nchar(as.character(start_positions[length(start_positions)])) + 1
#   # blocks <- apply(m2, 2, pretty_alignment_block, start = 1, pad = 3)
#
#   lst2 <- lapply(seq_len(ncol(m2)), function(i) m2[, i])
#   #lst2 <- matrix_to_list(m2)
#
#
#   blocks <- purrr::map2_chr(.x = lst2, .y = start_positions, pretty_alignment_block, pad = pad)
#
#   # return(blocks)
#   cat(blocks, sep = '\n')
#   # cat(blocks, sep = 'X')
# }
#
# pretty_seq_names <- function(x, width = Inf) {
#   len <- nchar(x)
#   max_len <- min(width, max(len))
#
#   x1 <- substring(x, 1, max_len)
#   x2 <- stringr::str_pad(x1, width = max_len, side = 'right')
#
#   return(x2)
# }
