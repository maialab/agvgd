seq_names <- function(alignment) {

  seq_names <- rownames(alignment)
  automatic_names <- paste0("seq_", sprintf("%02d", seq_len(nrow(alignment))))

  if(is.null(seq_names)) {
    seq_names <- automatic_names
  }

  # In case there are any missing sequence names we replace them with
  # dummy names: seq_01, etc..
  seq_names[is.na(seq_names)] <- automatic_names[is.na(seq_names)]

  return(seq_names)

}

#' Export an alignment to FASTA
#'
#' This function takes an alignment and exports it to a FASTA file.
#'
#' @param alignment An alignment. It may be a simple matrix or an object
#'   obtained with `read_alignment()`.
#' @param file A file path.
#'
#' @return This function is run for its side effect of writing a file. But it
#'   returns the file path passed in `file`.
#'
#' @examples
#' \dontshow{
#' .old_wd <- setwd(tempdir())
#' }
#' alignment <- matrix(
#'   c('P', 'M', 'I',
#'     'P', 'I', 'I',
#'     'P', 'L', 'I'),
#'   nrow = 3,
#'   byrow = TRUE
#' )
#'
#' # Export an alignment based on a matrix
#' write_alignment(alignment, "my_alignment.fasta")
#' cat(readLines("my_alignment.fasta"), sep = "\n")
#'
#' # Export one of the bundled alignments
#' write_alignment(read_alignment(gene = 'BRCA1'), "BRCA1.fasta")
#' cat(readLines("BRCA1.fasta")[1:10], sep = "\n")
#'
#' \dontshow{
#' setwd(.old_wd)
#' }
#' @md
#' @export
write_alignment <- function(alignment, file) {

  identifier_lines <- paste0(">", seq_names(alignment))
  sequences <- apply(X = alignment, MARGIN = 1L, FUN = paste0, collapse = "")
  sequences_choppped <- lapply(sequences, str_chop)
  sequences_as_paragraphs <- lapply(sequences_choppped , paste0, collapse = "\n")
  text <- paste(identifier_lines, sequences_as_paragraphs, sep = "\n")

  writeLines(text, file)

  return(file)
}
