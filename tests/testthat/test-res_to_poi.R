test_that("res_to_poi()", {

  align <- read_alignment('ATM')
  m <- as.matrix(read_alignment('ATM'))

  expected <- c(1, 3, 4)

  expect_equal(res_to_poi(alignment = m, res = 1:3), expected)

})

test_that("alignment must be of type character", {

  a <- array('S', dim = c(2,2,2))
  m <- matrix(1:10)
  v <- 1:10
  expect_error(res_to_poi(alignment = m, res = 1:3))
  expect_error(res_to_poi(alignment = v, res = 1:3))
  expect_error(res_to_poi(alignment = a, res = 1:3))
})
