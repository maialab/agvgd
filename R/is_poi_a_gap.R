is_poi_a_gap <- function(alignment, poi) {

  # `res` that are mapped to NAs are so because they were gaps. So we can check
  # for being NA as a proxy for gap positions.
  is.na(poi_to_res(alignment = alignment, poi = poi))
}
