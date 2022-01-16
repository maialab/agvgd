are_all_three_letter <- function(x, ignore_case = FALSE, exceptions = character()) {

  exceptions <-
    if(ignore_case) {
      stringr::str_to_title(exceptions)
    } else {
      exceptions
    }

  # `set`: the set of allowed codes (3-letter aa and exceptions)
  set <- c(grantham::amino_acids(), exceptions)

  are_all_three_letter <-
  if(ignore_case) {
    all(stringr::str_to_title(x) %in% set)
  } else {
    all(x %in% set)
  }

  return(are_all_three_letter)
}
