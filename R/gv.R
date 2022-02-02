#' Grantham variation
#'
#' @description
#' This function calculates the Grantham variation (\eqn{\mathrm{gv}}):
#'
#' \deqn{\mathrm{gv} = \rho \left((\alpha (c_{max}-c_{min})^2 + \beta (p_{max}-p_{min})^2 + \gamma (v_{max}-v_{min})^2\right)^\frac{1}{2}}
#'
#' The minimum and maximum values are those observed for a set of amino acid
#' residues at the alignment position of interest.
#'
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
#' @return A numeric vector of grantham variation values.
#'
#' @examples
#' # Example based on values from Figure 1C of Tavtigian et al. (2006),
#' # https://doi.org/10.1136/jmg.2005.033878.
#' gv(c_min = 0, c_max = 0, p_min = 5.7, p_max = 4.9, v_min = 132, v_max = 105)
#'
#' @seealso [gd()], [cpv_ranges()]
#' @md
#' @export
gv <-
  function(c_min,
           c_max,
           p_min,
           p_max,
           v_min,
           v_max,
           alpha = 1.833,
           beta = 0.1018,
           gamma = 0.000399,
           rho = 50.723) {

    grantham::grantham_equation(
      c_i = c_max,
      c_j = c_min,
      p_i = p_max,
      p_j = p_min,
      v_i = v_max,
      v_j = v_min,
      alpha = alpha,
      beta = beta,
      gamma = gamma,
      rho = rho
    )
  }
