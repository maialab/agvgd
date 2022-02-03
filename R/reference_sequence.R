ref_sequence <- function(alignment) {

  # Alignment as simple matrix
  m <- remove_align_mat_class(alignment)

  # First (reference) sequence in the alignment.
  ref_seq <- m[1, ]

  return(ref_seq)
}
