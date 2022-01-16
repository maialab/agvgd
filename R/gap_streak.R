max_gap_streak <- function(x) {

  streaks <- rle(x)
  max_length <- streaks$lengths[streaks$values == '-'  & !is.na(streaks$values)]
  if(identical(length(max_length), 0L)) return(0)
  else return(max(max_length))

}
