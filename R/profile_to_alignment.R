#' Converts a sequence profile to an alignment
#'
#' This function converts a sequence profile as provided in the format of the
#' package `{protean}` to an `{agvgd}` alignment --- an alignment in this sense
#' is simply a character matrix whose elements are protein residues in
#' one-letter notation, rows are sequences and columns correspond to alignment
#' positions.
#'
#' @param profile A sequence profile object as returned by
#'   `protean::read_profile()` or `protean::get_profile()`. See the `{protean}`
#'   package at <https://github.com/maialab/protean>.
#'
#' @return An alignment object, i.e. a character matrix whose elements are
#'   protein residues in one-letter notation. Rows are sequences and columns are
#'   alignment positions.
#'
#' @md
#' @export
profile_to_alignment <- function(profile) {

  n_orthologs <- nrow(profile)
  n_sequences <- n_orthologs + 1 # + 1 for the human sequence

  seq <-
    c(
      profile$human_profile_seq[1],
      profile$ortho_profile_seq
    )

  row_names <- paste(
    c(
      'homo_sapiens',
      profile$ortho_species
    ),
    c(
      profile$human_prot_id[1],
      profile$ortho_prot_id
    ),
    sep = "_"
  )

  seq_vec <- unlist(strsplit(seq, split = ""))
  m <- matrix(seq_vec, nrow = n_sequences, byrow = TRUE)
  rownames(m) <- row_names

  alignment <- add_align_mat_class(m)

  alignment

}
