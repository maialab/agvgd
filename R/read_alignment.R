#' Read a protein sequence multiple alignment
#'
#' Reads a protein sequence multiple alignment (PSMA) from either a set of
#' pre-bundled alignments, by gene name, or from a Multi-FASTA file.
#'
#' @param gene The gene name for which an alignment is provided with this
#'   package. Use the function [alignment_file()] to list the pre-bundled
#'   alignments.
#' @param file The path to a Multi-FASTA file. If this argument is given, it
#'   takes precedence over the `gene` parameter.
#'
#' @return An alignment object; essentially, a character matrix, whose elements
#'   are protein residues in one-letter notation. Rows are sequences and columns
#'   are alignment positions.
#'
#' @md
#' @examples
#' # Read in the alignment for the gene XRCC2
#' read_alignment('XRCC2')
#'
#' # Also read in the alignment for the gene XRCC2, but now by specifying
#' # directly the path to the file.
#' path <- system.file("extdata", alignment_file("XRCC2"), package = "agvgd")
#' read_alignment(file = path)
#'
#' @export
read_alignment <-
  function(gene = c(
    'ATM',
    'BRCA1',
    'BRCA2',
    'CHEK2',
    'MRE11',
    'MSH6',
    'NBN',
    'PALB2',
    'PMS2',
    'RAD50',
    'RAD51',
    'XRCC2'
  ),
  file = NULL) {

    if(is.null(file)) {
      gene <- match.arg(gene)
      align_file <- alignment_file(gene)
      file <- system.file("extdata", align_file, package = "agvgd", mustWork = TRUE)
    }

    # Read the alignment as a list of sequences --- sequences are character
    # vectors where each vector element is a single amino acid (one-letter
    # notation)
    alignment <- seqinr::read.fasta(file = file, seqtype = 'AA')

    # Find the longest sequence amongst the various sequences in the alignment
    max_len <- max_seq_length(alignment)

    # In `alignment_fixed_length` all sequences have been padded with gaps and
    # have the same final length (equal to the longest sequence in the alignment)
    alignment_fixed_length <- lapply(alignment, gap_padding, max_len)

    # Number of sequences in the alignment
    number_of_sequences <- length(alignment_fixed_length)

    # Convert alignment (list) to a matrix
    alignment_m <- matrix(
      data = unlist(alignment_fixed_length),
      byrow = TRUE,
      nrow = number_of_sequences)

    rownames(alignment_m) <- names(alignment_fixed_length)

    # Set the class of this alignment matrix
    alignment_m <- add_align_mat_class(alignment_m)

    return(alignment_m)
  }
