are_all_one_letter <- function(x, ignore_case = FALSE, exceptions = character()) {

  exceptions <-
    if(ignore_case) {
      toupper(exceptions)
    } else {
      exceptions
    }

  # `set`: the set of allowed codes (3-letter aa and exceptions)
  set <- c(grantham::as_one_letter(grantham::amino_acids()), exceptions)

  are_all_one_letter <-
    if(ignore_case) {
      all(toupper(x) %in% set)
    } else {
      all(x %in% set)
    }

  return(are_all_one_letter)
}
