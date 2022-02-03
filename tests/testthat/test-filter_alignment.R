test_that("filter_alignment() errors", {

  empty_m <- matrix()
  expect_error(filter_alignment(empty_m))

  no_rows <- matrix(character())
  expect_error(filter_alignment(no_rows))

  m <- matrix(NA_character_, nrow = 2, ncol = 2)
  expect_error(filter_alignment(m, poi = '2'))

  expect_error(filter_alignment(m, poi = 0))
  expect_error(filter_alignment(m, poi = 3))

  m1 <- matrix(c('S', 'S', '-', 'S', 'S', 'S'), nrow = 2, ncol = 3)
  expect_error(filter_alignment(m1, poi = 2))

  m2 <- matrix(c('S', 'S', 'X', 'S', 'S', 'S'), nrow = 2, ncol = 3)
  expect_error(filter_alignment(m2, poi = 2))

})

test_that("filter_alignment() expected behaviour", {

  m <- matrix('S', nrow = 2, ncol = 3)
  expect_equal(filter_alignment(m, 2), m)
  expect_equal(filter_alignment(m, 1), cbind('X', m[, 2:3]))
  expect_equal(filter_alignment(m, 3), cbind(m[, 1:2], 'X'))

})
