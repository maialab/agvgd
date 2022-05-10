#' @keywords internal
parse_substitutions <- function(x) {

  # Parse the substitutions
  ref <- substr(x, 1, 1)
  sub <- substr(x, nchar(x), nchar(x))
  res <- as.integer(substr(x, 2, nchar(x) - 1))

  # Assemble a data frame with the substitutions
  tbl <- tibble::tibble(res = res, poi = NA_integer_, ref = ref, sub = sub)

  return(tbl)
}


#' Read a file with amino acid substitutions
#'
#' This function reads a file with amino acid substitutions. The format of
#' should be the same one as requested by the web version of
#' [Align-GVGD](http://agvgd.hci.utah.edu/help.php).
#'
#' @param file The path to a file with amino acid substitutions.
#' @param amino_acid_code The type of symbol used for amino acids in the
#'   returned output.
#'
#' @return A [tibble][tibble::tibble-package] listing the amino acids
#'   substitutions.
#'
#' @examples
#' # "sub.txt" is an example file containing missense substitutions formatted
#' # according to the requirements indicated in http://agvgd.hci.utah.edu/help.php.
#' my_file <- system.file("extdata", "sub.txt", package = "agvgd")
#' cat(readLines(my_file), sep = "\n")
#'
#' read_substitutions(file = my_file)
#'
#' # lee2010_sub.txt is a file containing the missense variants studied by
#' # Lee et al. (2010): https://doi.org/10.1158/0008-5472.CAN-09-4563.
#' read_substitutions(file = system.file("extdata", "lee2010_sub.txt", package = "agvgd"))
#'
#' @md
#' @importFrom rlang .data
#' @export
read_substitutions <-
  function(file = stop('`file` must be specified'),
           amino_acid_code = c('one_letter', 'three_letter')) {

  # Read in all lines
  lines <- readLines(con = file)

  # Remove empty lines
  lines <- lines[lines != '']

  # # Parse the substitutions
  # ref <- substr(lines, 1, 1)
  # sub <- substr(lines, nchar(lines), nchar(lines))
  # poi <- as.integer(substr(lines, 2, nchar(lines) - 1))
  #
  # # Assemble a data frame with the substitutions
  # tbl <- tibble::tibble(poi = poi, ref = ref, sub = sub)
  tbl <- parse_substitutions(lines)

  amino_acid_code <- match.arg(amino_acid_code)

  if (identical(amino_acid_code, 'three_letter')) {
    tbl <- dplyr::mutate(tbl,
                  ref = as_three_letter(.data$ref),
                  sub = as_three_letter(.data$sub))
  }

  return(tbl)
}
