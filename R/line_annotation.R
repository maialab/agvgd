#' @importFrom rlang .data
line_annotation <- function(alignment, line_width) {

  seq_names <- pad_seq_names(safe_rownames(alignment))
  starts <- line_start_positions(alignment = alignment, line_width = line_width)
  pad <- number_width(starts) + 1
  fmt <- paste0('%s% ', pad, 'd')

  expand.grid(seq = seq_names, start = starts) %>%
    dplyr::mutate(annotation = sprintf(fmt, .data$seq, .data$start)) %>%
    dplyr::pull(.data$annotation)
}
