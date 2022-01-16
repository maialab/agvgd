# alignment must be a character matrix of three columns
# middle position is the position of interest
gap_cases <- function(alignment) {

  # column 1: left position to the position of interest
  # column 2: position of interest
  # column 3: right position to the position of interest

  # We remove the align_mat class, in case it exists,
  # such that the subsetting works as usual for an ordinary matrix, i.e.,
  # dropping dimensions when only one column or row is retrieved.
  m <- remove_align_mat_class(alignment)

  # Column 2 is position of interest
  # Any gaps at the position of interest?
  any_gaps <- any(m[, 2] == '-')

  if(!any_gaps) return('case 1')

  # Number of "---"
  # nr_triple_gap <- sum(apply(m, 1, function(x) all(x=='-')))
  # if(identical(nr_triple_gap, 0)) return('single/double gaps')

  is_again_gapped <- again_gapped(m)
  if(!is_again_gapped) return('case 2')
  else return('case 3')

}
