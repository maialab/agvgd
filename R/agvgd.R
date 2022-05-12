#' Align-GVGD (A-GVGD)
#'
#' @description
#' This function implements the Align-GVGD (A-GVGD) method described in
#' Tavtigian _et al._ (2006).
#'
#' A-GVGD combines multiple sequence alignment of orthologous sequences with the
#' Grantham distance to classify missense variants, i.e. to distinguish human
#' disease susceptibility missense changes from changes of little clinical
#' significance.
#'
#' The biochemical variation at each alignment position is converted to a
#' Grantham Variation score (GV) and the difference between these properties and
#' those of the variant amino acid being assessed are calculated and a Grantham
#' Difference score generated (GD).  The predicted effect is classed as C0, C15,
#' C25, C35, C45, C55, or C65, with C65 most likely to interfere with function
#' and C0 least likely.
#'
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
#' @param sort Whether to sort the output by `gd`, or not. Default is `FALSE`.
#' @param keep_self Whether to keep those results in the output that correspond
#'   to residues being the same in `ref` and `sub`. Default is `TRUE`. But it
#'   will be useful to change it to `FALSE` if want to compare the results with
#'   those provided by <http://agvgd.hci.utah.edu/> that filters them out.
#' @param digits Integer indicating the number of decimal places to be used in
#'   rounding `gv` and `gd` values. Default is `2`. Note that the calculation of
#'   the `prediction` variable won't be affected by rounding of `gv` and `gd`,
#'   as it is calculated prior to the rounding.
#'
#' @return A [tibble][tibble::tibble-package] whose observations refer to the
#'   combination alignment position and amino acid substitution; consists of
#'   seven variables:
#' \describe{
#'   \item{res}{Position of the amino acid residue in the reference protein
#'   (first sequence in the alignment). This position corresponds to `poi` minus
#'   the gaps in the alignment.}
#'   \item{poi}{Position of interest, i.e. the alignment position at which the
#'   amino acid substitution is being assessed.}
#'   \item{ref}{Reference amino acid, i.e. the amino acid in the first sequence
#'   of the alignment, at the position of interest.}
#'   \item{sub}{Amino acid substitution being assessed.}
#'   \item{gv}{Grantham variation score.}
#'   \item{gd}{Grantham difference score.}
#' \item{prediction}{Predicted effect of the amino acid substitution. This is
#' classed as C0, C15, C25, C35, C45, C55, or C65, with C65 most likely to
#' interfere with function and C0 least likely.}
#' }
#'
#' @references
#' - Tavtigian, S.V., Deffenbaugh, A. M., Yin, L., Judkins, T., Scholl, T.,
#' Samollow, P.B., de Silva, D., Zharkikh, A., Thomas, A. _Comprehensive
#' statistical study of 452 BRCA1 missense substitutions with classification of
#' eight recurrent substitutions as neutral_. Journal of Medical Genetics 43,
#' 295--305 (2006). \doi{10.1136/jmg.2005.033878}.
#' - Mathe, E., Olivier, M., Kato, S., Ishioka, C., Hainaut, P., Tavtigian, S.V.
#' _Computational approaches for predicting the biological effect of p53
#' missense mutations: a comparison of three sequence analysis based methods_.
#' Nucleic Acids Research 34, 1317--1325 (2006). \doi{10.1093/nar/gkj518}.
#'
#' @md
#' @importFrom rlang .data
#'
#' @examples
#' # Read an alignment into R, e.g. the alignment for gene ATM.
#' alignment_ATM <- read_alignment(gene = 'ATM')
#'
#' # Predict the impact of changing the first residue (Met) to a Serine (S).
#' agvgd(alignment = alignment_ATM, poi = 1, sub = 'S')
#'
#' # `poi` can be a vector of positions, e.g., 3 thru 10, allow for prediction
#' # of multiple positions at once.
#' agvgd(alignment = alignment_ATM, poi = 3:10, sub = 'S')
#'
#' # `poi` expects a position in the frame of reference of the alignment, i.e.
#' # an alignment position (a column index). However, if you know instead
#' # the residue position in the reference sequence (first sequence in the
#' # alignment), then you may use the function `res_to_poi()`
#' # to convert from residue position to alignment position.
#' #
#' # Example: The second residue in the reference sequence of the ATM alignment
#' # is a Serine, after a Methionine. In the alignment, there is a gap between
#' # the two residues, so the alignment is 3 but the residue position on the
#' # protein is 2.
#' (poi2 <- res_to_poi(alignment_ATM, 2))
#' agvgd(alignment = alignment_ATM, poi = poi2, sub = 'A')
#'
#' # Because changes are context-dependent, i.e. they depend on the residue
#' # variation observed at a given alignment position, the same reference
#' # residue when replaced with the same substitution will in general have
#' # a different predicted impact.
#' agvgd(alignment = alignment_ATM, poi = 9:10, sub = 'S')
#'
#' # Use the ancillary function `amino_acids()` to get a vector of one-letter
#' # residue substitutions if you want to quickly assess the impact of all
#' # possible substitutions.
#' agvgd(alignment = alignment_ATM, poi = 1, sub = amino_acids())
#'
#' # Parameter `mode` gives you flexibility on how to combine `poi` and `sub`.
#' agvgd(alignment = alignment_ATM, poi = 3:4, sub = c('A', 'V'))
#'
#' # Use 'expand_grid' for all combinations.
#' agvgd(alignment = alignment_ATM, poi = 3:4, sub = c('A', 'V'), mode = 'expand_grid')
#'
#' @export
agvgd <- function(alignment,
                  poi,
                  sub,
                  mode = c('recycle', 'expand_grid'),
                  sort = FALSE,
                  keep_self = TRUE,
                  digits = 2L) {

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

  agvgd_output <- purrr::map2_dfr(
    .x = tbl$poi,
    .y = tbl$sub,
    .f = ~ agvgd_(
      alignment = alignment,
      poi = .x,
      sub = .y
    )
  )

  # Rounding of `gv` and `gd`
  agvgd_output <-
    dplyr::mutate(agvgd_output,
                  gv = round(.data$gv, digits = digits),
                  gd = round(.data$gd, digits = digits))

  if(sort) {
    agvgd_output <- dplyr::arrange(agvgd_output, dplyr::desc(.data$gd))
  }

  if (!keep_self) {
    agvgd_output <- dplyr::filter(agvgd_output, .data$ref != .data$sub)
  }

  return(agvgd_output)
}

