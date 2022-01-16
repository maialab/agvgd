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
#' `agvgd()` and `align_gvgd()` are synonyms.
#'
#' @param alignment A character matrix or an alignment object obtained with
#'   [read_alignment()]. Rows are expected to be sequences of single characters
#'   (protein residues), and columns the alignment positions. The first row must
#'   be the reference sequence, i.e. the sequence whose substitutions will be
#'   evaluated against.
#' @param poi A whole number indicating the position of interest (POI).
#' @param substitution A character vector of protein residue substitutions to be
#'   classified. The amino acids must be provided as one-letter symbols.
#' @param sort Whether to sort the output by `gd`, or not. Default is `FALSE`.
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
#' @export
agvgd <-
  function(alignment,
           poi,
           substitution,
           sort = FALSE) {

  check_alignment(alignment)
  check_poi(poi)
  check_substitution(substitution)

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

  substitution <- as_three_letter(substitution)

  gd <- gd(
    substitution,
    c_min = r$c_min,
    c_max = r$c_max,
    p_min = r$p_min,
    p_max = r$p_max,
    v_min = r$v_min,
    v_max = r$v_max
  )

  prediction <- gvgd_to_class(gv, gd)

  tbl <- tibble::tibble(
    res = alignment_pos_to_residue_pos(
      alignment = alignment,
      alignment_pos = poi),
    poi = poi,
    ref = as_three_letter(alignment_at_poi[1, 2]),
    sub = substitution,
    gv,
    gd,
    prediction
  )

  if(sort) {
    tbl <- dplyr::arrange(tbl, dplyr::desc(.data$gd))
  }

  return(tbl)

}

#' @rdname agvgd
#' @export
align_gvgd <- agvgd

check_alignment <- function(alignment) {
  TRUE
}

check_poi <- function(poi) {
  TRUE
}

check_substitution <- function(substitution) {
  TRUE
}
