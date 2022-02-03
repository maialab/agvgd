#' Convert an alignment position to residue position
#'
#' This function converts an alignment position to a position in the frame of
#' the reference protein sequence, i.e., to the positions of the amino acids in
#' the first sequence of the alignment.
#'
#' @param alignment An alignment.
#' @param poi An alignment position.
#'
#' @return An integer vector of positions of the amino acid residues in the
#'   reference sequence.
#'
#' @examples
#' align_ATM <- read_alignment('ATM')
#' align_ATM[, 1:5]
#'
#' # Convert the positions of the first five alignment positions to residue positions
#' poi_to_res(align_ATM, 1:5)
#'
#' @export
poi_to_res <- function(alignment, poi) {

  if(!rlang::is_character(alignment))
    stop('`alignment` must be an alignment, i.e. a character matrix, or the reference sequence provided as a character vector.')

  if(!(is.matrix(alignment) || is.vector(alignment)))
    stop('`alignment` must be an alignment, i.e. a character matrix, or the reference sequence provided as a character vector.')

  ref_seq <- if(is.matrix(alignment)) ref_sequence(alignment) else alignment
  ref_seq <- if(is.vector(alignment)) alignment else ref_seq

  # `residue_pos` is expressed as residue numbers in the reference polypeptide
  # sequence (first sequence in the alignment).
  all_residues_alignment_pos <- which(ref_seq != '-')
  match(poi, all_residues_alignment_pos)

}
