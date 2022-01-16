#' Pre-bundled alignments
#'
#' This function returns either a data frame of the pre-bundled alignments if
#' parameter `gene` is missing (default behaviour), or the file name of the
#' alignment of a supplied gene name.
#'
#' @param gene The gene name of one of the pre-bundled alignments. Run
#'   [alignment_file()] to list all genes available.
#'
#' @return Either a data frame of the pre-bundled alignments if parameter `gene`
#'   is missing (default behaviour), or the file name of the alignment of a
#'   supplied gene name.
#'
#' @md
#' @examples
#' # List pre-bundled alignment file names and associated genes
#' alignment_file()
#'
#' # Retrieve the file name of an alignment
#' alignment_file("BRCA1")
#'
#' # You may get the full path to an alignment file with `system.file()`
#' system.file("extdata", alignment_file("BRCA1"), package = "agvgd")
#'
#' @export
alignment_file <- function(gene) {

  files <-
    alignments[c('gene', 'file')] %>%
    dplyr::distinct()

  if(missing(gene)) {
    return(files)
  }

  return(files$file[files$gene == gene])

}
