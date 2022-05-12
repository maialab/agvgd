#' Generate and export a list of substitutions
#'
#' This function exports to a file a list of residue substitutions. The format
#' used will be  the same one as requested by the web version of
#' [Align-GVGD](http://agvgd.hci.utah.edu/help.php).
#'
#' @param file A file path.
#' @param alignment A character matrix or an alignment object obtained with
#'   [read_alignment()]. Rows are expected to be sequences of single characters
#'   (protein residues), and columns the alignment positions. The first row must
#'   be the reference sequence, i.e. the sequence whose substitutions will be
#'   evaluated against.
#' @param poi A whole number indicating the position of interest (POI).
#' @param sub A character vector of protein residue substitutions to be
#'   classified. The amino acids must be provided as one-letter symbols.
#' @param mode If both `poi` and `sub` contain more than one element, `mode`
#'   specifies how these two inputs are combined. If `mode = 'recycle'` the
#'   shortest vector is recycled to match the length of the longest. If `mode =
#'   'expand_grid'`, all combinations between elements of `poi` and `sub` are
#'   combined.
#'
#' @return This function is run for its side effect of writing a file. But it
#'   returns the file path passed in `file`.
#'
#' @examples
#' \dontshow{
#' .old_wd <- setwd(tempdir())
#' }
#' write_substitutions(file = "ex01.csv",
#'                     alignment = read_alignment("ATM"),
#'                     poi = 20:25,
#'                     sub = amino_acids())
#' cat(readLines("ex01.csv"), sep = "\n")
#'
#' write_substitutions(file = "ex02.csv",
#'                     alignment = read_alignment("ATM"),
#'                     poi = 20:21,
#'                     sub = amino_acids(),
#'                     mode = 'expand_grid')
#' cat(readLines("ex02.csv"), sep = "\n")
#' \dontshow{
#' setwd(.old_wd)
#' }
#' @md
#' @export
write_substitutions <- function(file,
                                alignment,
                                poi,
                                sub,
                                mode = c('recycle', 'expand_grid')) {

  mode <- match.arg(mode)

  if(!rlang::is_integerish(poi))
    stop('`poi` can\'t be interpreted as a set of alignment positions.')

  if(!are_all_one_letter(sub))
    stop('`sub` must be a character vector of one-letter amino acid codes.')

  # We allow `poi` to be a double if it is integerish, here we convert it
  # to integer to make it formally an integer in case it was a double.
  poi <- as.integer(poi)

  if (identical(mode, 'recycle')) {
    n <- max(length(poi), length(sub))
    poi <- rep(poi, length.out = n)
    sub <- rep(sub, length.out = n)
    tbl <- tidyr::tibble(poi = poi, sub = sub)

  } else { # expand_grid (cartesian product)
    tbl <- tidyr::expand_grid(poi, sub)
  }

  # Check if there are gaps are being referred to by the alignment positions
  # `poi`
  is_gap <- is_poi_a_gap(alignment, tbl$poi)
  are_there_gaps <- any(is_gap)

  if (are_there_gaps)
    stop(
      'The positions ',
      glue::glue_collapse(glue::glue("{tbl$poi[is_gap]}"), sep = " ", last = ' and '),
      ' correspond to gaps and hence do not translate to substitutions. ',
      'Please check the positions being passed in `poi`.'
    )

  # `res` will contain NA if `poi` is a gap ("-")
  res <- poi_to_res(alignment, tbl$poi)

  # Extract aminoacids from the reference sequence
  ref <- alignment[1, tbl$poi]

  # `substitutions` is of the form "M1775K"
  substitutions <- paste0(ref, res, tbl$sub)

  # Drop invalid substitutions, i.e. substitutions that would apply to a
  # reference residue that is a gap.
  substitutions <- substitutions[!is.na(res)]

  writeLines(substitutions, con = file)

  return(file)
}
