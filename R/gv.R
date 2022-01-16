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
