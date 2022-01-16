#' @importFrom rlang .data
#' @keywords internal
cpv_ranges <- function(alignment, exclude = c('-', 'X', NA_character_)) {

  m <- remove_align_mat_class(alignment)

  x <- as_three_letter(m[, 2])
  x_tbl <- tibble::tibble(amino_acid = x) %>%
    dplyr::filter(!(.data$amino_acid %in% exclude)) # Remove gaps ("-") and unknown amino acids ("X")

  grantham::amino_acids_properties %>%
    dplyr::right_join(x_tbl, by = 'amino_acid') %>%
    dplyr::summarise(
      c_min = min(.data$c),
      c_max = max(.data$c),
      p_min = min(.data$p),
      p_max = max(.data$p),
      v_min = min(.data$v),
      v_max = max(.data$v)
    )
}
