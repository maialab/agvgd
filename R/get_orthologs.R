#' get_ <- function(resource, ...) {
#'   params <- list(
#'     ...
#'   )
#'
#'   # Convert logical parameters to character with values "True" and "False"
#'   # params <- lapply(params, function(x) {`if`(is.logical(x), logical_to_character(x), x)})
#'
#'   base_url <- 'https://rest.ensembl.org/'
#'
#'   httr2::request(base_url) %>%
#'     httr2::req_url_path_append(resource) %>%
#'     httr2::req_url_query(!!!params) %>%
#'     httr2::req_headers(Accept = 'application/json') %>%
#'     httr2::req_user_agent("R package agvgd (https://maialab.org/agvgd)") %>%
#'     httr2::req_perform() %>%
#'     httr2::resp_body_string(encoding = "UTF-8")
#' }
#'
#' get <- memoise::memoise(get_)
#'
#' # Non-vectorised version of `get_orthologue_sequences()`
#' get_orthologue_sequences_ <- function(symbol) {
#'
#'   resource <- glue::glue("/homology/symbol/human/{symbol}")
#'   resp <- get(resource = resource, type = "orthologues", sequence = "protein")
#'
#'   tbl <-
#'   resp %>%
#'     tidyjson::enter_object("data") %>%
#'     tidyjson::gather_array() %>%
#'     dplyr::select(- "array.index") %>%
#'     tidyjson::enter_object("homologies") %>%
#'     tidyjson::gather_array() %>%
#'     tidyjson::spread_all()
#'
#'   # `source_protein_id` is the human protein id repeated for each orthologue
#'   # so any element (here we get the first element) will do.
#'   species <- c(tbl$source.species[1], tbl$target.species)
#'   protein_id <- c(tbl$source.protein_id[1], tbl$target.protein_id)
#'   sequences <- c(tbl$source.align_seq[1], tbl$target.align_seq)
#'   # Drop gaps from sequences
#'   sequences <- gsub('-', '', sequences)
#'
#'   tibble::tibble(species = species, protein_id = protein_id, sequence = sequences)
#'
#' }
#'
#' #' Get orthologue sequences
#' #'
#' #' This function retrieves the sequences of the orthologue proteins in Ensembl's
#' #' [protein
#' #' tree](https://www.ensembl.org/info/genome/compara/homology_method.html) of
#' #' the gene indicated by its gene symbol (`symbol` argument).
#' #'
#' #' This function communicates with Ensembl's REST API
#' #' [homology/symbol/:species/:symbol](https://rest.ensembl.org/documentation/info/homology_symbol)
#' #' endpoint.
#' #'
#' #' @param symbol A character vector of gene symbols.
#' #' @param format The format of the output. If `chr`, a list of named character
#' #'   vectors is returned. Else, a list of tibbles is returned.
#' #'
#' #' @return A list of vectors of orthologue sequences. The list is named with the
#' #'   names matching the gene symbol. Each element of the list is a character
#' #'   vector comprising the orthologue sequences of the protein tree for the gene
#' #'   symbol queried. The first sequence
#' #'
#' #' @md
#' #' @examples
#' #' \dontrun{
#' #' get_orthologue_sequences(c("BRCA1", "BRCA2"))
#' #'
#' #' get_orthologue_sequences(c("BRCA1", "BRCA2"), format = 'tbl')
#' #' }
#' #' @export
#' get_orthologue_sequences <- function(symbol, format = c('chr', 'tbl')) {
#'
#'   format <- match.arg(format)
#'
#'   lst <- purrr::map(symbol, get_orthologue_sequences_)
#'   # Add the gene symbols as names to the list
#'   nm_lst <- stats::setNames(lst, nm = symbol)
#'
#'   if (identical(format, 'chr')) {
#'     nm_lst <- purrr::map(nm_lst, ~ stats::setNames(.x$sequence, nm = glue::glue("{.x$species}_{.x$protein_id}")))
#'   }
#'
#'   return(nm_lst)
#'
#' }
