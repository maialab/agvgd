test_that("poi_to_res()", {

  align <- read_alignment('ATM')
  m <- as.matrix(read_alignment('ATM'))

  expected <- c(1, NA, 2)

  expect_equal(poi_to_res(alignment = m, poi = 1:3), expected)

})

test_that("alignment must be of type character", {

  a <- array('S', dim = c(2,2,2))
  m <- matrix(1:10)
  v <- 1:10
  expect_error(poi_to_res(alignment = m, poi = 1:3))
  expect_error(poi_to_res(alignment = v, poi = 1:3))
  expect_error(poi_to_res(alignment = a, poi = 1:3))

})

