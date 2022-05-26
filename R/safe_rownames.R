safe_rownames <- function(x) {

  `if`(is.null(rownames(x)),
       sprintf("seq_%03d", seq_len(nrow(x))),
       rownames(x))
}
