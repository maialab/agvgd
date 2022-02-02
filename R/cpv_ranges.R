#' Determine CPV ranges
#'
#' @description
#' This function determines the range (minimum and maximum) values for the three
#' amino acid side chain property values --- composition, polarity and molecular
#' volume --- from the amino acids at the alignment position of interest.
#'
#' The alignment passed in `alignment` must be an already focused alignment of
#' three columns whose second column is the position of interest.
#'
#' @param alignment A character matrix or an alignment object obtained with
#'   [read_alignment()]. Rows are expected to be sequences of single characters
#'   (protein residues), and columns the alignment positions. The first row must
#'   be the reference sequence, i.e. the sequence whose substitutions will be
#'   evaluated against.
#' @param exclude A vector of character values to be ignored when collecting the
#'   amino acids at the position of interest.
#'
#' @return A [tibble][tibble::tibble-package] with one single row, of six
#'   variables, i.e., the minimum and maximum values for composition (`c_min`
#'   and `c_max`), polarity (`p_min` and `p_max`) and molecular volume (`v_min`
#'   and `v_max`).
#'
#' @examples
#' # You need to first focus the alignment around the position of interest. The
#' # position of interest is position 4 in the example below. After subsetting
#' # the alignment, it becomes position 2.
#' alignment <- read_alignment('ATM')
#'
#' alignment[, 3:5]
#'
#' cpv_ranges(alignment[, 3:5])
#'
#' # If at the position of interest there are symbols other than amino acid
#' # symbols, e.g. gaps ("-"), then these are ignored and the calculated ranges
#' # are based only on the observed amino acids.
#' alignment[, 270:272]
#'
#' cpv_ranges(alignment[, 270:272])
#'
#' @seealso [gv()]
#' @md
#' @importFrom rlang .data
#' @export
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
