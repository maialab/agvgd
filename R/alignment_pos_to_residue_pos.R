#' Convert an alignment position to residue position
#'
#' This function converts an alignment position to a position in the frame of
#' the reference protein sequence, i.e., to the positions of the residues in the
#' first sequence of the alignment.
#'
#' @param alignment An alignment.
#' @param alignment_pos An alignment position.
#'
#' @return An integer vector of positions of the residues in the reference
#'   sequence.
#'
#' @export
alignment_pos_to_residue_pos <- function(alignment, alignment_pos) {
  is_align_mat <- is_align_mat_class(alignment)

  if(!(is_align_mat || rlang::is_character(alignment)))
    stop('`alignment` must be an alignment or the reference sequence supplied as a character vector.')

  ref_seq <- `if`(is_align_mat_class(alignment), ref_sequence(alignment), alignment)

  # `residue_pos` is expressed as residue numbers in the reference polypeptide
  # sequence (first sequence in the alignment).
  all_residues_alignment_pos <- which(ref_seq != '-')
  match(alignment_pos, all_residues_alignment_pos)

}
