#' Convert a residue position to an alignment position
#'
#' This function converts an residue position to a position in the frame of
#' the alignment.
#'
#' @param alignment An alignment.
#' @param res A residue position.
#'
#' @return An integer vector of alignment positions corresponding to residue position in the reference
#'   sequence.
#'
#' @examples
#' align_ATM <- read_alignment('ATM')
#' align_ATM[, 1:6]
#'
#' # Convert the positions of the first five residues to alignment positions
#' res_to_poi(align_ATM, 1:5)
#'
#' @export
res_to_poi <- function(alignment, res) {

  if(!rlang::is_character(alignment))
    stop('`alignment` must be an alignment, i.e. a character matrix, or the reference sequence provided as a character vector.')

  if(!(is.matrix(alignment) || is.vector(alignment)))
    stop('`alignment` must be an alignment, i.e. a character matrix, or the reference sequence provided as a character vector.')

  ref_seq <- if(is.matrix(alignment)) ref_sequence(alignment) else alignment
  ref_seq <- if(is.vector(alignment)) alignment else ref_seq

  # Alignment position referring to non-gaps, i.e. bona fide protein residues.
  alignment_pos <- which(ref_seq != '-')

  # `res` refers to the ith residue in the protein sequence.
  alignment_pos[res]

}
