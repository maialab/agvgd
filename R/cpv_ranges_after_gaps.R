cpv_ranges_after_gaps <- function(r, alignment) {

  gap_case <- gap_cases(alignment)

  if(identical(gap_case, 'case 1')) return(r)

  if(identical(gap_case, 'case 2')) {
    r$c_min <- 0
    r$c_max <- 3
    r$v_min <- 0
    return(r)
  }

  if(identical(gap_case, 'case 3')) {
    r$c_min <- 0
    r$c_max <- 3
    r$p_min <- 0
    r$p_max <- 14
    r$v_min <- 0
    r$v_max <- 175
    return(r)
  }

}
