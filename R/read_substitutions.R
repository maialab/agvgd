#' Read a file with amino acid substitutions
#'
#' This function reads a file with amino acid substitutions. The format of
#' should be the same one as requested by the web version of
#' [Align-GVGD](http://agvgd.hci.utah.edu/help.php).
#'
#' @param file The path to a file with amino acid substitutions.
#' @param amino_acid_code The type of symbol used for amino acids in the returned output.
#'
#' @return A tibble listing the amino acids substitutions.
#'
#' @md
#'
#' @importFrom rlang .data
#' @export
read_substitutions <- function(file = stop('`file` must be specified'), amino_acid_code = c('one_letter', 'three_letter')) {

  # Read in all lines
  lines <- readLines(con = file)

  # Remove empty lines
  lines <- lines[lines != '']

  # Parse the substitutions
  subs <- unlist(strsplit(lines, split = ''))

  m <- matrix(subs, ncol = 3, byrow = TRUE)
  colnames(m) <- c('from','poi',  'to')

  tbl <- tibble::as_tibble(m) %>%
    dplyr::mutate(poi = as.integer(.data$poi)) %>%
    dplyr::relocate(.data$poi, .data$from, .data$to)

  value <- match.arg(value)

  if (identical(value, 'three_letter')) {
    tbl <- dplyr::mutate(tbl,
                  from = as_three_letter(.data$from),
                  to = as_three_letter(.data$to))
  }

  return(tbl)
}
