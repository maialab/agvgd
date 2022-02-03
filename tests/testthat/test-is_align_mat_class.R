test_that("is_align_mat_class", {

  m <- matrix('S', nrow = 2, ncol = 2)
  expect_false(is_align_mat_class(m))
  expect_true(is_align_mat_class(add_align_mat_class(m)))

})
