test_that("matrix_to_list()", {

  m <- matrix(1:12, nrow = 3)
  lst <- matrix_to_list(m)

  col1 <- matrix(1:3, ncol = 1)
  col2 <- matrix(4:6, ncol = 1)
  col3 <- matrix(7:9, ncol = 1)
  col4 <- matrix(10:12, ncol = 1)

  expect_identical(lst, list(col1, col2, col3, col4))

})
