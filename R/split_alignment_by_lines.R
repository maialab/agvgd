split_by_width <- function(alignment, line_width = 30) {

m <- remove_align_mat_class(alignment)
m2 <- m

i <- rep(seq_len(ncol(m2)), each = line_width, length.out = ncol(m2))
j <- length(unique(i))
jj <- cumsum(rep(j, nrow(m2))) - j

f <- i + rep(jj, each = ncol(m2))

lines <- split(t(m2), f)
lines_collapsed <- lapply(lines, paste0, collapse = '')
m3 <- matrix(lines_collapsed, ncol = j, byrow = TRUE)

return(m3)

}
