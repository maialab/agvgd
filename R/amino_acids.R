#' The 20 standard amino acids
#'
#' The 20 amino acids that are encoded directly by the codons of the universal
#' genetic code.
#'
#' @param code The type of amino acid symbol to be returned, one-letter
#'   (`one_letter`) or three-letter (`three_letter`) codes.
#'
#' @return A character vector of the 20 standard amino acids.
#'
#' @examples
#' # By default `amino_acids` returns one-letter symbols
#' amino_acids()
#'
#' # Use code = 'three_letter' instead for three-letter symbols
#' amino_acids(code = 'three_letter')
#'
#' @export
amino_acids <- function(code = c('one_letter', 'three_letter')) {

  code <- match.arg(code)
  if(identical(code, 'one_letter')) {
    aa <- grantham::as_one_letter(grantham::amino_acids())
  } else {
    aa <- grantham::amino_acids()
  }

  return(aa)
}
