# If the position is again gapped in more distantly related species, and if the
# positions immediately before and immediately after the position of interest
# are also gapped (column 1, page 297, 10.1136/jmg.2005.033878)
again_gapped <- function(m) {

  # At the position of interest (poi), which sequences contain a gap?
  gap_at_poi <- which(m[, 2] == '-')

  # Which sequences contain a gap at the position of interest and at the
  # flanking positions
  triple_gap <- which(apply(m, 1, function(x) all(x=='-')))

  df <- expand.grid(gap_at_poi = gap_at_poi, triple_gap = triple_gap)

  # Determine if a gap at the position of interest precedes a triple gap
  is_again_gapped <- any(df$gap_at_poi < df$triple_gap)

  return(is_again_gapped)
}
