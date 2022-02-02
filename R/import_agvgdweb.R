#' @importFrom rlang .data
#' @keywords internal
import_agvgdweb <- function(file = stop('`file` is missing')) {

  df <- utils::read.delim(file)
  tbl <- tibble::as_tibble(df)

  tbl %>%
    tidyr::separate(col = .data$Substitution, sep = '', into = c('X', 'ref', 'res', 'sub')) %>%
    dplyr::select(-'X') %>%
    dplyr::mutate(res = as.integer(.data$res)) %>%
    dplyr::rename(gv = .data$GV, gd = .data$GD, prediction = .data$Prediction) %>%
    dplyr::relocate(.data$res, .data$ref, .data$sub, .data$gv, .data$gd, .data$prediction) %>%
    dplyr::mutate(prediction = stringr::str_remove(.data$prediction, '^Class '))

}
