max_seq_length <- function(lst) {
  max(unlist(lapply(lst, length)))
}
