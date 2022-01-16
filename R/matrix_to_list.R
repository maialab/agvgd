matrix_to_list <- function(m) {

  lapply(seq_len(ncol(m)), function(i) m[, i, drop = FALSE])
}
