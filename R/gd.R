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