# `agvgd_()` is where the main logic of Align-GVGD is laid out.
agvgd_ <-
  function(alignment,
           poi,
           sub) {

  check_alignment(alignment)
  check_poi(poi)
  check_substitution(sub)

  alignment_at_poi <- filter_alignment(alignment, poi)

  # Find ranges for `c`, `p` and `v`.
  r <- cpv_ranges(alignment_at_poi)

  # Update min and max values according to the number of gaps
  r <- cpv_ranges_after_gaps(r, alignment_at_poi)

  gv <- gv(
    c_min = r$c_min,
    c_max = r$c_max,
    p_min = r$p_min,
    p_max = r$p_max,
    v_min = r$v_min,
    v_max = r$v_max
  )

  gd <- gd(
    sub,
    c_min = r$c_min,
    c_max = r$c_max,
    p_min = r$p_min,
    p_max = r$p_max,
    v_min = r$v_min,
    v_max = r$v_max
  )

  prediction <- gvgd_to_class(gv, gd)
  ref <- stats::setNames(alignment_at_poi[1, 2], NULL)

  tbl <- tibble::tibble(
    res = poi_to_res(
      alignment = alignment,
      poi = poi),
    poi = poi,
    ref = ref,
    sub = sub,
    gv,
    gd,
    prediction
  )

  return(tbl)

}

check_alignment <- function(alignment) {
  TRUE
}

check_poi <- function(poi) {
  TRUE
}

check_substitution <- function(substitution) {
  TRUE
}
