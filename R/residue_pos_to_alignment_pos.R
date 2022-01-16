#' Convert a residue position to an alignment position
#'
#' This function converts an residue position to a position in the frame of
#' the alignment.
#'
#' @param alignment An alignment.
#' @param residue_pos A residue position.
#'
#' @return An integer vector of alignment positions corresponding to residue position in the reference
#'   sequence.
#'
#'
#' @export
residue_pos_to_alignment_pos <- function(alignment, residue_pos) {

  is_align_mat <- is_align_mat_class(alignment)

  if(!(is_align_mat || rlang::is_character(alignment)))
    stop('`alignment` must be an alignment or the reference sequence supplied as a character vector.')

  ref_seq <- `if`(is_align_mat_class(alignment), ref_sequence(alignment), alignment)

  # Alignment position referring to non-gaps, i.e. bona fide protein residues.
  alignment_pos <- which(ref_seq != '-')

  # `residue_pos` refers to the ith residue in the protein sequence.
  alignment_pos[residue_pos]

}
