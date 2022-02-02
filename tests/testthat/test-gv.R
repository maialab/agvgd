test_that("basic usage", {
  # Examples taken from Figure 1B in Tavtigian et al. (2006),
  # https://doi.org/10.1136/jmg.2005.033878.
  ex01 <- gv(c_min = 0, c_max = 0, p_min = 5.7, p_max = 5.7, v_min = 105, v_max = 105)
  ex02 <- gv(c_min = 0, c_max = 0, p_min = 4.9, p_max = 5.7, v_min = 111, v_max = 105)
  ex03 <- gv(c_min = 0, c_max = 0, p_min = 4.9, p_max = 5.7, v_min = 105, v_max = 132)

  expect_equal(ex01, 0)
  expect_equal(ex02, 14.3, tolerance = 0.1)
  expect_equal(ex03, 30.3, tolerance = 0.1)
})
