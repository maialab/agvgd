test_that("test `dev()` on single input", {

  expect_equal(dev(0, -2, 2), 0)
  expect_equal(dev(-5, -2, 2), 3)
  expect_equal(dev(6, -2, 2), 4)
  expect_equal(dev(-2, -2, 2), 0)
  expect_equal(dev(2, -2, 2), 0)
  expect_equal(dev(NA_real_, -2, 2), NA_real_)
  expect_equal(dev(-5, NA_real_, 2), NA_real_)
  expect_equal(dev(6, NA_real_, 2), 4)
  expect_equal(dev(-5, -2, NA_real_), 3)
  expect_equal(dev(6, -2, NA_real_), NA_real_)
  expect_equal(dev(0, NA_real_, NA_real_), NA_real_)
  expect_equal(dev(NA_real_, NA_real_, NA_real_), NA_real_)

})

test_that("test `dev()` on vector input", {
  x <- c(0, -5, 6, -2, 2, NA_real_, -5, 6, -5, 6, 0, NA_real_)
  min <- c(-2, -2, -2, -2, -2, -2, NA_real_, NA_real_, -2, -2, NA_real_, NA_real_)
  max <- c(2, 2, 2, 2, 2, 2, 2, 2, NA_real_, NA_real_, NA_real_, NA_real_)
  expect_equal(
    dev(x, min, max),
    c(0, 3, 4, 0, 0, NA_real_, NA_real_, 4, 3, NA_real_, NA_real_, NA_real_)
  )
})
