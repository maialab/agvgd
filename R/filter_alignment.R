filter_alignment <- function(alignment, poi) {

  m <- remove_align_mat_class(alignment)
  n_row <- nrow(m)
  n_col <- ncol(m)

  n_sequences <- n_row
  if(n_sequences < 1) stop('The alignment should contain at least one sequence.')

  if(!rlang::is_scalar_integerish(poi))
    stop('`poi` must be an alignment position; not ', poi, '.')

  if(poi < 1 || poi > n_col)
    stop('`poi` (', poi,') is out of alignment bounds [1, ', n_col , '].')

  if(m[1, poi] == '-' || m[1, poi] == 'X')
    stop('The amino acid referred to by the position of interest (`poi`) must be one of the 20 standard amino acids; ',
    'cannot be "-", nor "X".')

  # `m2` is a padded version of `m` with X's on both sides of the alignment.
  # This ensures that around the position of interest (poi) we always have an
  # amino acid, even if it's a dummy (unknown) amino acid represented by "X".
  m2 <- cbind('X', m, 'X')

  # Subset the alignment to keep only the position of interest and the two
  # neighbouring amino acids. Please note that because of the prepending of X's
  # in the previous command, the position of interest is now at position `poi` +
  # 1.
  m2[, c(poi, poi + 1, poi + 2), drop = FALSE]

}
