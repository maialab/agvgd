#' Grantham deviation
#'
#' @description
#' This function calculates the Grantham deviation (\eqn{\mathrm{gd}}):
#'
#' \deqn{\mathrm{gd} = \rho \left((\alpha\ \mathrm{dev}^2(c_x, c_{min}, c_{max}) + \beta\ \mathrm{dev}^2(p_x, p_{min}, p_{max}) + \gamma\ \mathrm{dev}^2(v_x, v_{min}, v_{max})\right)^\frac{1}{2}}
#'
#' where \eqn{c_x} is the value for composition \eqn{c} of amino acid \eqn{x},
#' i.e. the atomic weight ratio of hetero (noncarbon) elements in end groups or
#' rings to carbons in the side chain; \eqn{p_x} is the value for polarity
#' \eqn{p} of amino acid \eqn{x}; and, \eqn{v_x} is the value for molecular
#' volume \eqn{v} of amino acid \eqn{x}.
#'
#' \eqn{c_x}, \eqn{p_x} and \eqn{v_x} are looked up in
#' [grantham::amino_acids_properties] based on the amino acid identities passed
#' in `x`. The function \eqn{\mathrm{dev}} is implemented in [dev()]. Remaining
#' variables in the equation are arguments to `gd()` and hence are explained
#' below in the Arguments section.
#'
#' @param x A character vector of one-letter amino acid codes, indicating
#'   missense substitutions.
#' @param c_min Amino acid composition, minimum value.
#' @param c_max Amino acid, composition, maximum value.
#' @param p_min Amino acid polarity, minimum value.
#' @param p_max Amino acid polarity, maximum value.
#' @param v_min Amino acid molecular volume, maximum value.
#' @param v_max Amino acid molecular volume, maximum value.
#' @param alpha The constant \eqn{\alpha} in Grantham's equation. It is the
#'   square inverse of the mean of the composition property.
#' @param beta The constant \eqn{\beta} in Grantham's equation. It is the
#'   square inverse of the mean of the polarity property.
#' @param gamma The constant \eqn{\gamma} in Grantham's equation. It is the
#'   square inverse of the mean of the molecular volume property.
#' @param rho Grantham's distances reported in Table 2, Science (1974).
#'   185(4154): 862--4 by R. Grantham, are scaled by a factor (here named
#'   \eqn{\rho}) such that the mean value of all distances are 100. The `rho`
#'   parameter allows this factor \eqn{\rho} to be changed. By default
#'   \eqn{\rho=50.723}, the same value used by Grantham. This value is
#'   originally mentioned in the caption of Table 2 of the aforementioned paper.
#'
#' @return A numeric vector of Grantham deviations. Each deviation corresponds
#'   to one of the amino acids indicated in `x`.
#'
#' @seealso [gv()], [dev()]
#'
#' @examples
#' gd('S', c_min = 0.39, c_max = 0.74, p_min =4.9, p_max =8.6, v_min = 3, v_max = 32.5)
#'
#' @md
#' @export
gd <-
  function(x,
           c_min,
           c_max,
           p_min,
           p_max,
           v_min,
           v_max,
           alpha = 1.833,
           beta = 0.1018,
           gamma = 0.000399,
           rho = 50.723) {

    x <- as_three_letter(x)
    x_tbl <- tibble::tibble(amino_acid = x)

    x_properties <-
      grantham::amino_acids_properties %>%
      dplyr::right_join(x_tbl, by = 'amino_acid')

    dev_c <- dev(x_properties$c, c_min, c_max)
    dev_p <- dev(x_properties$p, p_min, p_max)
    dev_v <- dev(x_properties$v, v_min, v_max)

    grantham::grantham_equation(
      c_i = 0,
      c_j = dev_c,
      p_i = 0,
      p_j = dev_p,
      v_i = 0,
      v_j = dev_v,
      alpha = alpha,
      beta = beta,
      gamma = gamma,
      rho = rho
    )
  }
